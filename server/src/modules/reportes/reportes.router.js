'use strict';

const express = require('express');
const { param } = require('express-validator');
const { authMiddleware, requireRole } = require('../../middlewares/auth');
const { validateRequest, createError } = require('../../middlewares/errorHandler');
const db = require('../../config/database');
const pdf = require('../../utils/pdfGenerator');

const router = express.Router();
const ROLES = ['ROLE_SECRETARIO', 'ROLE_ADMIN'];

/**
 * Envía un PDFDocument como respuesta HTTP.
 */
function streamPDF(doc, res, filename) {
  res.setHeader('Content-Type', 'application/pdf');
  res.setHeader('Content-Disposition', `inline; filename="${filename}"`);
  doc.pipe(res);
}

// ──────────────────────────────────────────────
// RUTAS
// ──────────────────────────────────────────────
router.use(authMiddleware, requireRole(...ROLES));

/**
 * GET /reportes/certificado-matricula/:idMatricula
 * Genera el certificado de matrícula de un estudiante.
 */
router.get('/certificado-matricula/:id',
  param('id').isInt(),
  validateRequest,
  async (req, res, next) => {
    try {
      const result = await db.query(
        `SELECT m.id_matricula, m.numero_orden, m.fecha_registro, m.estado,
                e.nombres || ' ' || e.apellidos AS estudiante,
                e.nombres AS nombres_estudiante,
                e.cedula, e.codigo_estudiante,
                g.nombre AS grado, p.letra AS paralelo,
                al.nombre AS ano_lectivo
         FROM sga_principal.matriculas m
         JOIN sga_principal.estudiantes e ON e.id_estudiante = m.id_estudiante
         JOIN sga_principal.grados g ON g.id_grado = m.id_grado
         JOIN sga_principal.paralelos p ON p.id_paralelo = m.id_paralelo
         JOIN sga_principal.anos_lectivos al ON al.id_ano_lectivo = m.id_ano_lectivo
         WHERE m.id_matricula = $1`,
        [req.params.id]
      );
      if (!result.rows.length) throw createError(404, 'Matrícula no encontrada');

      const doc = pdf.generarCertificadoMatricula(result.rows[0]);
      streamPDF(doc, res, `certificado-matricula-${req.params.id}.pdf`);
    } catch (e) { next(e); }
  }
);

/**
 * GET /reportes/nomina-matriculas/:idAno
 * Nómina completa de estudiantes de un año lectivo (opcionalmente filtrado por grado/paralelo).
 */
router.get('/nomina-matriculas/:idAno',
  param('idAno').isInt(),
  validateRequest,
  async (req, res, next) => {
    try {
      const { id_grado, id_paralelo } = req.query;
      let where = 'WHERE m.id_ano_lectivo = $1';
      const params = [req.params.idAno];

      if (id_grado) { params.push(id_grado); where += ` AND m.id_grado = $${params.length}`; }
      if (id_paralelo) { params.push(id_paralelo); where += ` AND m.id_paralelo = $${params.length}`; }

      const [matriculas, alRes] = await Promise.all([
        db.query(
          `SELECT m.numero_orden, m.fecha_registro, m.estado,
                  e.cedula, e.nombres || ' ' || e.apellidos AS estudiante,
                  g.nombre AS grado, p.letra AS paralelo
           FROM sga_principal.matriculas m
           JOIN sga_principal.estudiantes e ON e.id_estudiante = m.id_estudiante
           JOIN sga_principal.grados g ON g.id_grado = m.id_grado
           JOIN sga_principal.paralelos p ON p.id_paralelo = m.id_paralelo
           ${where}
           ORDER BY g.orden, p.letra, e.apellidos`,
          params
        ),
        db.query('SELECT nombre FROM sga_principal.anos_lectivos WHERE id_ano_lectivo = $1', [req.params.idAno]),
      ]);

      // Meta para el encabezado del PDF
      let gradoNombre = '', paraleloLetra = '';
      if (id_grado) {
        const g = await db.query('SELECT nombre FROM sga_principal.grados WHERE id_grado = $1', [id_grado]);
        gradoNombre = g.rows[0]?.nombre || '';
      }
      if (id_paralelo) {
        const p = await db.query('SELECT letra FROM sga_principal.paralelos WHERE id_paralelo = $1', [id_paralelo]);
        paraleloLetra = p.rows[0]?.letra || '';
      }

      const doc = pdf.generarReporteMatriculas(matriculas.rows, {
        anoLectivo: alRes.rows[0]?.nombre || '',
        grado: gradoNombre,
        paralelo: paraleloLetra,
      });
      streamPDF(doc, res, `nomina-matriculas-${req.params.idAno}.pdf`);
    } catch (e) { next(e); }
  }
);

/**
 * GET /reportes/ficha-estudiante/:idEstudiante
 * Ficha completa del estudiante con datos médicos y representante.
 */
router.get('/ficha-estudiante/:id',
  param('id').isInt(),
  validateRequest,
  async (req, res, next) => {
    try {
      const res2 = await db.query(
        `SELECT e.*,
                r.nombres AS rep_nombres, r.apellidos AS rep_apellidos,
                r.cedula AS rep_cedula, r.telefono_principal AS rep_telefono,
                r.correo AS rep_correo, r.parentesco,
                f.tipo_sangre, f.alergias, f.medicacion_permanente,
                f.enfermedad_catastrofica, f.detalle_enfermedad,
                f.contacto_emergencia, f.telefono_emergencia
         FROM sga_principal.estudiantes e
         LEFT JOIN sga_principal.representantes r ON r.id_representante = e.id_representante
         LEFT JOIN sga_principal.fichas_estudiante f ON f.id_estudiante = e.id_estudiante
         WHERE e.id_estudiante = $1`,
        [req.params.id]
      );
      if (!res2.rows.length) throw createError(404, 'Estudiante no encontrado');

      const doc = pdf.generarFichaEstudiante(res2.rows[0]);
      streamPDF(doc, res, `ficha-estudiante-${req.params.id}.pdf`);
    } catch (e) { next(e); }
  }
);

/**
 * GET /reportes/estadisticas/:idAno
 * Resumen estadístico de matrículas del año (JSON, no PDF).
 */
router.get('/estadisticas/:idAno',
  param('idAno').isInt(),
  validateRequest,
  async (req, res, next) => {
    try {
      const [totales, porGrado, porEstado] = await Promise.all([
        db.query(
          `SELECT COUNT(*) AS total,
                  COUNT(*) FILTER (WHERE m.estado = 'ACTIVA') AS activas,
                  COUNT(*) FILTER (WHERE m.estado = 'RETIRADA') AS retiradas,
                  COUNT(*) FILTER (WHERE e.discapacidad = true) AS con_discapacidad,
                  COUNT(*) FILTER (WHERE e.genero = 'MASCULINO') AS masculino,
                  COUNT(*) FILTER (WHERE e.genero = 'FEMENINO') AS femenino
           FROM sga_principal.matriculas m
           JOIN sga_principal.estudiantes e ON e.id_estudiante = m.id_estudiante
           WHERE m.id_ano_lectivo = $1`,
          [req.params.idAno]
        ),
        db.query(
          `SELECT g.nombre AS grado, g.orden,
                  COUNT(m.id_matricula) AS total
           FROM sga_principal.grados g
           LEFT JOIN sga_principal.matriculas m
             ON m.id_grado = g.id_grado AND m.id_ano_lectivo = $1
           WHERE g.activo = true
           GROUP BY g.nombre, g.orden
           ORDER BY g.orden`,
          [req.params.idAno]
        ),
        db.query(
          `SELECT estado, COUNT(*) AS cantidad
           FROM sga_principal.matriculas WHERE id_ano_lectivo = $1
           GROUP BY estado`,
          [req.params.idAno]
        ),
      ]);

      res.json({
        totales: totales.rows[0],
        por_grado: porGrado.rows,
        por_estado: porEstado.rows,
      });
    } catch (e) { next(e); }
  }
);

module.exports = router;
