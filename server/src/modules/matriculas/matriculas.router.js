'use strict';

const express = require('express');
const { body, param } = require('express-validator');
const { authMiddleware, requireRole } = require('../../middlewares/auth');
const { validateRequest, createError } = require('../../middlewares/errorHandler');
const db = require('../../config/database');

const router = express.Router();
const ROLES = ['ROLE_SECRETARIO', 'ROLE_ADMIN'];

// ──────────────────────────────────────────────
// SERVICIO
// ──────────────────────────────────────────────
const MatriculaService = {

  async listarPorAnoLectivo(idAnoLectivo, { page = 1, limit = 30, search } = {}) {
    const offset = (page - 1) * limit;
    let where = 'WHERE m.id_ano_lectivo = $1';
    const params = [idAnoLectivo];

    if (search) {
      params.push(`%${search}%`);
      where += ` AND (e.nombres ILIKE $${params.length} OR e.apellidos ILIKE $${params.length} OR e.cedula ILIKE $${params.length})`;
    }

    const countRes = await db.query(
      `SELECT COUNT(*) FROM sga_principal.matriculas m
       JOIN sga_principal.estudiantes e ON e.id_estudiante = m.id_estudiante
       ${where}`,
      params
    );
    const total = parseInt(countRes.rows[0].count);

    params.push(limit, offset);
    const res = await db.query(
      `SELECT m.id_matricula, m.numero_orden, m.fecha_registro, m.estado, m.observaciones,
              e.id_estudiante, e.cedula, e.codigo_estudiante,
              e.nombres || ' ' || e.apellidos AS estudiante,
              g.nombre AS grado, p.letra AS paralelo,
              al.nombre AS ano_lectivo,
              u.username AS registrado_por
       FROM sga_principal.matriculas m
       JOIN sga_principal.estudiantes e ON e.id_estudiante = m.id_estudiante
       JOIN sga_principal.grados g ON g.id_grado = m.id_grado
       JOIN sga_principal.paralelos p ON p.id_paralelo = m.id_paralelo
       JOIN sga_principal.anos_lectivos al ON al.id_ano_lectivo = m.id_ano_lectivo
       LEFT JOIN sga_principal.usuarios u ON u.id_usuario = m.registrado_por
       ${where}
       ORDER BY g.orden, p.letra, e.apellidos
       LIMIT $${params.length - 1} OFFSET $${params.length}`,
      params
    );

    return {
      data: res.rows,
      meta: { total, page: parseInt(page), limit: parseInt(limit), pages: Math.ceil(total / limit) },
    };
  },

  async listarPorEstudiante(idEstudiante) {
    const res = await db.query(
      `SELECT m.id_matricula, m.numero_orden, m.fecha_registro, m.estado,
              g.nombre AS grado, p.letra AS paralelo,
              al.nombre AS ano_lectivo, al.fecha_inicio, al.fecha_fin,
              hp.resultado AS resultado_promocion, hp.promedio_anual
       FROM sga_principal.matriculas m
       JOIN sga_principal.grados g ON g.id_grado = m.id_grado
       JOIN sga_principal.paralelos p ON p.id_paralelo = m.id_paralelo
       JOIN sga_principal.anos_lectivos al ON al.id_ano_lectivo = m.id_ano_lectivo
       LEFT JOIN sga_principal.historial_promocion hp ON hp.id_matricula = m.id_matricula
       WHERE m.id_estudiante = $1
       ORDER BY al.fecha_inicio DESC`,
      [idEstudiante]
    );
    return res.rows;
  },

  async obtenerPorId(id) {
    const res = await db.query(
      `SELECT m.*,
              e.nombres || ' ' || e.apellidos AS estudiante,
              e.cedula, e.codigo_estudiante,
              g.nombre AS grado, p.letra AS paralelo,
              al.nombre AS ano_lectivo,
              u.username AS registrado_por
       FROM sga_principal.matriculas m
       JOIN sga_principal.estudiantes e ON e.id_estudiante = m.id_estudiante
       JOIN sga_principal.grados g ON g.id_grado = m.id_grado
       JOIN sga_principal.paralelos p ON p.id_paralelo = m.id_paralelo
       JOIN sga_principal.anos_lectivos al ON al.id_ano_lectivo = m.id_ano_lectivo
       LEFT JOIN sga_principal.usuarios u ON u.id_usuario = m.registrado_por
       WHERE m.id_matricula = $1`,
      [id]
    );
    if (!res.rows.length) throw createError(404, 'Matrícula no encontrada');
    return res.rows[0];
  },

  async crear(dto, username) {
    // Validar que no esté ya matriculado en ese año
    const dup = await db.query(
      `SELECT id_matricula FROM sga_principal.matriculas
       WHERE id_estudiante = $1 AND id_ano_lectivo = $2`,
      [dto.id_estudiante, dto.id_ano_lectivo]
    );
    if (dup.rows.length) throw createError(409, 'El estudiante ya tiene matrícula en ese año lectivo');

    // Obtener usuario
    const u = await db.query(
      'SELECT id_usuario FROM sga_principal.usuarios WHERE username = $1',
      [username]
    );
    const registradoPor = u.rows[0]?.id_usuario || null;

    // Calcular número de orden
    const last = await db.query(
      `SELECT COALESCE(MAX(numero_orden), 0) AS max_orden
       FROM sga_principal.matriculas WHERE id_ano_lectivo = $1`,
      [dto.id_ano_lectivo]
    );
    const numeroOrden = parseInt(last.rows[0].max_orden) + 1;

    const res = await db.query(
      `INSERT INTO sga_principal.matriculas
         (id_estudiante, id_grado, id_paralelo, id_ano_lectivo,
          numero_orden, fecha_registro, estado, observaciones, registrado_por)
       VALUES ($1,$2,$3,$4,$5,CURRENT_DATE,$6,$7,$8)
       RETURNING *`,
      [
        dto.id_estudiante,
        dto.id_grado,
        dto.id_paralelo,
        dto.id_ano_lectivo,
        numeroOrden,
        dto.estado || 'ACTIVA',
        dto.observaciones || null,
        registradoPor,
      ]
    );
    return this.obtenerPorId(res.rows[0].id_matricula);
  },

  async cambiarEstado(id, estado) {
    await this.obtenerPorId(id);
    await db.query(
      'UPDATE sga_principal.matriculas SET estado = $1::sga_principal.estado_matricula_t WHERE id_matricula = $2',
      [estado, id]
    );
  },

  async estadisticasPorGrado(idAnoLectivo) {
    const res = await db.query(
      `SELECT g.nombre AS grado, p.letra AS paralelo,
              COUNT(m.id_matricula) AS total,
              COUNT(m.id_matricula) FILTER (WHERE m.estado = 'ACTIVA') AS activas,
              COUNT(m.id_matricula) FILTER (WHERE m.estado = 'RETIRADA') AS retiradas
       FROM sga_principal.grados g
       JOIN sga_principal.paralelos p ON p.id_grado = g.id_grado
       LEFT JOIN sga_principal.matriculas m
         ON m.id_grado = g.id_grado AND m.id_paralelo = p.id_paralelo
         AND m.id_ano_lectivo = $1
       WHERE g.activo = true AND p.activo = true
       GROUP BY g.nombre, g.orden, p.letra
       ORDER BY g.orden, p.letra`,
      [idAnoLectivo]
    );
    return res.rows;
  },
};

// ──────────────────────────────────────────────
// RUTAS
// ──────────────────────────────────────────────
router.use(authMiddleware, requireRole(...ROLES));

// Paralelos por grado (para el formulario de nueva matrícula)
router.get('/paralelos/:idGrado',
  param('idGrado').isInt(),
  validateRequest,
  async (req, res, next) => {
    try {
      const result = await db.query(
        `SELECT id_paralelo, letra FROM sga_principal.paralelos WHERE id_grado = $1 AND activo = true ORDER BY letra`,
        [req.params.idGrado]
      );
      res.json(result.rows);
    } catch (e) { next(e); }
  }
);

router.get('/ano-lectivo/:idAno',
  param('idAno').isInt(),
  validateRequest,
  async (req, res, next) => {
    try {
      res.json(await MatriculaService.listarPorAnoLectivo(req.params.idAno, {
        page: req.query.page,
        limit: req.query.limit,
        search: req.query.q,
      }));
    } catch (e) { next(e); }
  }
);

router.get('/ano-lectivo/:idAno/estadisticas',
  param('idAno').isInt(),
  validateRequest,
  async (req, res, next) => {
    try {
      res.json(await MatriculaService.estadisticasPorGrado(req.params.idAno));
    } catch (e) { next(e); }
  }
);

router.get('/estudiante/:idEstudiante',
  param('idEstudiante').isInt(),
  validateRequest,
  async (req, res, next) => {
    try {
      res.json(await MatriculaService.listarPorEstudiante(req.params.idEstudiante));
    } catch (e) { next(e); }
  }
);

router.get('/:id', param('id').isInt(), validateRequest, async (req, res, next) => {
  try {
    res.json(await MatriculaService.obtenerPorId(req.params.id));
  } catch (e) { next(e); }
});

router.post('/',
  [
    body('id_estudiante').isInt().withMessage('id_estudiante requerido'),
    body('id_grado').isInt().withMessage('id_grado requerido'),
    body('id_paralelo').isInt().withMessage('id_paralelo requerido'),
    body('id_ano_lectivo').isInt().withMessage('id_ano_lectivo requerido'),
    body('estado').optional().isIn(['ACTIVA', 'RETIRADA', 'EGRESADA', 'PROMOVIDA', 'NO_PROMOVIDA']),
  ],
  validateRequest,
  async (req, res, next) => {
    try {
      const m = await MatriculaService.crear(req.body, req.user.username);
      res.status(201).json(m);
    } catch (e) { next(e); }
  }
);

router.patch('/:id/estado',
  param('id').isInt(),
  body('estado').isIn(['ACTIVA', 'RETIRADA', 'EGRESADA', 'PROMOVIDA', 'NO_PROMOVIDA']),
  validateRequest,
  async (req, res, next) => {
    try {
      await MatriculaService.cambiarEstado(req.params.id, req.body.estado);
      res.status(204).send();
    } catch (e) { next(e); }
  }
);

module.exports = { router, MatriculaService };
