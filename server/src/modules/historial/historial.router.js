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
const HistorialService = {

  async historialEstudiante(idEstudiante) {
    // Verificar que el estudiante exista
    const est = await db.query(
      `SELECT id_estudiante, nombres, apellidos, cedula, codigo_estudiante
       FROM sga_principal.estudiantes WHERE id_estudiante = $1`,
      [idEstudiante]
    );
    if (!est.rows.length) throw createError(404, 'Estudiante no encontrado');

    const historial = await db.query(
      `SELECT hp.id_historial, hp.resultado, hp.promedio_anual, hp.observaciones,
              hp.fecha_registro,
              al.nombre AS ano_lectivo, al.fecha_inicio, al.fecha_fin,
              g.nombre AS grado,
              u.username AS registrado_por
       FROM sga_principal.historial_promocion hp
       JOIN sga_principal.anos_lectivos al ON al.id_ano_lectivo = hp.id_ano_lectivo
       JOIN sga_principal.grados g ON g.id_grado = hp.id_grado_origen
       LEFT JOIN sga_principal.usuarios u ON u.id_usuario = hp.registrado_por
       WHERE hp.id_estudiante = $1
       ORDER BY al.fecha_inicio DESC`,
      [idEstudiante]
    );

    return { estudiante: est.rows[0], historial: historial.rows };
  },

  async registrarPromocion(dto, username) {
    // Validar matrícula
    const mat = await db.query(
      `SELECT m.id_matricula, m.id_estudiante, m.id_grado, m.id_ano_lectivo
       FROM sga_principal.matriculas m WHERE m.id_matricula = $1`,
      [dto.id_matricula]
    );
    if (!mat.rows.length) throw createError(404, 'Matrícula no encontrada');
    const m = mat.rows[0];

    // Evitar duplicado
    const dup = await db.query(
      'SELECT id_historial FROM sga_principal.historial_promocion WHERE id_matricula = $1',
      [dto.id_matricula]
    );
    if (dup.rows.length) throw createError(409, 'Ya existe registro de promoción para esta matrícula');

    const u = await db.query(
      'SELECT id_usuario FROM sga_principal.usuarios WHERE username = $1', [username]
    );
    const registradoPor = u.rows[0]?.id_usuario || null;

    const client = await db.getClient();
    try {
      await client.query('BEGIN');

      // Insertar historial
      await client.query(
        `INSERT INTO sga_principal.historial_promocion
           (id_matricula, id_estudiante, id_grado_origen, id_ano_lectivo,
            resultado, promedio_anual, observaciones, registrado_por)
         VALUES ($1,$2,$3,$4,$5,$6,$7,$8)`,
        [
          dto.id_matricula,
          m.id_estudiante,
          m.id_grado,
          m.id_ano_lectivo,
          dto.resultado,
          dto.promedio_anual || null,
          dto.observaciones || null,
          registradoPor,
        ]
      );

      // Actualizar estado de matrícula
      const estadoMat = dto.resultado === 'PROMOVIDO' ? 'PROMOVIDA' : 'NO_PROMOVIDA';
      await client.query(
        'UPDATE sga_principal.matriculas SET estado = $1::sga_principal.estado_matricula_t WHERE id_matricula = $2',
        [estadoMat, dto.id_matricula]
      );

      await client.query('COMMIT');
    } catch (e) {
      await client.query('ROLLBACK');
      throw e;
    } finally {
      client.release();
    }

    return this.historialEstudiante(m.id_estudiante);
  },

  async resumenPromocion(idAnoLectivo) {
    const res = await db.query(
      `SELECT g.nombre AS grado,
              COUNT(*) FILTER (WHERE hp.resultado = 'PROMOVIDO') AS promovidos,
              COUNT(*) FILTER (WHERE hp.resultado = 'NO_PROMOVIDO') AS no_promovidos,
              COUNT(*) FILTER (WHERE hp.resultado = 'RETIRADO') AS retirados,
              ROUND(AVG(hp.promedio_anual)::numeric, 2) AS promedio_general,
              COUNT(hp.id_historial) AS total_registrados
       FROM sga_principal.historial_promocion hp
       JOIN sga_principal.grados g ON g.id_grado = hp.id_grado_origen
       WHERE hp.id_ano_lectivo = $1
       GROUP BY g.nombre, g.orden
       ORDER BY g.orden`,
      [idAnoLectivo]
    );
    return res.rows;
  },

  async estudiantesSinPromocion(idAnoLectivo) {
    const res = await db.query(
      `SELECT m.id_matricula, e.id_estudiante,
              e.nombres || ' ' || e.apellidos AS estudiante,
              e.cedula, g.nombre AS grado, p.letra AS paralelo
       FROM sga_principal.matriculas m
       JOIN sga_principal.estudiantes e ON e.id_estudiante = m.id_estudiante
       JOIN sga_principal.grados g ON g.id_grado = m.id_grado
       JOIN sga_principal.paralelos p ON p.id_paralelo = m.id_paralelo
       WHERE m.id_ano_lectivo = $1
         AND NOT EXISTS (
           SELECT 1 FROM sga_principal.historial_promocion hp
           WHERE hp.id_matricula = m.id_matricula
         )
       ORDER BY g.orden, p.letra, e.apellidos`,
      [idAnoLectivo]
    );
    return res.rows;
  },
};

// ──────────────────────────────────────────────
// RUTAS
// ──────────────────────────────────────────────
router.use(authMiddleware, requireRole(...ROLES));

router.get('/estudiante/:id',
  param('id').isInt(),
  validateRequest,
  async (req, res, next) => {
    try { res.json(await HistorialService.historialEstudiante(req.params.id)); } catch (e) { next(e); }
  }
);

router.get('/ano-lectivo/:idAno/resumen',
  param('idAno').isInt(),
  validateRequest,
  async (req, res, next) => {
    try { res.json(await HistorialService.resumenPromocion(req.params.idAno)); } catch (e) { next(e); }
  }
);

router.get('/ano-lectivo/:idAno/sin-promocion',
  param('idAno').isInt(),
  validateRequest,
  async (req, res, next) => {
    try { res.json(await HistorialService.estudiantesSinPromocion(req.params.idAno)); } catch (e) { next(e); }
  }
);

router.post('/',
  [
    body('id_matricula').isInt().withMessage('id_matricula requerido'),
    body('resultado').isIn(['PROMOVIDO', 'NO_PROMOVIDO', 'RETIRADO']).withMessage('resultado inválido'),
    body('promedio_anual').optional().isFloat({ min: 0, max: 10 }),
  ],
  validateRequest,
  async (req, res, next) => {
    try {
      res.status(201).json(await HistorialService.registrarPromocion(req.body, req.user.username));
    } catch (e) { next(e); }
  }
);

module.exports = { router, HistorialService };
