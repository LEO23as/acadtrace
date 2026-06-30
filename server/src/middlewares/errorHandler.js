'use strict';

const { validationResult } = require('express-validator');

function validateRequest(req, res, next) {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(422).json({
      error: 'Datos inválidos',
      detalles: errors.array().map(e => ({ campo: e.path, mensaje: e.msg })),
    });
  }
  next();
}

function errorHandler(err, req, res, next) {
  // Loguear siempre el error real en consola del servidor
  console.error(`[ERROR] ${req.method} ${req.path} →`, err.message);
  if (err.code) console.error(`  PG code: ${err.code} | detail: ${err.detail || ''}`);

  if (err.code === '23505') {
    return res.status(409).json({ error: 'Registro duplicado', detalle: err.detail });
  }
  if (err.code === '23503') {
    return res.status(400).json({ error: 'Referencia inválida', detalle: err.detail });
  }
  if (err.code === '22P02') {
    return res.status(400).json({ error: 'Tipo de dato inválido', detalle: err.message });
  }
  if (err.statusCode) {
    return res.status(err.statusCode).json({ error: err.message });
  }

  res.status(500).json({ error: 'Error interno del servidor', detalle: err.message });
}

function createError(statusCode, message) {
  const err = new Error(message);
  err.statusCode = statusCode;
  return err;
}

module.exports = { validateRequest, errorHandler, createError };
