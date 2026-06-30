'use strict';

const express = require('express');
const { body, param } = require('express-validator');
const bcrypt = require('bcryptjs');
const { authMiddleware, requireRole } = require('../../middlewares/auth');
const { validateRequest, createError } = require('../../middlewares/errorHandler');
const db = require('../../config/database');

const router = express.Router();
const ROLES = ['ROLE_SECRETARIO', 'ROLE_ADMIN'];

const UsuarioService = {

  async listarTodos() {
    // No todos los usuarios tienen registro en personas (ej. el admin inicial).
    // Usamos LEFT JOIN y mostramos username como fallback.
    const res = await db.query(`
      SELECT
        u.id_usuario,
        u.username,
        u.correo,
        u.estado,
        u.primer_ingreso,
        u.ultimo_acceso,
        COALESCE(p.nombres, '')   AS nombres,
        COALESCE(p.apellidos, '') AS apellidos,
        COALESCE(p.cedula, '')    AS cedula,
        COALESCE(p.telefono, '')  AS telefono,
        COALESCE(p.cargo, '')     AS cargo,
        COALESCE(p.titulo_academico, '') AS titulo_academico,
        COALESCE(p.especializacion, '')  AS especializacion,
        COALESCE(
          (SELECT array_agg(r.nombre ORDER BY r.nombre)
           FROM sga_principal.usuario_roles ur
           JOIN sga_principal.roles r ON r.id_rol = ur.id_rol
           WHERE ur.id_usuario = u.id_usuario),
          ARRAY[]::varchar[]
        ) AS roles
      FROM sga_principal.usuarios u
      LEFT JOIN sga_principal.personas p ON p.id_usuario = u.id_usuario
      WHERE u.estado = true
      ORDER BY COALESCE(p.apellidos, u.username), COALESCE(p.nombres, '')
    `);
    return res.rows;
  },

  async obtenerPorId(id) {
    const res = await db.query(`
      SELECT
        u.id_usuario, u.username, u.correo, u.estado,
        u.primer_ingreso, u.ultimo_acceso, u.fecha_creacion,
        COALESCE(p.nombres, '')   AS nombres,
        COALESCE(p.apellidos, '') AS apellidos,
        COALESCE(p.cedula, '')    AS cedula,
        COALESCE(p.telefono, '')  AS telefono,
        COALESCE(p.cargo, '')     AS cargo,
        COALESCE(p.titulo_academico, '') AS titulo_academico,
        COALESCE(p.especializacion, '')  AS especializacion,
        COALESCE(
          (SELECT array_agg(r.nombre ORDER BY r.nombre)
           FROM sga_principal.usuario_roles ur
           JOIN sga_principal.roles r ON r.id_rol = ur.id_rol
           WHERE ur.id_usuario = u.id_usuario),
          ARRAY[]::varchar[]
        ) AS roles
      FROM sga_principal.usuarios u
      LEFT JOIN sga_principal.personas p ON p.id_usuario = u.id_usuario
      WHERE u.id_usuario = $1
    `, [id]);
    if (!res.rows.length) throw createError(404, 'Usuario no encontrado');
    return res.rows[0];
  },

  async crear(dto) {
    const dup = await db.query(
      'SELECT id_usuario FROM sga_principal.usuarios WHERE username = $1 OR correo = $2',
      [dto.username, dto.correo]
    );
    if (dup.rows.length) throw createError(409, 'Username o correo ya existe');

    const tempPass = `${dto.nombres.split(' ')[0].toLowerCase()}${new Date().getFullYear()}`;
    const hash = await bcrypt.hash(tempPass, 12);

    const client = await db.getClient();
    try {
      await client.query('BEGIN');

      const uRes = await client.query(
        `INSERT INTO sga_principal.usuarios (username, correo, password_hash, estado, primer_ingreso)
         VALUES ($1, $2, $3, true, true) RETURNING id_usuario`,
        [dto.username, dto.correo, hash]
      );
      const idUsuario = uRes.rows[0].id_usuario;

      // Crear persona solo si hay datos personales
      if (dto.nombres && dto.apellidos) {
        await client.query(
          `INSERT INTO sga_principal.personas
             (id_usuario, cedula, nombres, apellidos, telefono, cargo,
              titulo_academico, especializacion, correo_personal)
           VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9)`,
          [
            idUsuario,
            dto.cedula || null,
            dto.nombres,
            dto.apellidos,
            dto.telefono || null,
            dto.cargo || null,
            dto.titulo_academico || null,
            dto.especializacion || null,
            dto.correo || null,
          ]
        );
      }

      // Asignar roles por nombre
      if (dto.roles && dto.roles.length) {
        for (const rolNombre of dto.roles) {
          const rRes = await client.query(
            'SELECT id_rol FROM sga_principal.roles WHERE nombre = $1 AND activo = true',
            [rolNombre]
          );
          if (rRes.rows.length) {
            await client.query(
              'INSERT INTO sga_principal.usuario_roles (id_usuario, id_rol) VALUES ($1,$2) ON CONFLICT DO NOTHING',
              [idUsuario, rRes.rows[0].id_rol]
            );
          }
        }
      }

      await client.query('COMMIT');
      const created = await this.obtenerPorId(idUsuario);
      return { ...created, temp_password: tempPass };
    } catch (e) {
      await client.query('ROLLBACK');
      throw e;
    } finally {
      client.release();
    }
  },

  async resetearPassword(id) {
    const u = await this.obtenerPorId(id);
    const nombre = u.nombres?.split(' ')[0] || u.username;
    const tempPass = `${nombre.toLowerCase()}${new Date().getFullYear()}`;
    const hash = await bcrypt.hash(tempPass, 12);
    await db.query(
      `UPDATE sga_principal.usuarios SET
         password_hash = $1, primer_ingreso = true,
         intentos_fallidos = 0, bloqueado_hasta = NULL,
         fecha_actualizacion = NOW()
       WHERE id_usuario = $2`,
      [hash, id]
    );
    return { temp_password: tempPass };
  },

  async cambiarEstado(id, estado) {
    await this.obtenerPorId(id);
    await db.query(
      'UPDATE sga_principal.usuarios SET estado = $1, fecha_actualizacion = NOW() WHERE id_usuario = $2',
      [estado, id]
    );
  },

  async listarRoles() {
    const res = await db.query(
      'SELECT id_rol, nombre, descripcion FROM sga_principal.roles WHERE activo = true ORDER BY nombre'
    );
    return res.rows;
  },

  async asignarRoles(id, roles) {
    await this.obtenerPorId(id);
    const client = await db.getClient();
    try {
      await client.query('BEGIN');
      await client.query('DELETE FROM sga_principal.usuario_roles WHERE id_usuario = $1', [id]);
      for (const rolNombre of roles) {
        const rRes = await client.query(
          'SELECT id_rol FROM sga_principal.roles WHERE nombre = $1', [rolNombre]
        );
        if (rRes.rows.length) {
          await client.query(
            'INSERT INTO sga_principal.usuario_roles (id_usuario, id_rol) VALUES ($1,$2)',
            [id, rRes.rows[0].id_rol]
          );
        }
      }
      await client.query('COMMIT');
    } catch (e) {
      await client.query('ROLLBACK');
      throw e;
    } finally {
      client.release();
    }
  },
};

// ── RUTAS ──────────────────────────────────────
router.use(authMiddleware, requireRole(...ROLES));

router.get('/', async (req, res, next) => {
  try {
    res.json(await UsuarioService.listarTodos());
  } catch (e) {
    console.error('[usuarios] GET /', e.message);
    next(e);
  }
});

router.get('/roles', async (req, res, next) => {
  try { res.json(await UsuarioService.listarRoles()); } catch (e) { next(e); }
});

router.get('/:id', param('id').isInt(), validateRequest, async (req, res, next) => {
  try { res.json(await UsuarioService.obtenerPorId(req.params.id)); } catch (e) { next(e); }
});

router.post('/',
  [
    body('username').notEmpty().withMessage('Username requerido'),
    body('correo').isEmail().withMessage('Correo inválido'),
    body('nombres').notEmpty().withMessage('Nombres requeridos'),
    body('apellidos').notEmpty().withMessage('Apellidos requeridos'),
    body('roles').optional().isArray(),
  ],
  validateRequest,
  async (req, res, next) => {
    try {
      res.status(201).json(await UsuarioService.crear(req.body));
    } catch (e) { next(e); }
  }
);

router.patch('/:id/reset-password', param('id').isInt(), validateRequest, async (req, res, next) => {
  try { res.json(await UsuarioService.resetearPassword(req.params.id)); } catch (e) { next(e); }
});

router.patch('/:id/estado',
  param('id').isInt(),
  body('estado').isBoolean(),
  validateRequest,
  async (req, res, next) => {
    try {
      await UsuarioService.cambiarEstado(req.params.id, req.body.estado);
      res.status(204).send();
    } catch (e) { next(e); }
  }
);

router.patch('/:id/roles',
  param('id').isInt(),
  body('roles').isArray(),
  validateRequest,
  async (req, res, next) => {
    try {
      await UsuarioService.asignarRoles(req.params.id, req.body.roles);
      res.status(204).send();
    } catch (e) { next(e); }
  }
);

module.exports = { router, UsuarioService };
