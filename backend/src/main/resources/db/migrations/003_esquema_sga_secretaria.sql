-- Migracion 003: esquema propio sga_secretaria.
--
-- Hoy Secretaria (JDBC crudo, este repo) y sga-principal (JPA, repo hermano)
-- leen y escriben las MISMAS tablas en el esquema sga_principal en paralelo
-- (estudiantes, matriculas, representantes, fichas_estudiante,
-- documentos_matricula, historial_promocion) — el anti-patron clasico de
-- microservicios con dos duenos de escritura sobre el mismo dato. Esta
-- migracion las mueve a un esquema propio de Secretaria; sga-principal deja
-- de tener su propio CRUD sobre ellas (ver EstudianteController/Service,
-- RepresentanteController/Service, MatriculaController/Service, eliminados
-- de sga-principal) y solo conserva lecturas de solo-lectura via JPA
-- (TeacherAuthorizationService, GradoService, ImportacionCasService) contra
-- las mismas tablas, ahora bajo sga_secretaria.
--
-- ALTER TABLE ... SET SCHEMA es un rename de catalogo (metadatos), NO copia
-- filas ni bloquea por mucho tiempo — pero cambia donde vive la tabla, asi
-- que el codigo viejo (con "sga_principal.estudiantes" hardcodeado) falla en
-- cuanto se corre esto. Por eso: correr esta migracion SOLO junto con el
-- despliegue del codigo actualizado de AMBOS repos (sga-secretaria con el
-- prefijo sga_secretaria.*, sga-principal con @Table(schema="sga_secretaria")
-- en Estudiante/Matricula/Representante/FichaEstudiante), nunca antes.
--
-- Los tipos enum custom (genero_t, estado_matricula_t, tipo_documento_t,
-- resultado_promocion_t) NO se mueven: son objetos de esquema independientes
-- de las tablas y se quedan en sga_principal; los casts existentes
-- (ej. "::sga_principal.genero_t") siguen siendo correctos tal cual.
--
-- Como correrla: psql "$DATABASE_URL" -f backend/src/main/resources/db/migrations/003_esquema_sga_secretaria.sql
-- Requiere permisos de owner sobre las tablas listadas.

CREATE SCHEMA IF NOT EXISTS sga_secretaria;

ALTER TABLE sga_principal.estudiantes          SET SCHEMA sga_secretaria;
ALTER TABLE sga_principal.matriculas           SET SCHEMA sga_secretaria;
ALTER TABLE sga_principal.representantes       SET SCHEMA sga_secretaria;
ALTER TABLE sga_principal.fichas_estudiante    SET SCHEMA sga_secretaria;
ALTER TABLE sga_principal.documentos_matricula SET SCHEMA sga_secretaria;
ALTER TABLE sga_principal.historial_promocion  SET SCHEMA sga_secretaria;
