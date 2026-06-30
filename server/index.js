'use strict';

require('dotenv').config();

const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const path = require('path');

const { errorHandler } = require('./src/middlewares/errorHandler');

// Routers
const estudiantesRouter = require('./src/modules/estudiantes/estudiantes.router');
const { router: matriculasRouter } = require('./src/modules/matriculas/matriculas.router');
const { router: usuariosRouter } = require('./src/modules/usuarios/usuarios.router');
const { router: historialRouter } = require('./src/modules/historial/historial.router');
const reportesRouter = require('./src/modules/reportes/reportes.router');

const app = express();
const PORT = process.env.PORT || 3000;

// ──────────────────────────────────────────────
// MIDDLEWARES GLOBALES
// ──────────────────────────────────────────────
app.use(helmet({ contentSecurityPolicy: false }));
app.use(cors({
  origin: process.env.CORS_ORIGIN || '*',
  methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization'],
}));
app.use(express.json({ limit: '2mb' }));
app.use(express.urlencoded({ extended: true }));
app.use(morgan(process.env.NODE_ENV === 'production' ? 'combined' : 'dev'));

// ──────────────────────────────────────────────
// HEALTH CHECK
// ──────────────────────────────────────────────
app.get('/health', (req, res) => {
  res.json({ service: 'sga-secretario', status: 'ok', timestamp: new Date().toISOString() });
});

// ──────────────────────────────────────────────
// API ROUTES
// ──────────────────────────────────────────────
const API = '/api/secretario';
app.use(`${API}/estudiantes`, estudiantesRouter);
app.use(`${API}/matriculas`, matriculasRouter);
app.use(`${API}/usuarios`, usuariosRouter);
app.use(`${API}/historial`, historialRouter);
app.use(`${API}/reportes`, reportesRouter);

// ──────────────────────────────────────────────
// FRONTEND ESTÁTICO (React build)
// El frontend se compila con: npm run build
// Genera client/dist/ que Express sirve aquí
// ──────────────────────────────────────────────
const DIST = path.join(__dirname, '..', 'client', 'dist');

app.use(express.static(DIST));

// Cualquier ruta que no sea /api/* devuelve el index.html de React (SPA routing)
// Nota: Express 5 no soporta '*' en app.get() — usamos un middleware catch-all
app.use((req, res, next) => {
  if (req.path.startsWith('/api/')) return next();
  res.sendFile(path.join(DIST, 'index.html'), (err) => {
    if (err) {
      res.status(404).json({
        error: 'Frontend no compilado. Ejecuta: npm run build',
        hint: 'El frontend React se sirve desde client/dist/ después del build.',
      });
    }
  });
});

// Error global
app.use(errorHandler);

// ──────────────────────────────────────────────
// INICIO
// ──────────────────────────────────────────────
app.listen(PORT, () => {
  console.log(`\n🎓 SGA Secretario unificado en puerto ${PORT}`);
  console.log(`   Panel:  http://localhost:${PORT}/`);
  console.log(`   API:    http://localhost:${PORT}${API}/`);
  console.log(`   Health: http://localhost:${PORT}/health\n`);
  console.log(`   ⚠️  Si es la primera vez, ejecuta: npm run build\n`);
});

module.exports = app;
