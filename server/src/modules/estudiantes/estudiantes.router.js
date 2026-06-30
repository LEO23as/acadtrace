'use strict';

const express = require('express');
const { body, param } = require('express-validator');
const { authMiddleware, requireRole } = require('../../middlewares/auth');
const { validateRequest, createError } = require('../../middlewares/errorHandler');
const db = require('../../config/database');

const router = express.Router();
const ROLES = ['ROLE_SECRETARIO', 'ROLE_ADMIN'];

const estudianteBody = [
  body('cedula').optional({ checkFalsy: true }).isString(),
  body('nombres').notEmpty().withMessage('Nombres requeridos'),
  body('apellidos').notEmpty().withMessage('Apellidos requeridos'),
  body('fecha_nacimiento').optional({ checkFalsy: true }).isDate(),
  body('genero').optional({ checkFalsy: true }).isIn(['MASCULINO', 'FEMENINO', 'OTRO']),
  body('correo').optional({ checkFalsy: true }).isEmail(),
];

const EstudianteService = {

  async listarTodos({ search, page = 1, limit = 20 }) {
    const offset = (parseInt(page) - 1) * parseInt(limit);
    const params = [];
    let whereExtra = '';

    if (search) {
      const like = `%${search}%`;
      params.push(like, like, like, like);
      whereExtra = ` AND (
        e.nombres ILIKE $1 OR e.apellidos ILIKE $2
        OR e.cedula ILIKE $3 OR e.codigo_estudiante ILIKE $4
      )`;
    }

    const countSql = `SELECT COUNT(*) FROM sga_principal.estudiantes e WHERE e.estado = true${whereExtra}`;
    const countRes = await db.query(countSql, params);
    const total = parseInt(countRes.rows[0].count);

    const limitParam = params.length + 1;
    const offsetParam = params.length + 2;
    params.push(parseInt(limit), offset);

    const sql = `
      SELECT e.id_estudiante, e.cedula, e.codigo_estudiante,
             e.nombres, e.apellidos, e.fecha_nacimiento, e.genero,
             e.correo, e.telefono, e.discapacidad, e.estado,
             r.nombres  AS rep_nombres,
             r.apellidos AS rep_apellidos,
             r.telefono_principal AS rep_telefono,
             r.parentesco
      FROM sga_principal.estudiantes e
      LEFT JOIN sga_principal.representantes r ON r.id_representante = e.id_representante
      WHERE e.estado = true${whereExtra}
      ORDER BY e.apellidos, e.nombres
      LIMIT $${limitParam} OFFSET $${offsetParam}
    `;
    const res = await db.query(sql, params);

    return {
      data: res.rows,
      meta: {
        total,
        page: parseInt(page),
        limit: parseInt(limit),
        pages: Math.ceil(total / parseInt(limit)),
      },
    };
  },

  async obtenerPorId(id) {
    const res = await db.query(
      `SELECT e.*,
              r.nombres  AS rep_nombres,
              r.apellidos AS rep_apellidos,
              r.cedula   AS rep_cedula,
              r.telefono_principal AS rep_telefono,
              r.correo   AS rep_correo,
              r.parentesco,
              f.tipo_sangre, f.alergias, f.medicacion_permanente,
              f.enfermedad_catastrofica, f.detalle_enfermedad,
              f.contacto_emergencia, f.telefono_emergencia
       FROM sga_principal.estudiantes e
       LEFT JOIN sga_principal.representantes r ON r.id_representante = e.id_representante
       LEFT JOIN sga_principal.fichas_estudiante f ON f.id_estudiante = e.id_estudiante
       WHERE e.id_estudiante = $1`,
      [id]
    );
    if (!res.rows.length) throw createError(404, 'Estudiante no encontrado');
    return res.rows[0];
  },

  async crear(dto, username) {
    if (dto.cedula) {
      const dup = await db.query(
        'SELECT id_estudiante FROM sga_principal.estudiantes WHERE cedula = $1',
        [dto.cedula]
      );
      if (dup.rows.length) throw createError(409, 'Ya existe un estudiante con esa cédula');
    }

    const u = await db.query(
      'SELECT id_usuario FROM sga_principal.usuarios WHERE username = $1',
      [username]
    );
    const creadoPor = u.rows[0]?.id_usuario || null;

    const last = await db.query(
      `SELECT codigo_estudiante FROM sga_principal.estudiantes
       WHERE codigo_estudiante IS NOT NULL ORDER BY id_estudiante DESC LIMIT 1`
    );
    let codigo = 'EST-0001';
    if (last.rows.length) {
      const parts = last.rows[0].codigo_estudiante?.split('-');
      const num = parseInt(parts?.[1] || '0') + 1;
      codigo = `EST-${String(num).padStart(4, '0')}`;
    }

    const res = await db.query(
      `INSERT INTO sga_principal.estudiantes
         (cedula, codigo_estudiante, nombres, apellidos, fecha_nacimiento,
          genero, direccion, telefono, correo, discapacidad,
          tipo_discapacidad, porcentaje_disc, id_representante, creado_por, estado)
       VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14, true)
       RETURNING *`,
      [
        dto.cedula || null,
        codigo,
        dto.nombres,
        dto.apellidos,
        dto.fecha_nacimiento || null,
        dto.genero || null,
        dto.direccion || null,
        dto.telefono || null,
        dto.correo || null,
        dto.discapacidad || false,
        dto.tipo_discapacidad || null,
        dto.porcentaje_disc ? parseInt(dto.porcentaje_disc) : null,
        dto.id_representante || null,
        creadoPor,
      ]
    );
    return res.rows[0];
  },

  async actualizar(id, dto) {
    await this.obtenerPorId(id);
    const res = await db.query(
      `UPDATE sga_principal.estudiantes SET
         cedula             = COALESCE($1, cedula),
         nombres            = COALESCE($2, nombres),
         apellidos          = COALESCE($3, apellidos),
         fecha_nacimiento   = COALESCE($4, fecha_nacimiento),
         genero             = COALESCE($5::sga_principal.genero_t, genero),
         direccion          = COALESCE($6, direccion),
         telefono           = COALESCE($7, telefono),
         correo             = COALESCE($8, correo),
         discapacidad       = COALESCE($9, discapacidad),
         tipo_discapacidad  = COALESCE($10, tipo_discapacidad),
         porcentaje_disc    = COALESCE($11, porcentaje_disc),
         id_representante   = COALESCE($12, id_representante),
         fecha_actualizacion = NOW()
       WHERE id_estudiante = $13
       RETURNING *`,
      [
        dto.cedula || null,
        dto.nombres || null,
        dto.apellidos || null,
        dto.fecha_nacimiento || null,
        dto.genero || null,
        dto.direccion || null,
        dto.telefono || null,
        dto.correo || null,
        dto.discapacidad ?? null,
        dto.tipo_discapacidad || null,
        dto.porcentaje_disc ? parseInt(dto.porcentaje_disc) : null,
        dto.id_representante || null,
        id,
      ]
    );
    return res.rows[0];
  },

  async cambiarEstado(id, estado) {
    await this.obtenerPorId(id);
    await db.query(
      'UPDATE sga_principal.estudiantes SET estado = $1, fecha_actualizacion = NOW() WHERE id_estudiante = $2',
      [estado, id]
    );
  },
};

// ── RUTAS ──────────────────────────────────────
router.use(authMiddleware, requireRole(...ROLES));

router.get('/', async (req, res, next) => {
  try {
    const result = await EstudianteService.listarTodos({
      search: req.query.q,
      page: req.query.page || 1,
      limit: req.query.limit || 15,
    });
    res.json(result);
  } catch (e) {
    console.error('[estudiantes] GET /', e.message);
    next(e);
  }
});

router.get('/:id', param('id').isInt(), validateRequest, async (req, res, next) => {
  try {
    res.json(await EstudianteService.obtenerPorId(req.params.id));
  } catch (e) { next(e); }
});

router.post('/', estudianteBody, validateRequest, async (req, res, next) => {
  try {
    res.status(201).json(await EstudianteService.crear(req.body, req.user.username));
  } catch (e) { next(e); }
});

router.put('/:id', param('id').isInt(), estudianteBody, validateRequest, async (req, res, next) => {
  try {
    res.json(await EstudianteService.actualizar(req.params.id, req.body));
  } catch (e) { next(e); }
});

router.patch('/:id/estado',
  param('id').isInt(),
  body('estado').isBoolean(),
  validateRequest,
  async (req, res, next) => {
    try {
      await EstudianteService.cambiarEstado(req.params.id, req.body.estado);
      res.status(204).send();
    } catch (e) { next(e); }
  }
);

module.exports = router;
