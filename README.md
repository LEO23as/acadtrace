# SGA Secretaría — Microservicio Unificado

Un solo proyecto que contiene el **backend Express** y el **frontend React** del panel de secretaría.

```
sga-secretario/
├── package.json          ← raíz: dependencias del servidor
├── .env                  ← variables de entorno
├── server/
│   └── index.js          ← Express: API + sirve el frontend
│   └── src/
│       ├── config/       ← conexión a Supabase
│       ├── middlewares/  ← JWT, validaciones, errores
│       ├── modules/      ← estudiantes, matrículas, usuarios, historial, reportes
│       └── utils/        ← generador de PDFs
└── client/
    ├── package.json      ← dependencias del frontend
    ├── vite.config.js    ← build + proxy dev
    └── src/
        ├── pages/        ← Login, Dashboard, Estudiantes, Matrículas, etc.
        ├── components/   ← Layout con sidebar
        └── utils/        ← api.js con axios
```

---

## Instalación y primer uso

```bash
# 1. Instalar dependencias del servidor
npm install

# 2. Configurar variables de entorno
cp .env.example .env
# → Editar .env: DB_PASSWORD y demás valores

# 3. Compilar el frontend (una sola vez, o cada vez que cambies el React)
npm run build

# 4. Iniciar el servidor unificado
npm start
```

Abre **http://localhost:3000** — verás el login del panel de secretaría.

---

## Modos de desarrollo

### Opción A — Solo servidor (si ya tienes el build)
```bash
npm run dev:server     # node --watch server/index.js en :3000
```

### Opción B — Desarrollo activo del frontend (hot reload)
```bash
# Terminal 1: servidor Express
npm run dev:server

# Terminal 2: Vite dev con proxy automático → :3000
npm run dev:client
# Abre http://localhost:5173
```

El `vite.config.js` tiene configurado el proxy: todas las peticiones `/api/*` desde `:5173` se redirigen a `:3000`.

---

## Variables de entorno

| Variable | Descripción | Ejemplo |
|---|---|---|
| `PORT` | Puerto del servidor | `3000` |
| `DB_HOST` | Host Supabase | `aws-0-us-east-1.pooler.supabase.com` |
| `DB_PORT` | Puerto PostgreSQL | `5432` |
| `DB_NAME` | Nombre base de datos | `postgres` |
| `DB_USER` | Usuario Supabase | `postgres.xxxxx` |
| `DB_PASSWORD` | Contraseña | `tu_password` |
| `DB_SSL` | SSL activado | `true` |
| `JWT_SECRET` | **Misma secret que sga-principal** | `sga-provincias-unidas-...` |
| `VITE_API_PRINCIPAL` | URL del Spring Boot (solo dev) | `http://localhost:8080/api` |

---

## API disponible

Todas las rutas requieren `Authorization: Bearer <token>`.

| Módulo | Base URL |
|---|---|
| Estudiantes | `GET/POST/PUT/PATCH /api/secretario/estudiantes` |
| Matrículas | `GET/POST/PATCH /api/secretario/matriculas` |
| Usuarios | `GET/POST/PUT/PATCH /api/secretario/usuarios` |
| Historial | `GET/POST /api/secretario/historial` |
| Reportes PDF | `GET /api/secretario/reportes/...` |

---

## Cómo funciona la unificación

En **producción** (`npm start`):
1. `npm run build` compila React → `client/dist/`
2. Express sirve `client/dist/` como archivos estáticos en `/`
3. Las rutas `/api/*` van al backend
4. Cualquier otra ruta devuelve `index.html` (SPA routing de React Router)

Todo desde **un solo proceso, un solo puerto**.
