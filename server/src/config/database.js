'use strict';

const { Pool } = require('pg');

const pool = new Pool({
  host: process.env.DB_HOST,
  port: parseInt(process.env.DB_PORT || '5432'),
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  ssl: process.env.DB_SSL === 'true' ? { rejectUnauthorized: false } : false,
  max: 10,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 5000,
});

pool.on('error', (err) => {
  console.error('[DB] Error inesperado en cliente inactivo:', err.message);
});

/**
 * Ejecuta una query con parámetros.
 * @param {string} text - SQL
 * @param {any[]} params - parámetros posicionales
 */
async function query(text, params = []) {
  const start = Date.now();
  try {
    const res = await pool.query(text, params);
    const duration = Date.now() - start;
    if (process.env.NODE_ENV === 'development') {
      console.debug(`[DB] query (${duration}ms) rows=${res.rowCount}`);
    }
    return res;
  } catch (err) {
    console.error('[DB] Error en query:', err.message);
    throw err;
  }
}

/**
 * Obtiene un cliente del pool para transacciones manuales.
 */
async function getClient() {
  const client = await pool.connect();
  const originalQuery = client.query.bind(client);
  const release = client.release.bind(client);

  client.release = () => {
    client.release = release;
    return release();
  };

  return client;
}

module.exports = { query, getClient, pool };
