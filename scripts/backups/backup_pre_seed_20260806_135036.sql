--
-- PostgreSQL database dump
--

\restrict qWZqyd2LgLxbgpMSdjA8hz0BPdK5kMavoue1DWVRY3yEEyTX3lMta33Spidyq6M

-- Dumped from database version 17.10 (Debian 17.10-1.pgdg13+1)
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: sga_docente; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sga_docente;


ALTER SCHEMA sga_docente OWNER TO postgres;

--
-- Name: SCHEMA sga_docente; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA sga_docente IS 'Módulo docente: calificaciones, asistencias, seguimiento';


--
-- Name: sga_principal; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sga_principal;


ALTER SCHEMA sga_principal OWNER TO postgres;

--
-- Name: SCHEMA sga_principal; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA sga_principal IS 'Módulo principal: usuarios, matrículas, grados, asignaciones, auditoría';


--
-- Name: sga_secretaria; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sga_secretaria;


ALTER SCHEMA sga_secretaria OWNER TO postgres;

--
-- Name: categoria_seguimiento_t; Type: TYPE; Schema: sga_docente; Owner: postgres
--

CREATE TYPE sga_docente.categoria_seguimiento_t AS ENUM (
    'ACADEMICO',
    'CONDUCTUAL',
    'DECE',
    'MEDICO',
    'FAMILIAR',
    'OTRO'
);


ALTER TYPE sga_docente.categoria_seguimiento_t OWNER TO postgres;

--
-- Name: estado_asistencia_t; Type: TYPE; Schema: sga_docente; Owner: postgres
--

CREATE TYPE sga_docente.estado_asistencia_t AS ENUM (
    'PRESENTE',
    'AUSENTE',
    'JUSTIFICADO',
    'ATRASO'
);


ALTER TYPE sga_docente.estado_asistencia_t OWNER TO postgres;

--
-- Name: nota_cualitativa_t; Type: TYPE; Schema: sga_docente; Owner: postgres
--

CREATE TYPE sga_docente.nota_cualitativa_t AS ENUM (
    'A_MAS',
    'A_MENOS',
    'B_MAS',
    'B_MENOS',
    'C_MAS',
    'C_MENOS',
    'D'
);


ALTER TYPE sga_docente.nota_cualitativa_t OWNER TO postgres;

--
-- Name: tipo_actividad_t; Type: TYPE; Schema: sga_docente; Owner: postgres
--

CREATE TYPE sga_docente.tipo_actividad_t AS ENUM (
    'LECCION_ORAL',
    'LECCION_ESCRITA',
    'TAREA',
    'TALLER',
    'CUADERNO',
    'TRABAJO_INDIVIDUAL',
    'EXPOSICION',
    'PROYECTO_INTERDISCIPLINARIO',
    'EXAMEN_TRIMESTRAL'
);


ALTER TYPE sga_docente.tipo_actividad_t OWNER TO postgres;

--
-- Name: tipo_periodo_t; Type: TYPE; Schema: sga_docente; Owner: postgres
--

CREATE TYPE sga_docente.tipo_periodo_t AS ENUM (
    'PRIMER_TRIMESTRE',
    'SEGUNDO_TRIMESTRE',
    'TERCER_TRIMESTRE'
);


ALTER TYPE sga_docente.tipo_periodo_t OWNER TO postgres;

--
-- Name: accion_auditoria_t; Type: TYPE; Schema: sga_principal; Owner: postgres
--

CREATE TYPE sga_principal.accion_auditoria_t AS ENUM (
    'CREAR',
    'EDITAR',
    'ELIMINAR',
    'LOGIN',
    'LOGOUT',
    'CAMBIO_PASSWORD',
    'BLOQUEO',
    'DESBLOQUEO'
);


ALTER TYPE sga_principal.accion_auditoria_t OWNER TO postgres;

--
-- Name: dia_semana_t; Type: TYPE; Schema: sga_principal; Owner: postgres
--

CREATE TYPE sga_principal.dia_semana_t AS ENUM (
    'LUNES',
    'MARTES',
    'MIERCOLES',
    'JUEVES',
    'VIERNES'
);


ALTER TYPE sga_principal.dia_semana_t OWNER TO postgres;

--
-- Name: estado_matricula_t; Type: TYPE; Schema: sga_principal; Owner: postgres
--

CREATE TYPE sga_principal.estado_matricula_t AS ENUM (
    'ACTIVA',
    'RETIRADA',
    'TRASLADADA',
    'PROMOVIDA',
    'REPROBADA'
);


ALTER TYPE sga_principal.estado_matricula_t OWNER TO postgres;

--
-- Name: genero_t; Type: TYPE; Schema: sga_principal; Owner: postgres
--

CREATE TYPE sga_principal.genero_t AS ENUM (
    'MASCULINO',
    'FEMENINO',
    'OTRO'
);


ALTER TYPE sga_principal.genero_t OWNER TO postgres;

--
-- Name: nivel_educativo_t; Type: TYPE; Schema: sga_principal; Owner: postgres
--

CREATE TYPE sga_principal.nivel_educativo_t AS ENUM (
    'INICIAL_1',
    'INICIAL_2',
    'PREPARATORIA',
    'BASICA_ELEMENTAL',
    'BASICA_MEDIA',
    'BASICA_SUPERIOR'
);


ALTER TYPE sga_principal.nivel_educativo_t OWNER TO postgres;

--
-- Name: origen_listado_t; Type: TYPE; Schema: sga_principal; Owner: postgres
--

CREATE TYPE sga_principal.origen_listado_t AS ENUM (
    'NUEVO',
    'TRANSFERIDO_INTERNO',
    'TRANSFERIDO_EXTERNO',
    'REPITENTE',
    'REINGRESO'
);


ALTER TYPE sga_principal.origen_listado_t OWNER TO postgres;

--
-- Name: resultado_promocion_t; Type: TYPE; Schema: sga_principal; Owner: postgres
--

CREATE TYPE sga_principal.resultado_promocion_t AS ENUM (
    'PROMOVIDO',
    'REPROBADO',
    'RETIRADO',
    'TRASLADADO'
);


ALTER TYPE sga_principal.resultado_promocion_t OWNER TO postgres;

--
-- Name: tipo_asignacion_t; Type: TYPE; Schema: sga_principal; Owner: postgres
--

CREATE TYPE sga_principal.tipo_asignacion_t AS ENUM (
    'TITULAR',
    'ESPECIALIZADO'
);


ALTER TYPE sga_principal.tipo_asignacion_t OWNER TO postgres;

--
-- Name: tipo_documento_t; Type: TYPE; Schema: sga_principal; Owner: postgres
--

CREATE TYPE sga_principal.tipo_documento_t AS ENUM (
    'PARTIDA_NACIMIENTO',
    'CEDULA_IDENTIDAD',
    'FOTO',
    'INFORME_PREVIO',
    'CERTIFICADO_MEDICO',
    'CARNET_DISCAPACIDAD',
    'COMPROBANTE_DOMICILIO',
    'OTRO'
);


ALTER TYPE sga_principal.tipo_documento_t OWNER TO postgres;

--
-- Name: tipo_escala_t; Type: TYPE; Schema: sga_principal; Owner: postgres
--

CREATE TYPE sga_principal.tipo_escala_t AS ENUM (
    'CUANTITATIVA',
    'CUALITATIVA',
    'MIXTA'
);


ALTER TYPE sga_principal.tipo_escala_t OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: actividades; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.actividades (
    id_actividad integer NOT NULL,
    id_asignacion integer NOT NULL,
    id_periodo integer NOT NULL,
    tipo sga_docente.tipo_actividad_t NOT NULL,
    nombre character varying(200),
    descripcion text,
    fecha_entrega date,
    ponderacion numeric(5,2) DEFAULT 1.0 NOT NULL,
    nota_maxima numeric(4,2) DEFAULT 10.0 NOT NULL,
    es_sumativa boolean DEFAULT false NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT nota_maxima_check CHECK (((nota_maxima > (0)::numeric) AND (nota_maxima <= (10)::numeric))),
    CONSTRAINT ponderacion_positiva CHECK (((ponderacion > (0)::numeric) AND (ponderacion <= (100)::numeric)))
);


ALTER TABLE sga_docente.actividades OWNER TO postgres;

--
-- Name: actividades_id_actividad_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

CREATE SEQUENCE sga_docente.actividades_id_actividad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_docente.actividades_id_actividad_seq OWNER TO postgres;

--
-- Name: actividades_id_actividad_seq; Type: SEQUENCE OWNED BY; Schema: sga_docente; Owner: postgres
--

ALTER SEQUENCE sga_docente.actividades_id_actividad_seq OWNED BY sga_docente.actividades.id_actividad;


--
-- Name: asistencias; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.asistencias (
    id_asistencia bigint NOT NULL,
    id_matricula integer NOT NULL,
    id_asignacion integer NOT NULL,
    id_periodo integer NOT NULL,
    fecha date NOT NULL,
    estado sga_docente.estado_asistencia_t NOT NULL,
    justificacion text,
    registrado_por integer NOT NULL,
    fecha_registro timestamp with time zone DEFAULT now() NOT NULL,
    fecha_actualizacion timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_docente.asistencias OWNER TO postgres;

--
-- Name: asistencias_id_asistencia_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

CREATE SEQUENCE sga_docente.asistencias_id_asistencia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_docente.asistencias_id_asistencia_seq OWNER TO postgres;

--
-- Name: asistencias_id_asistencia_seq; Type: SEQUENCE OWNED BY; Schema: sga_docente; Owner: postgres
--

ALTER SEQUENCE sga_docente.asistencias_id_asistencia_seq OWNED BY sga_docente.asistencias.id_asistencia;


--
-- Name: auth_group; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE sga_docente.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

ALTER TABLE sga_docente.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME sga_docente.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE sga_docente.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

ALTER TABLE sga_docente.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME sga_docente.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE sga_docente.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

ALTER TABLE sga_docente.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME sga_docente.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE sga_docente.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE sga_docente.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

ALTER TABLE sga_docente.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME sga_docente.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

ALTER TABLE sga_docente.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME sga_docente.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE sga_docente.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

ALTER TABLE sga_docente.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME sga_docente.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: calificaciones; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.calificaciones (
    id_calificacion bigint NOT NULL,
    id_actividad integer NOT NULL,
    id_matricula integer NOT NULL,
    nota numeric(4,2),
    nota_cualitativa sga_docente.nota_cualitativa_t,
    observacion text,
    registrado_por integer NOT NULL,
    fecha_registro timestamp with time zone DEFAULT now() NOT NULL,
    fecha_actualizacion timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT nota_rango CHECK (((nota >= (0)::numeric) AND (nota <= (10)::numeric)))
);


ALTER TABLE sga_docente.calificaciones OWNER TO postgres;

--
-- Name: calificaciones_id_calificacion_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

CREATE SEQUENCE sga_docente.calificaciones_id_calificacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_docente.calificaciones_id_calificacion_seq OWNER TO postgres;

--
-- Name: calificaciones_id_calificacion_seq; Type: SEQUENCE OWNED BY; Schema: sga_docente; Owner: postgres
--

ALTER SEQUENCE sga_docente.calificaciones_id_calificacion_seq OWNED BY sga_docente.calificaciones.id_calificacion;


--
-- Name: django_admin_log; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE sga_docente.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

ALTER TABLE sga_docente.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME sga_docente.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE sga_docente.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

ALTER TABLE sga_docente.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME sga_docente.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE sga_docente.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

ALTER TABLE sga_docente.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME sga_docente.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: periodos_evaluacion; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.periodos_evaluacion (
    id_periodo integer NOT NULL,
    id_ano_lectivo integer NOT NULL,
    tipo sga_docente.tipo_periodo_t NOT NULL,
    nombre character varying(40) NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE sga_docente.periodos_evaluacion OWNER TO postgres;

--
-- Name: periodos_evaluacion_id_periodo_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

CREATE SEQUENCE sga_docente.periodos_evaluacion_id_periodo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_docente.periodos_evaluacion_id_periodo_seq OWNER TO postgres;

--
-- Name: periodos_evaluacion_id_periodo_seq; Type: SEQUENCE OWNED BY; Schema: sga_docente; Owner: postgres
--

ALTER SEQUENCE sga_docente.periodos_evaluacion_id_periodo_seq OWNED BY sga_docente.periodos_evaluacion.id_periodo;


--
-- Name: promedios_anuales; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.promedios_anuales (
    id_promedio_anual integer NOT NULL,
    id_matricula integer NOT NULL,
    id_asignacion integer NOT NULL,
    id_ano_lectivo integer NOT NULL,
    promedio_anual numeric(4,2),
    nota_cualitativa sga_docente.nota_cualitativa_t,
    registrado_por integer NOT NULL,
    calculado_en timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_docente.promedios_anuales OWNER TO postgres;

--
-- Name: promedios_anuales_detalle; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.promedios_anuales_detalle (
    id_detalle integer NOT NULL,
    id_promedio_anual integer NOT NULL,
    id_promedio_trim integer NOT NULL
);


ALTER TABLE sga_docente.promedios_anuales_detalle OWNER TO postgres;

--
-- Name: promedios_anuales_detalle_id_detalle_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

CREATE SEQUENCE sga_docente.promedios_anuales_detalle_id_detalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_docente.promedios_anuales_detalle_id_detalle_seq OWNER TO postgres;

--
-- Name: promedios_anuales_detalle_id_detalle_seq; Type: SEQUENCE OWNED BY; Schema: sga_docente; Owner: postgres
--

ALTER SEQUENCE sga_docente.promedios_anuales_detalle_id_detalle_seq OWNED BY sga_docente.promedios_anuales_detalle.id_detalle;


--
-- Name: promedios_anuales_id_promedio_anual_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

CREATE SEQUENCE sga_docente.promedios_anuales_id_promedio_anual_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_docente.promedios_anuales_id_promedio_anual_seq OWNER TO postgres;

--
-- Name: promedios_anuales_id_promedio_anual_seq; Type: SEQUENCE OWNED BY; Schema: sga_docente; Owner: postgres
--

ALTER SEQUENCE sga_docente.promedios_anuales_id_promedio_anual_seq OWNED BY sga_docente.promedios_anuales.id_promedio_anual;


--
-- Name: promedios_trimestrales; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.promedios_trimestrales (
    id_promedio integer NOT NULL,
    id_matricula integer NOT NULL,
    id_asignacion integer NOT NULL,
    id_periodo integer NOT NULL,
    promedio_formativo numeric(4,2),
    nota_sumativa numeric(4,2),
    promedio_trimestral numeric(4,2),
    nota_cualitativa sga_docente.nota_cualitativa_t,
    calculado_en timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_docente.promedios_trimestrales OWNER TO postgres;

--
-- Name: promedios_trimestrales_id_promedio_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

CREATE SEQUENCE sga_docente.promedios_trimestrales_id_promedio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_docente.promedios_trimestrales_id_promedio_seq OWNER TO postgres;

--
-- Name: promedios_trimestrales_id_promedio_seq; Type: SEQUENCE OWNED BY; Schema: sga_docente; Owner: postgres
--

ALTER SEQUENCE sga_docente.promedios_trimestrales_id_promedio_seq OWNED BY sga_docente.promedios_trimestrales.id_promedio;


--
-- Name: resumen_asistencia; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.resumen_asistencia (
    id_resumen integer NOT NULL,
    id_matricula integer NOT NULL,
    id_asignacion integer NOT NULL,
    id_periodo integer NOT NULL,
    total_presentes smallint DEFAULT 0 NOT NULL,
    total_ausentes smallint DEFAULT 0 NOT NULL,
    total_justificados smallint DEFAULT 0 NOT NULL,
    total_atrasos smallint DEFAULT 0 NOT NULL,
    calculado_en timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_docente.resumen_asistencia OWNER TO postgres;

--
-- Name: resumen_asistencia_id_resumen_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

CREATE SEQUENCE sga_docente.resumen_asistencia_id_resumen_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_docente.resumen_asistencia_id_resumen_seq OWNER TO postgres;

--
-- Name: resumen_asistencia_id_resumen_seq; Type: SEQUENCE OWNED BY; Schema: sga_docente; Owner: postgres
--

ALTER SEQUENCE sga_docente.resumen_asistencia_id_resumen_seq OWNED BY sga_docente.resumen_asistencia.id_resumen;


--
-- Name: seguimiento_academico; Type: TABLE; Schema: sga_docente; Owner: postgres
--

CREATE TABLE sga_docente.seguimiento_academico (
    id_seguimiento bigint NOT NULL,
    id_matricula integer NOT NULL,
    id_periodo integer NOT NULL,
    categoria sga_docente.categoria_seguimiento_t DEFAULT 'ACADEMICO'::sga_docente.categoria_seguimiento_t NOT NULL,
    descripcion text NOT NULL,
    acciones_tomadas text,
    requiere_followup boolean DEFAULT false NOT NULL,
    fecha_evento date DEFAULT CURRENT_DATE NOT NULL,
    registrado_por integer NOT NULL,
    fecha_registro timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_docente.seguimiento_academico OWNER TO postgres;

--
-- Name: TABLE seguimiento_academico; Type: COMMENT; Schema: sga_docente; Owner: postgres
--

COMMENT ON TABLE sga_docente.seguimiento_academico IS '[C11] Notas de seguimiento por DECE, tutores o directivos; categorizado por tipo';


--
-- Name: seguimiento_academico_id_seguimiento_seq; Type: SEQUENCE; Schema: sga_docente; Owner: postgres
--

CREATE SEQUENCE sga_docente.seguimiento_academico_id_seguimiento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_docente.seguimiento_academico_id_seguimiento_seq OWNER TO postgres;

--
-- Name: seguimiento_academico_id_seguimiento_seq; Type: SEQUENCE OWNED BY; Schema: sga_docente; Owner: postgres
--

ALTER SEQUENCE sga_docente.seguimiento_academico_id_seguimiento_seq OWNED BY sga_docente.seguimiento_academico.id_seguimiento;


--
-- Name: anos_lectivos; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.anos_lectivos (
    id_ano_lectivo integer NOT NULL,
    nombre character varying(20) NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    es_actual boolean DEFAULT false NOT NULL,
    creado_por integer,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_principal.anos_lectivos OWNER TO postgres;

--
-- Name: anos_lectivos_id_ano_lectivo_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.anos_lectivos_id_ano_lectivo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.anos_lectivos_id_ano_lectivo_seq OWNER TO postgres;

--
-- Name: anos_lectivos_id_ano_lectivo_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.anos_lectivos_id_ano_lectivo_seq OWNED BY sga_principal.anos_lectivos.id_ano_lectivo;


--
-- Name: asignaciones; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.asignaciones (
    id_asignacion integer NOT NULL,
    id_docente integer NOT NULL,
    id_asignatura integer NOT NULL,
    id_grado integer NOT NULL,
    id_paralelo integer NOT NULL,
    id_ano_lectivo integer NOT NULL,
    es_tutor boolean DEFAULT false NOT NULL,
    tipo sga_principal.tipo_asignacion_t DEFAULT 'ESPECIALIZADO'::sga_principal.tipo_asignacion_t NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    asignado_por integer,
    fecha_asignacion timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_principal.asignaciones OWNER TO postgres;

--
-- Name: COLUMN asignaciones.id_paralelo; Type: COMMENT; Schema: sga_principal; Owner: postgres
--

COMMENT ON COLUMN sga_principal.asignaciones.id_paralelo IS '[C2] Permite asignar distintos docentes para la misma asignatura en paralelos diferentes';


--
-- Name: asignaciones_id_asignacion_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.asignaciones_id_asignacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.asignaciones_id_asignacion_seq OWNER TO postgres;

--
-- Name: asignaciones_id_asignacion_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.asignaciones_id_asignacion_seq OWNED BY sga_principal.asignaciones.id_asignacion;


--
-- Name: asignaturas; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.asignaturas (
    id_asignatura integer NOT NULL,
    nombre character varying(100) NOT NULL,
    codigo character varying(20),
    descripcion text,
    horas_semana smallint,
    activa boolean DEFAULT true NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_principal.asignaturas OWNER TO postgres;

--
-- Name: asignaturas_id_asignatura_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.asignaturas_id_asignatura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.asignaturas_id_asignatura_seq OWNER TO postgres;

--
-- Name: asignaturas_id_asignatura_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.asignaturas_id_asignatura_seq OWNED BY sga_principal.asignaturas.id_asignatura;


--
-- Name: asignaturas_por_nivel; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.asignaturas_por_nivel (
    id_asignatura integer NOT NULL,
    id_nivel integer NOT NULL,
    tipo_escala sga_principal.tipo_escala_t NOT NULL
);


ALTER TABLE sga_principal.asignaturas_por_nivel OWNER TO postgres;

--
-- Name: auditoria; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.auditoria (
    id_auditoria bigint NOT NULL,
    schema_origen character varying(20) DEFAULT 'PRINCIPAL'::character varying NOT NULL,
    id_usuario integer,
    username character varying(60),
    accion sga_principal.accion_auditoria_t NOT NULL,
    tabla_afectada character varying(60),
    registro_id bigint,
    descripcion text,
    ip_address character varying(45),
    user_agent text,
    hmac character varying(64),
    fecha timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT auditoria_schema_origen_check CHECK (((schema_origen)::text = ANY (ARRAY[('PRINCIPAL'::character varying)::text, ('DOCENTE'::character varying)::text])))
);


ALTER TABLE sga_principal.auditoria OWNER TO postgres;

--
-- Name: TABLE auditoria; Type: COMMENT; Schema: sga_principal; Owner: postgres
--

COMMENT ON TABLE sga_principal.auditoria IS '[FIX-3] Tabla unificada de auditoría para ambos módulos. Usar schema_origen = ''PRINCIPAL'' o ''DOCENTE'' al insertar desde cada módulo.';


--
-- Name: COLUMN auditoria.schema_origen; Type: COMMENT; Schema: sga_principal; Owner: postgres
--

COMMENT ON COLUMN sga_principal.auditoria.schema_origen IS '[FIX-3] Módulo que originó el evento. PRINCIPAL = sga_principal, DOCENTE = sga_docente.';


--
-- Name: auditoria_id_auditoria_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.auditoria_id_auditoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.auditoria_id_auditoria_seq OWNER TO postgres;

--
-- Name: auditoria_id_auditoria_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.auditoria_id_auditoria_seq OWNED BY sga_principal.auditoria.id_auditoria;


--
-- Name: documentos_matricula; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.documentos_matricula (
    id_documento integer NOT NULL,
    id_matricula integer NOT NULL,
    tipo_documento sga_principal.tipo_documento_t NOT NULL,
    nombre_archivo character varying(200) NOT NULL,
    ruta_archivo character varying(500) NOT NULL,
    fecha_subida timestamp with time zone DEFAULT now() NOT NULL,
    subido_por integer
);


ALTER TABLE sga_principal.documentos_matricula OWNER TO postgres;

--
-- Name: COLUMN documentos_matricula.tipo_documento; Type: COMMENT; Schema: sga_principal; Owner: postgres
--

COMMENT ON COLUMN sga_principal.documentos_matricula.tipo_documento IS '[C12] Catálogo cerrado de documentos requeridos en el proceso de matrícula';


--
-- Name: documentos_matricula_id_documento_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.documentos_matricula_id_documento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.documentos_matricula_id_documento_seq OWNER TO postgres;

--
-- Name: documentos_matricula_id_documento_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.documentos_matricula_id_documento_seq OWNED BY sga_principal.documentos_matricula.id_documento;


--
-- Name: escala_calificaciones; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.escala_calificaciones (
    id_escala integer NOT NULL,
    id_ano_lectivo integer NOT NULL,
    id_nivel integer NOT NULL,
    nota_minima numeric(4,2) NOT NULL,
    nota_maxima numeric(4,2) NOT NULL,
    equivalente_cualitativo character varying(5),
    descripcion character varying(100),
    CONSTRAINT escala_check CHECK ((nota_minima < nota_maxima))
);


ALTER TABLE sga_principal.escala_calificaciones OWNER TO postgres;

--
-- Name: COLUMN escala_calificaciones.id_nivel; Type: COMMENT; Schema: sga_principal; Owner: postgres
--

COMMENT ON COLUMN sga_principal.escala_calificaciones.id_nivel IS '[C6] Diferencia la escala por nivel (Inicial=cualitativa, Básica Media+=cuantitativa)';


--
-- Name: escala_calificaciones_id_escala_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.escala_calificaciones_id_escala_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.escala_calificaciones_id_escala_seq OWNER TO postgres;

--
-- Name: escala_calificaciones_id_escala_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.escala_calificaciones_id_escala_seq OWNED BY sga_principal.escala_calificaciones.id_escala;


--
-- Name: esquema_calificacion; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.esquema_calificacion (
    id_esquema integer NOT NULL,
    id_ano_lectivo integer NOT NULL,
    peso_formativa numeric(5,2) DEFAULT 70.00 NOT NULL,
    peso_sumativa numeric(5,2) DEFAULT 30.00 NOT NULL,
    CONSTRAINT ck_esquema_pesos_100 CHECK (((peso_formativa + peso_sumativa) = (100)::numeric))
);


ALTER TABLE sga_principal.esquema_calificacion OWNER TO postgres;

--
-- Name: esquema_calificacion_id_esquema_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.esquema_calificacion_id_esquema_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.esquema_calificacion_id_esquema_seq OWNER TO postgres;

--
-- Name: esquema_calificacion_id_esquema_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.esquema_calificacion_id_esquema_seq OWNED BY sga_principal.esquema_calificacion.id_esquema;


--
-- Name: estudiantes; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.estudiantes (
    id_estudiante integer NOT NULL,
    cedula character varying(10),
    codigo_estudiante character varying(20),
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    fecha_nacimiento date,
    genero character varying(10),
    direccion text,
    telefono character varying(20),
    telefono_alt character varying(20),
    correo character varying(150),
    discapacidad boolean DEFAULT false NOT NULL,
    tipo_discapacidad character varying(100),
    porcentaje_disc smallint,
    id_representante integer,
    origen_listado character varying(50),
    estado character varying(20) DEFAULT 'ACTIVO'::character varying NOT NULL,
    foto_url character varying(255),
    creado_por integer,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL,
    fecha_actualizacion timestamp with time zone DEFAULT now() NOT NULL,
    carnet_conadis character varying(30),
    nacionalidad character varying(50),
    etnia character varying(50),
    lugar_nacimiento character varying(150),
    vive_con character varying(50),
    numeros_hermanos smallint,
    beneficio_social boolean DEFAULT false,
    CONSTRAINT porcentaje_disc_check CHECK (((porcentaje_disc >= 0) AND (porcentaje_disc <= 100)))
);


ALTER TABLE sga_principal.estudiantes OWNER TO postgres;

--
-- Name: COLUMN estudiantes.origen_listado; Type: COMMENT; Schema: sga_principal; Owner: postgres
--

COMMENT ON COLUMN sga_principal.estudiantes.origen_listado IS '[C10] Tipo de ingreso del estudiante: NUEVO, TRANSFERIDO, REPITENTE, REINGRESO';


--
-- Name: estudiantes_id_estudiante_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.estudiantes_id_estudiante_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.estudiantes_id_estudiante_seq OWNER TO postgres;

--
-- Name: estudiantes_id_estudiante_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.estudiantes_id_estudiante_seq OWNED BY sga_principal.estudiantes.id_estudiante;


--
-- Name: fichas_estudiante; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.fichas_estudiante (
    id_ficha integer NOT NULL,
    id_estudiante integer NOT NULL,
    tipo_sangre character varying(5),
    alergias text,
    medicacion_permanente text,
    enfermedad_catastrofica boolean DEFAULT false NOT NULL,
    detalle_enfermedad text,
    contacto_emergencia character varying(100),
    telefono_emergencia character varying(20),
    direccion_referencia text,
    fecha_actualizacion timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_principal.fichas_estudiante OWNER TO postgres;

--
-- Name: fichas_estudiante_id_ficha_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.fichas_estudiante_id_ficha_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.fichas_estudiante_id_ficha_seq OWNER TO postgres;

--
-- Name: fichas_estudiante_id_ficha_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.fichas_estudiante_id_ficha_seq OWNED BY sga_principal.fichas_estudiante.id_ficha;


--
-- Name: grados; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.grados (
    id_grado integer NOT NULL,
    id_nivel integer NOT NULL,
    nombre character varying(60) NOT NULL,
    orden smallint NOT NULL,
    capacidad_max smallint,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE sga_principal.grados OWNER TO postgres;

--
-- Name: grados_id_grado_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.grados_id_grado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.grados_id_grado_seq OWNER TO postgres;

--
-- Name: grados_id_grado_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.grados_id_grado_seq OWNED BY sga_principal.grados.id_grado;


--
-- Name: historial_promocion; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.historial_promocion (
    id_historial integer NOT NULL,
    id_matricula integer NOT NULL,
    id_estudiante integer NOT NULL,
    id_grado_origen integer NOT NULL,
    id_ano_lectivo integer NOT NULL,
    resultado sga_principal.resultado_promocion_t NOT NULL,
    promedio_anual numeric(4,2),
    observaciones text,
    registrado_por integer,
    fecha_registro timestamp with time zone DEFAULT now() NOT NULL,
    lamport_ts bigint
);


ALTER TABLE sga_principal.historial_promocion OWNER TO postgres;

--
-- Name: TABLE historial_promocion; Type: COMMENT; Schema: sga_principal; Owner: postgres
--

COMMENT ON TABLE sga_principal.historial_promocion IS '[C13] Registro permanente del resultado de cada estudiante al cierre de año lectivo';


--
-- Name: historial_promocion_id_historial_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.historial_promocion_id_historial_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.historial_promocion_id_historial_seq OWNER TO postgres;

--
-- Name: historial_promocion_id_historial_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.historial_promocion_id_historial_seq OWNED BY sga_principal.historial_promocion.id_historial;


--
-- Name: horarios; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.horarios (
    id_horario integer NOT NULL,
    id_asignacion integer NOT NULL,
    id_periodo_diario integer NOT NULL,
    dia_semana sga_principal.dia_semana_t NOT NULL
);


ALTER TABLE sga_principal.horarios OWNER TO postgres;

--
-- Name: horarios_id_horario_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.horarios_id_horario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.horarios_id_horario_seq OWNER TO postgres;

--
-- Name: horarios_id_horario_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.horarios_id_horario_seq OWNED BY sga_principal.horarios.id_horario;


--
-- Name: malla_curricular; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.malla_curricular (
    id_malla integer NOT NULL,
    id_grado integer NOT NULL,
    id_asignatura integer NOT NULL,
    horas_semana smallint NOT NULL,
    dias_semana smallint,
    duracion smallint,
    activo boolean DEFAULT true NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL,
    id_ano_lectivo integer NOT NULL
);


ALTER TABLE sga_principal.malla_curricular OWNER TO postgres;

--
-- Name: malla_curricular_id_malla_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.malla_curricular_id_malla_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.malla_curricular_id_malla_seq OWNER TO postgres;

--
-- Name: malla_curricular_id_malla_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.malla_curricular_id_malla_seq OWNED BY sga_principal.malla_curricular.id_malla;


--
-- Name: matriculas; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.matriculas (
    id_matricula integer NOT NULL,
    id_estudiante integer NOT NULL,
    id_grado integer NOT NULL,
    id_paralelo integer NOT NULL,
    id_ano_lectivo integer NOT NULL,
    numero_orden smallint,
    fecha_registro date DEFAULT CURRENT_DATE NOT NULL,
    estado sga_principal.estado_matricula_t DEFAULT 'ACTIVA'::sga_principal.estado_matricula_t NOT NULL,
    observaciones text,
    registrado_por integer,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_principal.matriculas OWNER TO postgres;

--
-- Name: COLUMN matriculas.id_paralelo; Type: COMMENT; Schema: sga_principal; Owner: postgres
--

COMMENT ON COLUMN sga_principal.matriculas.id_paralelo IS '[C1] Identifica el aula/paralelo específico del estudiante en el año lectivo';


--
-- Name: matriculas_id_matricula_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.matriculas_id_matricula_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.matriculas_id_matricula_seq OWNER TO postgres;

--
-- Name: matriculas_id_matricula_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.matriculas_id_matricula_seq OWNED BY sga_principal.matriculas.id_matricula;


--
-- Name: niveles_educativos; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.niveles_educativos (
    id_nivel integer NOT NULL,
    nombre character varying(60) NOT NULL,
    tipo_escala sga_principal.tipo_escala_t NOT NULL,
    grado_inicio smallint NOT NULL,
    grado_fin smallint NOT NULL
);


ALTER TABLE sga_principal.niveles_educativos OWNER TO postgres;

--
-- Name: niveles_educativos_id_nivel_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.niveles_educativos_id_nivel_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.niveles_educativos_id_nivel_seq OWNER TO postgres;

--
-- Name: niveles_educativos_id_nivel_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.niveles_educativos_id_nivel_seq OWNED BY sga_principal.niveles_educativos.id_nivel;


--
-- Name: paralelos; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.paralelos (
    id_paralelo integer NOT NULL,
    id_grado integer NOT NULL,
    letra character(1) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE sga_principal.paralelos OWNER TO postgres;

--
-- Name: paralelos_ano_lectivo; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.paralelos_ano_lectivo (
    id_paralelo_al integer NOT NULL,
    id_paralelo integer NOT NULL,
    id_ano_lectivo integer NOT NULL,
    capacidad_max smallint DEFAULT 35 NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE sga_principal.paralelos_ano_lectivo OWNER TO postgres;

--
-- Name: TABLE paralelos_ano_lectivo; Type: COMMENT; Schema: sga_principal; Owner: postgres
--

COMMENT ON TABLE sga_principal.paralelos_ano_lectivo IS '[C5] Activa paralelos por año lectivo y registra capacidad real de cada aula';


--
-- Name: paralelos_ano_lectivo_id_paralelo_al_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.paralelos_ano_lectivo_id_paralelo_al_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.paralelos_ano_lectivo_id_paralelo_al_seq OWNER TO postgres;

--
-- Name: paralelos_ano_lectivo_id_paralelo_al_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.paralelos_ano_lectivo_id_paralelo_al_seq OWNED BY sga_principal.paralelos_ano_lectivo.id_paralelo_al;


--
-- Name: paralelos_id_paralelo_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.paralelos_id_paralelo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.paralelos_id_paralelo_seq OWNER TO postgres;

--
-- Name: paralelos_id_paralelo_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.paralelos_id_paralelo_seq OWNED BY sga_principal.paralelos.id_paralelo;


--
-- Name: periodos_diarios; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.periodos_diarios (
    id_periodo_diario integer NOT NULL,
    numero smallint NOT NULL,
    hora_inicio time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    aplica_nivel sga_principal.nivel_educativo_t
);


ALTER TABLE sga_principal.periodos_diarios OWNER TO postgres;

--
-- Name: periodos_diarios_id_periodo_diario_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.periodos_diarios_id_periodo_diario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.periodos_diarios_id_periodo_diario_seq OWNER TO postgres;

--
-- Name: periodos_diarios_id_periodo_diario_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.periodos_diarios_id_periodo_diario_seq OWNED BY sga_principal.periodos_diarios.id_periodo_diario;


--
-- Name: periodos_evaluacion; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.periodos_evaluacion (
    id_periodo integer NOT NULL,
    id_ano_lectivo integer NOT NULL,
    tipo character varying(20) NOT NULL,
    nombre character varying(100) NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE sga_principal.periodos_evaluacion OWNER TO postgres;

--
-- Name: periodos_evaluacion_id_periodo_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.periodos_evaluacion_id_periodo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.periodos_evaluacion_id_periodo_seq OWNER TO postgres;

--
-- Name: periodos_evaluacion_id_periodo_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.periodos_evaluacion_id_periodo_seq OWNED BY sga_principal.periodos_evaluacion.id_periodo;


--
-- Name: personas; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.personas (
    id_persona integer NOT NULL,
    id_usuario integer NOT NULL,
    cedula character varying(10),
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    fecha_nacimiento date,
    genero sga_principal.genero_t,
    telefono character varying(20),
    telefono_alt character varying(20),
    direccion text,
    correo_personal character varying(150),
    titulo_academico character varying(120),
    especializacion character varying(120),
    fecha_ingreso_inst date,
    cargo character varying(80),
    foto_url character varying(255),
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL,
    fecha_actualizacion timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_principal.personas OWNER TO postgres;

--
-- Name: COLUMN personas.fecha_ingreso_inst; Type: COMMENT; Schema: sga_principal; Owner: postgres
--

COMMENT ON COLUMN sga_principal.personas.fecha_ingreso_inst IS '[C9] Fecha en que el docente/personal ingresó a la institución';


--
-- Name: COLUMN personas.cargo; Type: COMMENT; Schema: sga_principal; Owner: postgres
--

COMMENT ON COLUMN sga_principal.personas.cargo IS '[C9] Cargo institucional del personal (Docente, Rector, DECE, Administrativo, etc.)';


--
-- Name: personas_id_persona_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.personas_id_persona_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.personas_id_persona_seq OWNER TO postgres;

--
-- Name: personas_id_persona_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.personas_id_persona_seq OWNED BY sga_principal.personas.id_persona;


--
-- Name: representantes; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.representantes (
    id_representante integer NOT NULL,
    cedula character varying(10),
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    parentesco character varying(50) NOT NULL,
    telefono_principal character varying(20),
    telefono_alt character varying(20),
    correo character varying(150),
    direccion text,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL,
    fecha_actualizacion timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_principal.representantes OWNER TO postgres;

--
-- Name: representantes_id_representante_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.representantes_id_representante_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.representantes_id_representante_seq OWNER TO postgres;

--
-- Name: representantes_id_representante_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.representantes_id_representante_seq OWNED BY sga_principal.representantes.id_representante;


--
-- Name: roles; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.roles (
    id_rol integer NOT NULL,
    nombre character varying(30) NOT NULL,
    descripcion text,
    activo boolean DEFAULT true NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_principal.roles OWNER TO postgres;

--
-- Name: roles_id_rol_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.roles_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.roles_id_rol_seq OWNER TO postgres;

--
-- Name: roles_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.roles_id_rol_seq OWNED BY sga_principal.roles.id_rol;


--
-- Name: tipos_aporte; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.tipos_aporte (
    id_tipo_aporte integer NOT NULL,
    id_ano_lectivo integer NOT NULL,
    nombre character varying(60) NOT NULL,
    tipo_evaluacion character varying(12) DEFAULT 'FORMATIVA'::character varying NOT NULL,
    orden integer DEFAULT 0 NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    CONSTRAINT tipos_aporte_tipo_evaluacion_check CHECK (((tipo_evaluacion)::text = ANY (ARRAY[('FORMATIVA'::character varying)::text, ('SUMATIVA'::character varying)::text])))
);


ALTER TABLE sga_principal.tipos_aporte OWNER TO postgres;

--
-- Name: tipos_aporte_id_tipo_aporte_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.tipos_aporte_id_tipo_aporte_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.tipos_aporte_id_tipo_aporte_seq OWNER TO postgres;

--
-- Name: tipos_aporte_id_tipo_aporte_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.tipos_aporte_id_tipo_aporte_seq OWNED BY sga_principal.tipos_aporte.id_tipo_aporte;


--
-- Name: usuario_roles; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.usuario_roles (
    id_usuario integer NOT NULL,
    id_rol integer NOT NULL,
    asignado_por integer,
    asignado_el timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_principal.usuario_roles OWNER TO postgres;

--
-- Name: usuarios; Type: TABLE; Schema: sga_principal; Owner: postgres
--

CREATE TABLE sga_principal.usuarios (
    id_usuario integer NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    username character varying(60) NOT NULL,
    correo character varying(150) NOT NULL,
    password_hash character varying(255) NOT NULL,
    primer_ingreso boolean DEFAULT true NOT NULL,
    intentos_fallidos smallint DEFAULT 0 NOT NULL,
    bloqueado_hasta timestamp with time zone,
    estado boolean DEFAULT true NOT NULL,
    ultimo_acceso timestamp with time zone,
    creado_por integer,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL,
    fecha_actualizacion timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_principal.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: sga_principal; Owner: postgres
--

CREATE SEQUENCE sga_principal.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_principal.usuarios_id_usuario_seq OWNER TO postgres;

--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: sga_principal; Owner: postgres
--

ALTER SEQUENCE sga_principal.usuarios_id_usuario_seq OWNED BY sga_principal.usuarios.id_usuario;


--
-- Name: documentos_matricula; Type: TABLE; Schema: sga_secretaria; Owner: postgres
--

CREATE TABLE sga_secretaria.documentos_matricula (
    id_documento integer NOT NULL,
    id_matricula integer NOT NULL,
    tipo_documento sga_principal.tipo_documento_t NOT NULL,
    nombre_archivo character varying(200) NOT NULL,
    ruta_archivo character varying(500) NOT NULL,
    subido_por integer
);


ALTER TABLE sga_secretaria.documentos_matricula OWNER TO postgres;

--
-- Name: COLUMN documentos_matricula.tipo_documento; Type: COMMENT; Schema: sga_secretaria; Owner: postgres
--

COMMENT ON COLUMN sga_secretaria.documentos_matricula.tipo_documento IS 'Catalogo cerrado de documentos requeridos en el proceso de matricula';


--
-- Name: documentos_matricula_id_documento_seq; Type: SEQUENCE; Schema: sga_secretaria; Owner: postgres
--

CREATE SEQUENCE sga_secretaria.documentos_matricula_id_documento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_secretaria.documentos_matricula_id_documento_seq OWNER TO postgres;

--
-- Name: documentos_matricula_id_documento_seq; Type: SEQUENCE OWNED BY; Schema: sga_secretaria; Owner: postgres
--

ALTER SEQUENCE sga_secretaria.documentos_matricula_id_documento_seq OWNED BY sga_secretaria.documentos_matricula.id_documento;


--
-- Name: estudiantes; Type: TABLE; Schema: sga_secretaria; Owner: postgres
--

CREATE TABLE sga_secretaria.estudiantes (
    id_estudiante integer NOT NULL,
    cedula character varying(10),
    codigo_estudiante character varying(20),
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    fecha_nacimiento date,
    genero character varying(10),
    direccion text,
    telefono text,
    telefono_alt character varying(20),
    correo character varying(150),
    discapacidad boolean DEFAULT false NOT NULL,
    tipo_discapacidad text,
    porcentaje_disc smallint,
    id_representante integer,
    origen_listado character varying(50),
    estado character varying(20) DEFAULT 'ACTIVO'::character varying NOT NULL,
    foto_url character varying(255),
    creado_por integer,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL,
    fecha_actualizacion timestamp with time zone DEFAULT now() NOT NULL,
    carnet_conadis character varying(30),
    nacionalidad character varying(50),
    etnia character varying(50),
    lugar_nacimiento character varying(150),
    vive_con character varying(50),
    numeros_hermanos smallint,
    beneficio_social boolean DEFAULT false,
    CONSTRAINT porcentaje_disc_check CHECK (((porcentaje_disc >= 0) AND (porcentaje_disc <= 100)))
);


ALTER TABLE sga_secretaria.estudiantes OWNER TO postgres;

--
-- Name: COLUMN estudiantes.origen_listado; Type: COMMENT; Schema: sga_secretaria; Owner: postgres
--

COMMENT ON COLUMN sga_secretaria.estudiantes.origen_listado IS 'Tipo de ingreso del estudiante: NUEVO, TRANSFERIDO, REPITENTE, REINGRESO';


--
-- Name: estudiantes_id_estudiante_seq; Type: SEQUENCE; Schema: sga_secretaria; Owner: postgres
--

CREATE SEQUENCE sga_secretaria.estudiantes_id_estudiante_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_secretaria.estudiantes_id_estudiante_seq OWNER TO postgres;

--
-- Name: estudiantes_id_estudiante_seq; Type: SEQUENCE OWNED BY; Schema: sga_secretaria; Owner: postgres
--

ALTER SEQUENCE sga_secretaria.estudiantes_id_estudiante_seq OWNED BY sga_secretaria.estudiantes.id_estudiante;


--
-- Name: fichas_estudiante; Type: TABLE; Schema: sga_secretaria; Owner: postgres
--

CREATE TABLE sga_secretaria.fichas_estudiante (
    id_ficha integer NOT NULL,
    id_estudiante integer NOT NULL,
    tipo_sangre character varying(5),
    alergias text,
    medicacion_permanente text,
    enfermedad_catastrofica boolean DEFAULT false NOT NULL,
    detalle_enfermedad text,
    contacto_emergencia character varying(100),
    telefono_emergencia character varying(20),
    direccion_referencia text,
    fecha_actualizacion timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_secretaria.fichas_estudiante OWNER TO postgres;

--
-- Name: fichas_estudiante_id_ficha_seq; Type: SEQUENCE; Schema: sga_secretaria; Owner: postgres
--

CREATE SEQUENCE sga_secretaria.fichas_estudiante_id_ficha_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_secretaria.fichas_estudiante_id_ficha_seq OWNER TO postgres;

--
-- Name: fichas_estudiante_id_ficha_seq; Type: SEQUENCE OWNED BY; Schema: sga_secretaria; Owner: postgres
--

ALTER SEQUENCE sga_secretaria.fichas_estudiante_id_ficha_seq OWNED BY sga_secretaria.fichas_estudiante.id_ficha;


--
-- Name: historial_promocion; Type: TABLE; Schema: sga_secretaria; Owner: postgres
--

CREATE TABLE sga_secretaria.historial_promocion (
    id_historial integer NOT NULL,
    id_matricula integer NOT NULL,
    id_estudiante integer NOT NULL,
    id_grado_origen integer NOT NULL,
    id_ano_lectivo integer NOT NULL,
    resultado sga_principal.resultado_promocion_t NOT NULL,
    promedio_anual numeric(4,2),
    observaciones text,
    registrado_por integer,
    fecha_registro timestamp with time zone DEFAULT now() NOT NULL,
    lamport_ts bigint
);


ALTER TABLE sga_secretaria.historial_promocion OWNER TO postgres;

--
-- Name: TABLE historial_promocion; Type: COMMENT; Schema: sga_secretaria; Owner: postgres
--

COMMENT ON TABLE sga_secretaria.historial_promocion IS 'Registro permanente del resultado de cada estudiante al cierre de ano lectivo';


--
-- Name: historial_promocion_id_historial_seq; Type: SEQUENCE; Schema: sga_secretaria; Owner: postgres
--

CREATE SEQUENCE sga_secretaria.historial_promocion_id_historial_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_secretaria.historial_promocion_id_historial_seq OWNER TO postgres;

--
-- Name: historial_promocion_id_historial_seq; Type: SEQUENCE OWNED BY; Schema: sga_secretaria; Owner: postgres
--

ALTER SEQUENCE sga_secretaria.historial_promocion_id_historial_seq OWNED BY sga_secretaria.historial_promocion.id_historial;


--
-- Name: matriculas; Type: TABLE; Schema: sga_secretaria; Owner: postgres
--

CREATE TABLE sga_secretaria.matriculas (
    id_matricula integer NOT NULL,
    id_estudiante integer NOT NULL,
    id_grado integer NOT NULL,
    id_paralelo integer NOT NULL,
    id_ano_lectivo integer NOT NULL,
    numero_orden smallint,
    fecha_registro date DEFAULT CURRENT_DATE NOT NULL,
    estado sga_principal.estado_matricula_t DEFAULT 'ACTIVA'::sga_principal.estado_matricula_t NOT NULL,
    observaciones text,
    registrado_por integer,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_secretaria.matriculas OWNER TO postgres;

--
-- Name: COLUMN matriculas.id_paralelo; Type: COMMENT; Schema: sga_secretaria; Owner: postgres
--

COMMENT ON COLUMN sga_secretaria.matriculas.id_paralelo IS 'Identifica el aula/paralelo especifico del estudiante en el ano lectivo';


--
-- Name: matriculas_id_matricula_seq; Type: SEQUENCE; Schema: sga_secretaria; Owner: postgres
--

CREATE SEQUENCE sga_secretaria.matriculas_id_matricula_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_secretaria.matriculas_id_matricula_seq OWNER TO postgres;

--
-- Name: matriculas_id_matricula_seq; Type: SEQUENCE OWNED BY; Schema: sga_secretaria; Owner: postgres
--

ALTER SEQUENCE sga_secretaria.matriculas_id_matricula_seq OWNED BY sga_secretaria.matriculas.id_matricula;


--
-- Name: representantes; Type: TABLE; Schema: sga_secretaria; Owner: postgres
--

CREATE TABLE sga_secretaria.representantes (
    id_representante integer NOT NULL,
    cedula character varying(10),
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    parentesco character varying(50) NOT NULL,
    telefono_principal text,
    telefono_alt character varying(20),
    correo character varying(150),
    direccion text,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL,
    fecha_actualizacion timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE sga_secretaria.representantes OWNER TO postgres;

--
-- Name: representantes_id_representante_seq; Type: SEQUENCE; Schema: sga_secretaria; Owner: postgres
--

CREATE SEQUENCE sga_secretaria.representantes_id_representante_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sga_secretaria.representantes_id_representante_seq OWNER TO postgres;

--
-- Name: representantes_id_representante_seq; Type: SEQUENCE OWNED BY; Schema: sga_secretaria; Owner: postgres
--

ALTER SEQUENCE sga_secretaria.representantes_id_representante_seq OWNED BY sga_secretaria.representantes.id_representante;


--
-- Name: actividades id_actividad; Type: DEFAULT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.actividades ALTER COLUMN id_actividad SET DEFAULT nextval('sga_docente.actividades_id_actividad_seq'::regclass);


--
-- Name: asistencias id_asistencia; Type: DEFAULT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.asistencias ALTER COLUMN id_asistencia SET DEFAULT nextval('sga_docente.asistencias_id_asistencia_seq'::regclass);


--
-- Name: calificaciones id_calificacion; Type: DEFAULT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.calificaciones ALTER COLUMN id_calificacion SET DEFAULT nextval('sga_docente.calificaciones_id_calificacion_seq'::regclass);


--
-- Name: periodos_evaluacion id_periodo; Type: DEFAULT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.periodos_evaluacion ALTER COLUMN id_periodo SET DEFAULT nextval('sga_docente.periodos_evaluacion_id_periodo_seq'::regclass);


--
-- Name: promedios_anuales id_promedio_anual; Type: DEFAULT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_anuales ALTER COLUMN id_promedio_anual SET DEFAULT nextval('sga_docente.promedios_anuales_id_promedio_anual_seq'::regclass);


--
-- Name: promedios_anuales_detalle id_detalle; Type: DEFAULT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_anuales_detalle ALTER COLUMN id_detalle SET DEFAULT nextval('sga_docente.promedios_anuales_detalle_id_detalle_seq'::regclass);


--
-- Name: promedios_trimestrales id_promedio; Type: DEFAULT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_trimestrales ALTER COLUMN id_promedio SET DEFAULT nextval('sga_docente.promedios_trimestrales_id_promedio_seq'::regclass);


--
-- Name: resumen_asistencia id_resumen; Type: DEFAULT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.resumen_asistencia ALTER COLUMN id_resumen SET DEFAULT nextval('sga_docente.resumen_asistencia_id_resumen_seq'::regclass);


--
-- Name: seguimiento_academico id_seguimiento; Type: DEFAULT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.seguimiento_academico ALTER COLUMN id_seguimiento SET DEFAULT nextval('sga_docente.seguimiento_academico_id_seguimiento_seq'::regclass);


--
-- Name: anos_lectivos id_ano_lectivo; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.anos_lectivos ALTER COLUMN id_ano_lectivo SET DEFAULT nextval('sga_principal.anos_lectivos_id_ano_lectivo_seq'::regclass);


--
-- Name: asignaciones id_asignacion; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.asignaciones ALTER COLUMN id_asignacion SET DEFAULT nextval('sga_principal.asignaciones_id_asignacion_seq'::regclass);


--
-- Name: asignaturas id_asignatura; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.asignaturas ALTER COLUMN id_asignatura SET DEFAULT nextval('sga_principal.asignaturas_id_asignatura_seq'::regclass);


--
-- Name: auditoria id_auditoria; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.auditoria ALTER COLUMN id_auditoria SET DEFAULT nextval('sga_principal.auditoria_id_auditoria_seq'::regclass);


--
-- Name: documentos_matricula id_documento; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.documentos_matricula ALTER COLUMN id_documento SET DEFAULT nextval('sga_principal.documentos_matricula_id_documento_seq'::regclass);


--
-- Name: escala_calificaciones id_escala; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.escala_calificaciones ALTER COLUMN id_escala SET DEFAULT nextval('sga_principal.escala_calificaciones_id_escala_seq'::regclass);


--
-- Name: esquema_calificacion id_esquema; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.esquema_calificacion ALTER COLUMN id_esquema SET DEFAULT nextval('sga_principal.esquema_calificacion_id_esquema_seq'::regclass);


--
-- Name: estudiantes id_estudiante; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.estudiantes ALTER COLUMN id_estudiante SET DEFAULT nextval('sga_principal.estudiantes_id_estudiante_seq'::regclass);


--
-- Name: fichas_estudiante id_ficha; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.fichas_estudiante ALTER COLUMN id_ficha SET DEFAULT nextval('sga_principal.fichas_estudiante_id_ficha_seq'::regclass);


--
-- Name: grados id_grado; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.grados ALTER COLUMN id_grado SET DEFAULT nextval('sga_principal.grados_id_grado_seq'::regclass);


--
-- Name: historial_promocion id_historial; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.historial_promocion ALTER COLUMN id_historial SET DEFAULT nextval('sga_principal.historial_promocion_id_historial_seq'::regclass);


--
-- Name: horarios id_horario; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.horarios ALTER COLUMN id_horario SET DEFAULT nextval('sga_principal.horarios_id_horario_seq'::regclass);


--
-- Name: malla_curricular id_malla; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.malla_curricular ALTER COLUMN id_malla SET DEFAULT nextval('sga_principal.malla_curricular_id_malla_seq'::regclass);


--
-- Name: matriculas id_matricula; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.matriculas ALTER COLUMN id_matricula SET DEFAULT nextval('sga_principal.matriculas_id_matricula_seq'::regclass);


--
-- Name: niveles_educativos id_nivel; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.niveles_educativos ALTER COLUMN id_nivel SET DEFAULT nextval('sga_principal.niveles_educativos_id_nivel_seq'::regclass);


--
-- Name: paralelos id_paralelo; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.paralelos ALTER COLUMN id_paralelo SET DEFAULT nextval('sga_principal.paralelos_id_paralelo_seq'::regclass);


--
-- Name: paralelos_ano_lectivo id_paralelo_al; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.paralelos_ano_lectivo ALTER COLUMN id_paralelo_al SET DEFAULT nextval('sga_principal.paralelos_ano_lectivo_id_paralelo_al_seq'::regclass);


--
-- Name: periodos_diarios id_periodo_diario; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.periodos_diarios ALTER COLUMN id_periodo_diario SET DEFAULT nextval('sga_principal.periodos_diarios_id_periodo_diario_seq'::regclass);


--
-- Name: periodos_evaluacion id_periodo; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.periodos_evaluacion ALTER COLUMN id_periodo SET DEFAULT nextval('sga_principal.periodos_evaluacion_id_periodo_seq'::regclass);


--
-- Name: personas id_persona; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.personas ALTER COLUMN id_persona SET DEFAULT nextval('sga_principal.personas_id_persona_seq'::regclass);


--
-- Name: representantes id_representante; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.representantes ALTER COLUMN id_representante SET DEFAULT nextval('sga_principal.representantes_id_representante_seq'::regclass);


--
-- Name: roles id_rol; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.roles ALTER COLUMN id_rol SET DEFAULT nextval('sga_principal.roles_id_rol_seq'::regclass);


--
-- Name: tipos_aporte id_tipo_aporte; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.tipos_aporte ALTER COLUMN id_tipo_aporte SET DEFAULT nextval('sga_principal.tipos_aporte_id_tipo_aporte_seq'::regclass);


--
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('sga_principal.usuarios_id_usuario_seq'::regclass);


--
-- Name: documentos_matricula id_documento; Type: DEFAULT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.documentos_matricula ALTER COLUMN id_documento SET DEFAULT nextval('sga_secretaria.documentos_matricula_id_documento_seq'::regclass);


--
-- Name: estudiantes id_estudiante; Type: DEFAULT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.estudiantes ALTER COLUMN id_estudiante SET DEFAULT nextval('sga_secretaria.estudiantes_id_estudiante_seq'::regclass);


--
-- Name: fichas_estudiante id_ficha; Type: DEFAULT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.fichas_estudiante ALTER COLUMN id_ficha SET DEFAULT nextval('sga_secretaria.fichas_estudiante_id_ficha_seq'::regclass);


--
-- Name: historial_promocion id_historial; Type: DEFAULT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.historial_promocion ALTER COLUMN id_historial SET DEFAULT nextval('sga_secretaria.historial_promocion_id_historial_seq'::regclass);


--
-- Name: matriculas id_matricula; Type: DEFAULT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.matriculas ALTER COLUMN id_matricula SET DEFAULT nextval('sga_secretaria.matriculas_id_matricula_seq'::regclass);


--
-- Name: representantes id_representante; Type: DEFAULT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.representantes ALTER COLUMN id_representante SET DEFAULT nextval('sga_secretaria.representantes_id_representante_seq'::regclass);


--
-- Data for Name: actividades; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.actividades (id_actividad, id_asignacion, id_periodo, tipo, nombre, descripcion, fecha_entrega, ponderacion, nota_maxima, es_sumativa, fecha_creacion) FROM stdin;
7	11	1	TAREA	Circuito de habilidades motrices básicas	Realizar un circuito de ejercicios que incluya correr, saltar, lanzar y mantener el equilibrio. El estudiante deberá completar cada estación siguiendo las indicaciones del docente, demostrando coordinación, agilidad y participación activa durante la actividad.	2026-05-01	10.00	10.00	t	2026-07-26 18:54:31.46224+00
\.


--
-- Data for Name: asistencias; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.asistencias (id_asistencia, id_matricula, id_asignacion, id_periodo, fecha, estado, justificacion, registrado_por, fecha_registro, fecha_actualizacion) FROM stdin;
119	441	19	1	2026-04-29	AUSENTE		13	2026-07-29 01:51:56.273587+00	2026-07-29 01:51:56.273587+00
120	442	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.273587+00	2026-07-29 01:51:56.273587+00
121	443	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.273587+00	2026-07-29 01:51:56.273587+00
122	444	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.273587+00	2026-07-29 01:51:56.273587+00
123	445	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.273587+00	2026-07-29 01:51:56.273587+00
124	446	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.273587+00	2026-07-29 01:51:56.273587+00
125	447	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.273587+00	2026-07-29 01:51:56.273587+00
126	448	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.273587+00	2026-07-29 01:51:56.273587+00
127	449	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.273587+00	2026-07-29 01:51:56.273587+00
128	450	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.274603+00	2026-07-29 01:51:56.274603+00
129	451	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.274603+00	2026-07-29 01:51:56.274603+00
130	452	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.274603+00	2026-07-29 01:51:56.274603+00
131	453	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.274603+00	2026-07-29 01:51:56.274603+00
132	454	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.274603+00	2026-07-29 01:51:56.274603+00
133	455	19	1	2026-04-29	PRESENTE		13	2026-07-29 01:51:56.274603+00	2026-07-29 01:51:56.274603+00
134	456	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.274603+00	2026-07-29 01:51:56.274603+00
135	457	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.274603+00	2026-07-29 01:51:56.274603+00
136	458	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.274603+00	2026-07-29 01:51:56.274603+00
137	459	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.274603+00	2026-07-29 01:51:56.274603+00
138	460	19	1	2026-04-29	JUSTIFICADO		13	2026-07-29 01:51:56.274603+00	2026-07-29 01:51:56.274603+00
139	561	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
140	562	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
141	563	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
142	564	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
143	565	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
144	566	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
145	567	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
146	568	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
147	569	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
148	570	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
149	571	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
150	572	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
151	573	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
152	574	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
153	575	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
154	576	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
155	577	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
156	578	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
157	579	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
158	580	14	1	2026-04-27	AUSENTE		13	2026-07-29 02:25:06.637199+00	2026-07-29 02:25:06.637199+00
159	561	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
160	562	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
161	563	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
162	564	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
163	565	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
164	566	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
165	567	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
166	568	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
167	569	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
168	570	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
169	571	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
170	572	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
171	573	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
172	574	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
173	575	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
174	576	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
175	577	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
99	441	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
100	442	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
101	443	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
102	444	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
103	445	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
104	446	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
105	447	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
106	448	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
107	449	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
108	450	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
109	451	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
110	452	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
111	453	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
112	454	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
113	455	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
114	456	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
115	457	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
116	458	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
117	459	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
118	460	19	1	2026-04-27	PRESENTE		13	2026-07-28 19:10:54.088563+00	2026-07-28 19:10:54.088563+00
176	578	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
177	579	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
178	580	14	1	2026-04-28	AUSENTE		13	2026-07-29 02:25:15.512047+00	2026-07-29 02:25:15.512047+00
179	441	20	1	2026-04-27	JUSTIFICADO		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
180	442	20	1	2026-04-27	AUSENTE		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
181	443	20	1	2026-04-27	JUSTIFICADO		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
182	444	20	1	2026-04-27	PRESENTE		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
183	445	20	1	2026-04-27	PRESENTE		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
184	446	20	1	2026-04-27	AUSENTE		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
185	447	20	1	2026-04-27	PRESENTE		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
186	448	20	1	2026-04-27	PRESENTE		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
187	449	20	1	2026-04-27	PRESENTE		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
188	450	20	1	2026-04-27	PRESENTE		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
189	451	20	1	2026-04-27	AUSENTE		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
190	452	20	1	2026-04-27	PRESENTE		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
191	453	20	1	2026-04-27	PRESENTE		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
192	454	20	1	2026-04-27	PRESENTE		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
193	455	20	1	2026-04-27	AUSENTE		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
194	456	20	1	2026-04-27	PRESENTE		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
195	457	20	1	2026-04-27	PRESENTE		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
196	458	20	1	2026-04-27	PRESENTE		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
197	459	20	1	2026-04-27	ATRASO		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
198	460	20	1	2026-04-27	ATRASO		13	2026-07-29 02:43:01.226158+00	2026-07-29 02:43:01.226158+00
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.auth_permission (id, name, content_type_id, codename) FROM stdin;
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: calificaciones; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.calificaciones (id_calificacion, id_actividad, id_matricula, nota, nota_cualitativa, observacion, registrado_por, fecha_registro, fecha_actualizacion) FROM stdin;
9	7	80	10.00	\N	\N	12	2026-07-26 22:38:00.639883+00	2026-07-26 22:38:00.639883+00
10	7	79	9.00	\N	\N	12	2026-07-26 22:38:03.087688+00	2026-07-26 22:38:03.087688+00
11	7	78	10.00	\N	\N	12	2026-07-26 22:38:08.324544+00	2026-07-26 22:38:08.324544+00
12	7	77	8.00	\N	\N	12	2026-07-26 22:38:10.000594+00	2026-07-26 22:38:10.000594+00
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.django_content_type (id, app_label, model) FROM stdin;
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2026-07-06 13:49:56.442364+00
2	auth	0001_initial	2026-07-06 13:49:59.621649+00
3	admin	0001_initial	2026-07-06 13:50:00.471964+00
4	admin	0002_logentry_remove_auto_add	2026-07-06 13:50:00.581781+00
5	admin	0003_logentry_add_action_flag_choices	2026-07-06 13:50:00.890777+00
6	contenttypes	0002_remove_content_type_name	2026-07-06 13:50:01.536201+00
7	auth	0002_alter_permission_name_max_length	2026-07-06 13:50:01.954674+00
8	auth	0003_alter_user_email_max_length	2026-07-06 13:50:03.414373+00
9	auth	0004_alter_user_username_opts	2026-07-06 13:50:04.1026+00
10	auth	0005_alter_user_last_login_null	2026-07-06 13:50:06.279197+00
11	auth	0006_require_contenttypes_0002	2026-07-06 13:50:07.064657+00
12	auth	0007_alter_validators_add_error_messages	2026-07-06 13:50:08.012022+00
13	auth	0008_alter_user_username_max_length	2026-07-06 13:50:08.538137+00
14	auth	0009_alter_user_last_name_max_length	2026-07-06 13:50:08.956624+00
15	auth	0010_alter_group_name_max_length	2026-07-06 13:50:09.369371+00
16	auth	0011_update_proxy_permissions	2026-07-06 13:50:09.578289+00
17	auth	0012_alter_user_first_name_max_length	2026-07-06 13:50:10.217764+00
\.


--
-- Data for Name: periodos_evaluacion; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.periodos_evaluacion (id_periodo, id_ano_lectivo, tipo, nombre, fecha_inicio, fecha_fin, activo) FROM stdin;
1	1	PRIMER_TRIMESTRE	Primer Trimestre 2026-2027	2026-05-01	2026-08-31	t
\.


--
-- Data for Name: promedios_anuales; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.promedios_anuales (id_promedio_anual, id_matricula, id_asignacion, id_ano_lectivo, promedio_anual, nota_cualitativa, registrado_por, calculado_en) FROM stdin;
\.


--
-- Data for Name: promedios_anuales_detalle; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.promedios_anuales_detalle (id_detalle, id_promedio_anual, id_promedio_trim) FROM stdin;
\.


--
-- Data for Name: promedios_trimestrales; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.promedios_trimestrales (id_promedio, id_matricula, id_asignacion, id_periodo, promedio_formativo, nota_sumativa, promedio_trimestral, nota_cualitativa, calculado_en) FROM stdin;
\.


--
-- Data for Name: resumen_asistencia; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.resumen_asistencia (id_resumen, id_matricula, id_asignacion, id_periodo, total_presentes, total_ausentes, total_justificados, total_atrasos, calculado_en) FROM stdin;
2	80	11	1	1	0	0	0	2026-07-27 01:15:33.362712+00
3	79	11	1	1	0	0	0	2026-07-27 01:15:34.280579+00
4	78	11	1	1	0	0	0	2026-07-27 01:15:35.921182+00
5	77	11	1	1	0	0	0	2026-07-27 01:15:39.240442+00
6	76	11	1	1	0	0	0	2026-07-27 01:15:41.327913+00
7	75	11	1	1	0	0	0	2026-07-27 01:15:42.20613+00
8	74	11	1	1	0	0	0	2026-07-27 01:15:43.086935+00
9	73	11	1	1	0	0	0	2026-07-27 01:15:45.205505+00
10	72	11	1	1	0	0	0	2026-07-27 01:15:48.611964+00
11	71	11	1	1	0	0	0	2026-07-27 01:15:51.739648+00
12	70	11	1	1	0	0	0	2026-07-27 01:15:52.622097+00
13	69	11	1	1	0	0	0	2026-07-27 01:15:54.924308+00
14	68	11	1	1	0	0	0	2026-07-27 01:15:58.17764+00
15	67	11	1	1	0	0	0	2026-07-27 01:15:59.908627+00
16	66	11	1	1	0	0	0	2026-07-27 01:16:00.815563+00
17	65	11	1	1	0	0	0	2026-07-27 01:16:01.737361+00
18	64	11	1	1	0	0	0	2026-07-27 01:16:02.615105+00
19	63	11	1	1	0	0	0	2026-07-27 01:16:04.073871+00
20	62	11	1	1	0	0	0	2026-07-27 01:16:05.761785+00
21	61	11	1	1	0	0	0	2026-07-27 01:16:07.420773+00
22	60	11	1	1	0	0	0	2026-07-27 01:16:11.098519+00
23	59	11	1	1	0	0	0	2026-07-27 01:16:13.520877+00
24	58	11	1	1	0	0	0	2026-07-27 01:16:14.530148+00
25	57	11	1	1	0	0	0	2026-07-27 01:16:17.850198+00
26	56	11	1	1	0	0	0	2026-07-27 01:16:20.683986+00
27	55	11	1	1	0	0	0	2026-07-27 01:16:21.595354+00
28	54	11	1	1	0	0	0	2026-07-27 01:16:22.474953+00
29	53	11	1	1	0	0	0	2026-07-27 01:16:23.57597+00
30	52	11	1	1	0	0	0	2026-07-27 01:16:25.499744+00
31	51	11	1	1	0	0	0	2026-07-27 01:16:27.299603+00
32	50	11	1	1	0	0	0	2026-07-27 01:16:28.981562+00
33	49	11	1	1	0	0	0	2026-07-27 01:16:32.65697+00
34	48	11	1	1	0	0	0	2026-07-27 01:16:35.078373+00
35	47	11	1	1	0	0	0	2026-07-27 01:16:35.964368+00
36	46	11	1	1	0	0	0	2026-07-27 01:16:39.520488+00
37	45	11	1	1	0	0	0	2026-07-27 01:16:42.261583+00
38	44	11	1	1	0	0	0	2026-07-27 01:16:43.152201+00
39	43	11	1	1	0	0	0	2026-07-27 01:16:46.372357+00
40	42	11	1	1	0	0	0	2026-07-27 01:16:49.472552+00
118	441	19	1	1	1	0	0	2026-07-29 01:51:56.621786+00
119	442	19	1	1	0	1	0	2026-07-29 01:51:56.621786+00
120	443	19	1	1	0	1	0	2026-07-29 01:51:56.621786+00
121	444	19	1	1	0	1	0	2026-07-29 01:51:56.621786+00
122	445	19	1	1	0	1	0	2026-07-29 01:51:56.621786+00
123	446	19	1	1	0	1	0	2026-07-29 01:51:56.621786+00
124	447	19	1	1	0	1	0	2026-07-29 01:51:56.621786+00
125	448	19	1	1	0	1	0	2026-07-29 01:51:56.621786+00
126	449	19	1	1	0	1	0	2026-07-29 01:51:56.621786+00
127	450	19	1	1	0	1	0	2026-07-29 01:51:56.621786+00
128	451	19	1	1	0	1	0	2026-07-29 01:51:56.621786+00
129	452	19	1	1	0	1	0	2026-07-29 01:51:56.621786+00
130	453	19	1	1	0	1	0	2026-07-29 01:51:56.621786+00
131	454	19	1	1	0	1	0	2026-07-29 01:51:56.621786+00
132	455	19	1	2	0	0	0	2026-07-29 01:51:56.622794+00
133	456	19	1	1	0	1	0	2026-07-29 01:51:56.622794+00
134	457	19	1	1	0	1	0	2026-07-29 01:51:56.622794+00
135	458	19	1	1	0	1	0	2026-07-29 01:51:56.622794+00
136	459	19	1	1	0	1	0	2026-07-29 01:51:56.622794+00
137	460	19	1	1	0	1	0	2026-07-29 01:51:56.622794+00
158	561	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
159	562	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
160	563	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
161	564	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
162	565	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
163	566	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
164	567	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
165	568	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
166	569	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
167	570	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
168	571	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
169	572	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
170	573	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
171	574	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
172	575	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
173	576	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
174	577	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
175	578	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
176	579	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
177	580	14	1	0	2	0	0	2026-07-29 02:25:15.852269+00
178	441	20	1	0	0	1	0	2026-07-29 02:43:01.565394+00
179	442	20	1	0	1	0	0	2026-07-29 02:43:01.565394+00
180	443	20	1	0	0	1	0	2026-07-29 02:43:01.565394+00
181	444	20	1	1	0	0	0	2026-07-29 02:43:01.565394+00
182	445	20	1	1	0	0	0	2026-07-29 02:43:01.565394+00
183	446	20	1	0	1	0	0	2026-07-29 02:43:01.565394+00
184	447	20	1	1	0	0	0	2026-07-29 02:43:01.565394+00
185	448	20	1	1	0	0	0	2026-07-29 02:43:01.565394+00
186	449	20	1	1	0	0	0	2026-07-29 02:43:01.565394+00
187	450	20	1	1	0	0	0	2026-07-29 02:43:01.566392+00
188	451	20	1	0	1	0	0	2026-07-29 02:43:01.566392+00
189	452	20	1	1	0	0	0	2026-07-29 02:43:01.566392+00
190	453	20	1	1	0	0	0	2026-07-29 02:43:01.566392+00
191	454	20	1	1	0	0	0	2026-07-29 02:43:01.566392+00
192	455	20	1	0	1	0	0	2026-07-29 02:43:01.566392+00
193	456	20	1	1	0	0	0	2026-07-29 02:43:01.566392+00
194	457	20	1	1	0	0	0	2026-07-29 02:43:01.566392+00
195	458	20	1	1	0	0	0	2026-07-29 02:43:01.566392+00
196	459	20	1	0	0	0	1	2026-07-29 02:43:01.566392+00
197	460	20	1	0	0	0	1	2026-07-29 02:43:01.566392+00
\.


--
-- Data for Name: seguimiento_academico; Type: TABLE DATA; Schema: sga_docente; Owner: postgres
--

COPY sga_docente.seguimiento_academico (id_seguimiento, id_matricula, id_periodo, categoria, descripcion, acciones_tomadas, requiere_followup, fecha_evento, registrado_por, fecha_registro) FROM stdin;
\.


--
-- Data for Name: anos_lectivos; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.anos_lectivos (id_ano_lectivo, nombre, fecha_inicio, fecha_fin, es_actual, creado_por, fecha_creacion) FROM stdin;
1	2026 - 2027	2026-05-01	2027-02-28	t	1	2026-06-02 03:15:32.929711+00
\.


--
-- Data for Name: asignaciones; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.asignaciones (id_asignacion, id_docente, id_asignatura, id_grado, id_paralelo, id_ano_lectivo, es_tutor, tipo, activo, asignado_por, fecha_asignacion) FROM stdin;
8	10	6	3	7	1	f	ESPECIALIZADO	t	3	2026-07-23 01:43:16.685702+00
11	5	6	4	9	1	f	ESPECIALIZADO	t	12	2026-07-26 18:20:02.979561+00
10	5	2	3	7	1	f	ESPECIALIZADO	t	12	2026-07-26 18:06:55.990504+00
12	6	5	12	25	1	f	ESPECIALIZADO	t	12	2026-07-27 03:58:09.775396+00
13	6	4	12	25	1	f	ESPECIALIZADO	t	12	2026-07-27 03:58:51.171583+00
14	6	5	11	23	1	f	ESPECIALIZADO	t	12	2026-07-27 04:12:41.122026+00
15	6	4	11	23	1	f	ESPECIALIZADO	t	12	2026-07-27 04:13:06.100019+00
17	6	4	10	21	1	f	ESPECIALIZADO	t	12	2026-07-27 04:14:40.515555+00
18	6	13	10	21	1	f	ESPECIALIZADO	t	12	2026-07-27 04:15:07.696794+00
19	6	6	9	19	1	f	ESPECIALIZADO	t	12	2026-07-27 04:16:29.754789+00
20	6	4	9	19	1	f	ESPECIALIZADO	t	12	2026-07-27 04:17:00.172958+00
16	6	6	10	21	1	t	ESPECIALIZADO	t	12	2026-07-27 04:14:09.179419+00
21	16	8	12	25	1	f	ESPECIALIZADO	t	12	2026-07-27 04:19:18.273286+00
22	16	1	12	25	1	f	ESPECIALIZADO	t	12	2026-07-27 04:19:52.421824+00
23	16	15	11	23	1	t	ESPECIALIZADO	t	12	2026-07-27 04:20:26.104128+00
25	16	8	11	23	1	f	ESPECIALIZADO	t	12	2026-07-27 04:20:56.978501+00
26	16	1	11	23	1	f	ESPECIALIZADO	t	12	2026-07-27 04:21:22.708252+00
27	16	13	11	23	1	f	ESPECIALIZADO	t	12	2026-07-27 04:21:43.219683+00
28	16	15	10	21	1	f	ESPECIALIZADO	t	12	2026-07-27 04:22:00.110908+00
29	16	8	10	21	1	f	ESPECIALIZADO	t	12	2026-07-27 04:22:22.47664+00
30	16	1	10	21	1	f	ESPECIALIZADO	t	12	2026-07-27 04:22:45.759321+00
7	10	1	4	9	1	f	ESPECIALIZADO	t	3	2026-07-23 01:10:42.374159+00
5	10	2	4	9	1	t	ESPECIALIZADO	t	\N	2026-07-23 00:36:05.134923+00
31	17	15	12	25	1	t	ESPECIALIZADO	t	12	2026-07-27 04:25:12.554639+00
32	17	13	12	25	1	f	ESPECIALIZADO	t	12	2026-07-27 04:25:37.63934+00
33	17	5	10	21	1	f	ESPECIALIZADO	t	12	2026-07-27 04:28:44.704583+00
34	17	3	7	15	1	f	ESPECIALIZADO	t	12	2026-07-27 04:29:09.089531+00
35	17	4	7	15	1	f	ESPECIALIZADO	t	12	2026-07-27 04:29:36.825219+00
36	17	7	4	9	1	f	ESPECIALIZADO	t	12	2026-07-27 04:29:59.355577+00
37	17	8	9	19	1	f	ESPECIALIZADO	t	12	2026-07-27 04:30:17.499642+00
38	17	5	9	19	1	f	ESPECIALIZADO	t	12	2026-07-27 04:30:37.367628+00
39	17	8	8	17	1	f	ESPECIALIZADO	t	12	2026-07-27 04:31:01.282409+00
40	17	5	8	17	1	f	ESPECIALIZADO	t	12	2026-07-27 04:31:23.427773+00
41	17	6	8	17	1	f	ESPECIALIZADO	t	12	2026-07-27 04:31:51.790659+00
\.


--
-- Data for Name: asignaturas; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.asignaturas (id_asignatura, nombre, codigo, descripcion, horas_semana, activa, fecha_creacion) FROM stdin;
1	Lengua y Literatura	LEN	\N	\N	t	2026-05-29 04:18:24.904419+00
2	Matemática	MAT	\N	\N	t	2026-05-29 04:18:24.904419+00
3	Ciencias Naturales	CN	\N	\N	t	2026-05-29 04:18:24.904419+00
4	Ciencias Sociales	CS	\N	\N	t	2026-05-29 04:18:24.904419+00
5	Educación Cultural y Artística	ECA	\N	\N	t	2026-05-29 04:18:24.904419+00
6	Educación Física	EF	\N	\N	t	2026-05-29 04:18:24.904419+00
7	Inglés	ING	\N	\N	t	2026-05-29 04:18:24.904419+00
8	Animación a la Lectura	AL	\N	\N	t	2026-05-29 04:18:24.904419+00
9	Proyectos Escolares	PE	\N	\N	t	2026-05-29 04:18:24.904419+00
10	Desarrollo Personal y Social	DPS	\N	\N	t	2026-05-29 04:18:24.904419+00
11	Descubrimiento del Medio Natural y Cultural	DMNC	\N	\N	t	2026-05-29 04:18:24.904419+00
12	Matemáticas	MAT-01	\N	\N	t	2026-06-02 04:03:09.002662+00
13	Orientación Vocacional	OVP	Orientación vocacional y profesional	\N	t	2026-07-27 02:15:58.161376+00
14	Currículo Integrado	CURR	Bloque de materias base dictado por el docente titular en grados bajos	\N	t	2026-07-27 02:15:58.161376+00
15	Acompañamiento Integral	ACOM	Hora de acompañamiento	\N	t	2026-07-27 02:15:58.161376+00
\.


--
-- Data for Name: asignaturas_por_nivel; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.asignaturas_por_nivel (id_asignatura, id_nivel, tipo_escala) FROM stdin;
\.


--
-- Data for Name: auditoria; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.auditoria (id_auditoria, schema_origen, id_usuario, username, accion, tabla_afectada, registro_id, descripcion, ip_address, user_agent, hmac, fecha) FROM stdin;
\.


--
-- Data for Name: documentos_matricula; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.documentos_matricula (id_documento, id_matricula, tipo_documento, nombre_archivo, ruta_archivo, fecha_subida, subido_por) FROM stdin;
\.


--
-- Data for Name: escala_calificaciones; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.escala_calificaciones (id_escala, id_ano_lectivo, id_nivel, nota_minima, nota_maxima, equivalente_cualitativo, descripcion) FROM stdin;
1	1	1	9.50	10.00	A+	Domina los aprendizajes requeridos
2	1	2	9.50	10.00	A+	Domina los aprendizajes requeridos
3	1	3	9.50	10.00	A+	Domina los aprendizajes requeridos
4	1	4	9.50	10.00	A+	Domina los aprendizajes requeridos
5	1	5	9.50	10.00	A+	Domina los aprendizajes requeridos
6	1	1	8.50	9.49	A-	Domina los aprendizajes requeridos
7	1	2	8.50	9.49	A-	Domina los aprendizajes requeridos
8	1	3	8.50	9.49	A-	Domina los aprendizajes requeridos
9	1	4	8.50	9.49	A-	Domina los aprendizajes requeridos
10	1	5	8.50	9.49	A-	Domina los aprendizajes requeridos
11	1	1	7.50	8.49	B+	Alcanza los aprendizajes requeridos
12	1	2	7.50	8.49	B+	Alcanza los aprendizajes requeridos
13	1	3	7.50	8.49	B+	Alcanza los aprendizajes requeridos
14	1	4	7.50	8.49	B+	Alcanza los aprendizajes requeridos
15	1	5	7.50	8.49	B+	Alcanza los aprendizajes requeridos
16	1	1	6.50	7.49	B-	Alcanza los aprendizajes requeridos
17	1	2	6.50	7.49	B-	Alcanza los aprendizajes requeridos
18	1	3	6.50	7.49	B-	Alcanza los aprendizajes requeridos
19	1	4	6.50	7.49	B-	Alcanza los aprendizajes requeridos
20	1	5	6.50	7.49	B-	Alcanza los aprendizajes requeridos
21	1	1	5.50	6.49	C+	Está próximo a alcanzar los aprendizajes
22	1	2	5.50	6.49	C+	Está próximo a alcanzar los aprendizajes
23	1	3	5.50	6.49	C+	Está próximo a alcanzar los aprendizajes
24	1	4	5.50	6.49	C+	Está próximo a alcanzar los aprendizajes
25	1	5	5.50	6.49	C+	Está próximo a alcanzar los aprendizajes
26	1	1	4.50	5.49	C-	Está próximo a alcanzar los aprendizajes
27	1	2	4.50	5.49	C-	Está próximo a alcanzar los aprendizajes
28	1	3	4.50	5.49	C-	Está próximo a alcanzar los aprendizajes
29	1	4	4.50	5.49	C-	Está próximo a alcanzar los aprendizajes
30	1	5	4.50	5.49	C-	Está próximo a alcanzar los aprendizajes
31	1	1	3.50	4.49	D+	No alcanza los aprendizajes requeridos
32	1	2	3.50	4.49	D+	No alcanza los aprendizajes requeridos
33	1	3	3.50	4.49	D+	No alcanza los aprendizajes requeridos
34	1	4	3.50	4.49	D+	No alcanza los aprendizajes requeridos
35	1	5	3.50	4.49	D+	No alcanza los aprendizajes requeridos
36	1	1	2.50	3.49	D-	No alcanza los aprendizajes requeridos
37	1	2	2.50	3.49	D-	No alcanza los aprendizajes requeridos
38	1	3	2.50	3.49	D-	No alcanza los aprendizajes requeridos
39	1	4	2.50	3.49	D-	No alcanza los aprendizajes requeridos
40	1	5	2.50	3.49	D-	No alcanza los aprendizajes requeridos
41	1	1	1.50	2.49	E+	No alcanza los aprendizajes requeridos
42	1	2	1.50	2.49	E+	No alcanza los aprendizajes requeridos
43	1	3	1.50	2.49	E+	No alcanza los aprendizajes requeridos
44	1	4	1.50	2.49	E+	No alcanza los aprendizajes requeridos
45	1	5	1.50	2.49	E+	No alcanza los aprendizajes requeridos
46	1	1	0.00	1.49	E-	No alcanza los aprendizajes requeridos
47	1	2	0.00	1.49	E-	No alcanza los aprendizajes requeridos
48	1	3	0.00	1.49	E-	No alcanza los aprendizajes requeridos
49	1	4	0.00	1.49	E-	No alcanza los aprendizajes requeridos
50	1	5	0.00	1.49	E-	No alcanza los aprendizajes requeridos
\.


--
-- Data for Name: esquema_calificacion; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.esquema_calificacion (id_esquema, id_ano_lectivo, peso_formativa, peso_sumativa) FROM stdin;
1	1	70.00	30.00
\.


--
-- Data for Name: estudiantes; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.estudiantes (id_estudiante, cedula, codigo_estudiante, nombres, apellidos, fecha_nacimiento, genero, direccion, telefono, telefono_alt, correo, discapacidad, tipo_discapacidad, porcentaje_disc, id_representante, origen_listado, estado, foto_url, creado_por, fecha_creacion, fecha_actualizacion, carnet_conadis, nacionalidad, etnia, lugar_nacimiento, vive_con, numeros_hermanos, beneficio_social) FROM stdin;
7	1353464074	\N	JOYMI MILAGROS	AMAGUA PAREDES	\N	\N	\N	\N	\N	ampajomi14810424@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:07.513604+00	2026-07-08 19:28:07.513604+00	\N	Ecuatoriana	\N	\N	\N	\N	f
8	0964892095	\N	YEIMY ISABELLA	CATAGUA PARRAGA	\N	\N	\N	\N	\N	capayeis14833522@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:08.244245+00	2026-07-08 19:28:08.244245+00	\N	Ecuatoriana	\N	\N	\N	\N	f
9	0964533913	\N	JANDER MOISES	CEDEÑO RODRIGUEZ	\N	\N	\N	\N	\N	cerojamo14811752@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:08.953773+00	2026-07-08 19:28:08.953773+00	\N	Ecuatoriana	\N	\N	\N	\N	f
10	1252540669	\N	EMMANUEL ALEJANDRO	CHAVARRIA PINCAY	\N	\N	\N	\N	\N	chpiemal14732931@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:09.835521+00	2026-07-08 19:28:09.835521+00	\N	Ecuatoriana	\N	\N	\N	\N	f
11	0965078967	\N	ALICIA VICTORIA	CHAVEZ MACIAS	\N	\N	\N	\N	\N	chmaalvi14885883@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:10.783193+00	2026-07-08 19:28:10.783193+00	\N	Ecuatoriana	\N	\N	\N	\N	f
12	0964616148	\N	ANDER EMIR	CHILAN SOLORZANO	\N	\N	\N	\N	\N	chsoanem14840300@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:11.41712+00	2026-07-08 19:28:11.41712+00	\N	Ecuatoriana	\N	\N	\N	\N	f
13	1252528946	\N	CARLOS THOMAS	DELGADO ZAMBRANO	\N	\N	\N	\N	\N	dezacath14813120@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:11.993575+00	2026-07-08 19:28:11.993575+00	\N	Ecuatoriana	\N	\N	\N	\N	f
14	0964914279	\N	MARIANA NOHEMY	GARCIA MERO	\N	\N	\N	\N	\N	gavenagu14763212@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:12.462324+00	2026-07-08 19:28:12.462324+00	\N	Ecuatoriana	\N	\N	\N	\N	f
15	1252500267	\N	NARCISA GUADALUPE	GARCIA VELEZ	\N	\N	\N	\N	\N	hocemaar14763310@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:12.927485+00	2026-07-08 19:28:12.927485+00	\N	Ecuatoriana	\N	\N	\N	\N	f
16	0965034499	\N	MARIETZY ARISBETH	HOLGUIN CEDEÑO	\N	\N	\N	\N	\N	ingasnal15702639@estudiantes2.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:14.394462+00	2026-07-08 19:28:14.394462+00	\N	Ecuatoriana	\N	\N	\N	\N	f
17	0751919648	\N	SNAIDER ALEXANDER	INTRIAGO GARCIA	\N	\N	\N	\N	\N	intualya14811668@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:15.946439+00	2026-07-08 19:28:15.946439+00	\N	Ecuatoriana	\N	\N	\N	\N	f
18	0964875538	\N	ALEXA YAMILET	INTRIAGO TUAREZ	\N	\N	\N	\N	\N	lamojosu14732934@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:17.654937+00	2026-07-08 19:28:17.654937+00	\N	Ecuatoriana	\N	\N	\N	\N	f
19	0964544274	\N	JOSEPH SURIEL	LAAZ MONTECE	\N	\N	\N	\N	\N	lojaanma14810677@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:19.07914+00	2026-07-08 19:28:19.07914+00	\N	Ecuatoriana	\N	\N	\N	\N	f
20	0965018583	\N	ANGELICA MARILUZ	LOOR JAIME	\N	\N	\N	\N	\N	lomaarju14856919@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:19.540823+00	2026-07-08 19:28:19.540823+00	\N	Ecuatoriana	\N	\N	\N	\N	f
21	0964505879	\N	ARELYS JULIETH	LOPEZ MARCILLO	\N	\N	\N	\N	\N	lujaedga14811454@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:20.011247+00	2026-07-08 19:28:20.011247+00	\N	Ecuatoriana	\N	\N	\N	\N	f
22	0964510648	\N	EDUAR GABRIEL	LUCAS JAMA	\N	\N	\N	\N	\N	mevalist14728799@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:20.478828+00	2026-07-08 19:28:20.478828+00	\N	Ecuatoriana	\N	\N	\N	\N	f
23	0964893234	\N	LISBETH STEFANIA	MENDOZA VASQUEZ	\N	\N	\N	\N	\N	moalxaem16166351@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:20.94457+00	2026-07-08 19:28:20.94457+00	\N	Ecuatoriana	\N	\N	\N	\N	f
24	0964527907	\N	XAVIER EMIR	MORAN ALVARADO	\N	\N	\N	\N	\N	moansnja14812461@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:21.412638+00	2026-07-08 19:28:21.412638+00	\N	Ecuatoriana	\N	\N	\N	\N	f
25	0964455778	\N	SNAIDER JAVIER	MOREIRA ANDRADE	\N	\N	\N	\N	\N	momoalyu14714961@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:22.044164+00	2026-07-08 19:28:22.044164+00	\N	Ecuatoriana	\N	\N	\N	\N	f
26	0964911242	\N	ALEXA YURHEY	MORETA MORALES	\N	\N	\N	\N	\N	muavgrya16174283@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:23.154628+00	2026-07-08 19:28:23.154628+00	\N	Ecuatoriana	\N	\N	\N	\N	f
27	0964825657	\N	GRAZMELY YARDLEY	MUÑOZ AVILA	\N	\N	\N	\N	\N	oraraxga14847166@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:24.013468+00	2026-07-08 19:28:24.013468+00	\N	Ecuatoriana	\N	\N	\N	\N	f
28	0964525224	\N	AXEL GAEL	ORMAZA ARTEAGA	\N	\N	\N	\N	\N	pavalial14763222@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:25.021877+00	2026-07-08 19:28:25.021877+00	\N	Ecuatoriana	\N	\N	\N	\N	f
29	0964491062	\N	LIZ ALEXA	PARRAGA VALENZUELA	\N	\N	\N	\N	\N	pelakada14813329@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:25.834893+00	2026-07-08 19:28:25.834893+00	\N	Ecuatoriana	\N	\N	\N	\N	f
30	0964934731	\N	KATIHUSKA DANAE	PEÑAFIEL LAJE	\N	\N	\N	\N	\N	piloeiad14713526@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:26.652894+00	2026-07-08 19:28:26.652894+00	\N	Ecuatoriana	\N	\N	\N	\N	f
31	0964586903	\N	EINER ADRIEL	PINARGOTE LOZANO	\N	\N	\N	\N	\N	recamada16111208@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:28.137071+00	2026-07-08 19:28:28.137071+00	\N	Ecuatoriana	\N	\N	\N	\N	f
32	1252516958	\N	MARCOS DAVID	REYES CARDENAS	\N	\N	\N	\N	\N	ricasaju14730615@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:29.695642+00	2026-07-08 19:28:29.695642+00	\N	Ecuatoriana	\N	\N	\N	\N	f
33	0964540686	\N	SAMARA JULIETTE	RISCO CARREÑO	\N	\N	\N	\N	\N	romadeez14812311@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:31.416787+00	2026-07-08 19:28:31.416787+00	\N	Ecuatoriana	\N	\N	\N	\N	f
34	1353484775	\N	DERECK EZEQUIELL	ROSADO MACIAS	\N	\N	\N	\N	\N	sabrkiai16162971@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:33.042731+00	2026-07-08 19:28:33.042731+00	\N	Ecuatoriana	\N	\N	\N	\N	f
35	1353564055	\N	KIMBERLY AILYN	SALDAÑA BRAVO	\N	\N	\N	\N	\N	sachwajo14812066@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:33.515518+00	2026-07-08 19:28:33.515518+00	\N	Ecuatoriana	\N	\N	\N	\N	f
36	0964451033	\N	WALTER JOHAN	SALTOS CHILAN	\N	\N	\N	\N	\N	sagamami14811172@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:34.313467+00	2026-07-08 19:28:34.313467+00	\N	Ecuatoriana	\N	\N	\N	\N	f
37	0965195092	\N	MARIA MILAGROS	SANCHEZ GARCIA	\N	\N	\N	\N	\N	sapithma16165957@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:35.235752+00	2026-07-08 19:28:35.235752+00	\N	Ecuatoriana	\N	\N	\N	\N	f
38	0964984371	\N	THIAGO MATEO	SANCHEZ PINARGOTE	\N	\N	\N	\N	\N	varedajo16165467@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:35.912966+00	2026-07-08 19:28:35.912966+00	\N	Ecuatoriana	\N	\N	\N	\N	f
39	0964622138	\N	DARIXON JOSUE	VALENCIA REYES	\N	\N	\N	\N	\N	zacemaza14814255@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:36.608714+00	2026-07-08 19:28:36.608714+00	\N	Ecuatoriana	\N	\N	\N	\N	f
40	0964958789	\N	MATEO ZABDIEL	ZAMBRANO CEDEÑO	\N	\N	\N	\N	\N	zapadoad14801398@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:37.476156+00	2026-07-08 19:28:37.476156+00	\N	Ecuatoriana	\N	\N	\N	\N	f
41	0964961890	\N	DORIAN ADRIAN	ZAMBRANO PARRAGA	\N	\N	\N	\N	\N	zadeaxez14813578@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:38.999427+00	2026-07-08 19:28:38.999427+00	\N	Ecuatoriana	\N	\N	\N	\N	f
42	0965130974	\N	AXEL EZEQUIEL	ZAMORA DELGADO	\N	\N	\N	\N	\N		f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:40.548938+00	2026-07-08 19:28:40.548938+00	\N	Ecuatoriana	\N	\N	\N	\N	f
6	1353490590	\N	DAVID SANTIAGO	ALCIVAR INTRIAGO	2002-05-08	M	av quevedo - las tecas	0983621086	\N	alindasa14810863@estudiantes3.edu.ec	f		\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:06.986931+00	2026-07-08 19:31:40.314389+00		Ecuatoriana	Mestizo/a	El empalme	Solo Madre	0	t
43	0963708177	\N	ANGELA MARIA	CARRASCO CATAGUA	\N	\N	\N	\N	\N	cacaanma14051224@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:35.485223+00	2026-07-08 19:44:35.485223+00	\N	Ecuatoriana	\N	\N	\N	\N	f
44	0964049381	\N	LIAM JOSE	CARREÑO CRUZATTY	\N	\N	\N	\N	\N	cacrlijo14046724@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:35.899203+00	2026-07-08 19:44:35.899203+00	\N	Ecuatoriana	\N	\N	\N	\N	f
45	1353286261	\N	JOSHUA DAYAN	CATAGUA MOREIRA	\N	\N	\N	\N	\N	camojoda13950290@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:36.784729+00	2026-07-08 19:44:36.784729+00	\N	Ecuatoriana	\N	\N	\N	\N	f
46	0964200190	\N	ULBIO JUNIOR	CONFORME GANCHOZO	\N	\N	\N	\N	\N	cogaulju14043634@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:37.890604+00	2026-07-08 19:44:37.890604+00	\N	Ecuatoriana	\N	\N	\N	\N	f
47	0963913470	\N	ERICKA ZHARICK	CRUZATTI SANCHEZ	\N	\N	\N	\N	\N	crsaerzh16176913@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:38.729942+00	2026-07-08 19:44:38.729942+00	\N	Ecuatoriana	\N	\N	\N	\N	f
48	0963848882	\N	JESSICA SAMHARA	DELVALLE VERA	\N	\N	\N	\N	\N	devejesa14044754@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:39.528351+00	2026-07-08 19:44:39.528351+00	\N	Ecuatoriana	\N	\N	\N	\N	f
49	1353360009	\N	MAYEXY ESPERANZA	ESPINALES MENDOZA	\N	\N	\N	\N	\N	esmemaes13930738@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:40.47035+00	2026-07-08 19:44:40.47035+00	\N	Ecuatoriana	\N	\N	\N	\N	f
50	0964145767	\N	ANGELO NARCISO	ESPINALES RODRIGUEZ	\N	\N	\N	\N	\N	esroanna14108938@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:41.391459+00	2026-07-08 19:44:41.391459+00	\N	Ecuatoriana	\N	\N	\N	\N	f
51	0963913520	\N	EDUARDO JOEL	GARCIA MERO	\N	\N	\N	\N	\N	gameedjo15474303@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:42.73723+00	2026-07-08 19:44:42.73723+00	\N	Ecuatoriana	\N	\N	\N	\N	f
52	0963729678	\N	JULITZA SCARLETH	GARCIA RODRIGUEZ	\N	\N	\N	\N	\N	garojusc15475604@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:44.259781+00	2026-07-08 19:44:44.259781+00	\N	Ecuatoriana	\N	\N	\N	\N	f
53	1252409808	\N	JULIETH KATHERINE	GARCIA SALTOS	\N	\N	\N	\N	\N	gasajuka14038171@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:46.05632+00	2026-07-08 19:44:46.05632+00	\N	Ecuatoriana	\N	\N	\N	\N	f
54	0963695507	\N	ANGELICA MARIED	HOLGUIN CEDEÑO	\N	\N	\N	\N	\N	hoceanma13950326@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:47.710663+00	2026-07-08 19:44:47.710663+00	\N	Ecuatoriana	\N	\N	\N	\N	f
55	0964236608	\N	ANGEL SEBASTIAN	JAMA MOREIRA	\N	\N	\N	\N	\N	jamoanse14442688@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:48.082146+00	2026-07-08 19:44:48.082146+00	\N	Ecuatoriana	\N	\N	\N	\N	f
56	0963852033	\N	ANDRY JOAN	LUCAS SANTANA	\N	\N	\N	\N	\N	lusaanjo14070020@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:48.459643+00	2026-07-08 19:44:48.459643+00	\N	Ecuatoriana	\N	\N	\N	\N	f
57	0963964804	\N	CRISTOPHER JAVIER	MENDOZA MARCILLO	\N	\N	\N	\N	\N	memacrja14138959@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:48.8345+00	2026-07-08 19:44:48.8345+00	\N	Ecuatoriana	\N	\N	\N	\N	f
58	1353434994	\N	MARYS ALEJANDRA	MORALES RODRIGUEZ	\N	\N	\N	\N	\N	moromaal14728114@estudiantes2.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:49.207058+00	2026-07-08 19:44:49.207058+00	\N	Ecuatoriana	\N	\N	\N	\N	f
59	1353396870	\N	JOSUA AGUSTIN	MOREIRA CATAGUA	\N	\N	\N	\N	\N	mocajoag14442361@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:49.571433+00	2026-07-08 19:44:49.571433+00	\N	Ecuatoriana	\N	\N	\N	\N	f
60	0964034888	\N	MARIA VALENTINA	MOSQUERA RODRIGUEZ	\N	\N	\N	\N	\N	moromava14814633@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:49.934797+00	2026-07-08 19:44:49.934797+00	\N	Ecuatoriana	\N	\N	\N	\N	f
61	0963977046	\N	ELIANYS MIRELYS	MUÑOZ VASQUEZ	\N	\N	\N	\N	\N	muvaelmi13929890@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:50.786455+00	2026-07-08 19:44:50.786455+00	\N	Ecuatoriana	\N	\N	\N	\N	f
62	0964060842	\N	ROMINA ISABELLA	ORMAZA MANTUANO	\N	\N	\N	\N	\N	ormarois14068337@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:51.837992+00	2026-07-08 19:44:51.837992+00	\N	Ecuatoriana	\N	\N	\N	\N	f
63	1252316474	\N	KARLEY ELIZABETH	PALACIOS OLMEDO	\N	\N	\N	\N	\N	paolkael14056304@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:52.444701+00	2026-07-08 19:44:52.444701+00	\N	Ecuatoriana	\N	\N	\N	\N	f
64	0964263909	\N	GUADALUPE RAQUEL	QUIROZ SANCHEZ	\N	\N	\N	\N	\N	qusagura14885033@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:53.738655+00	2026-07-08 19:44:53.738655+00	\N	Ecuatoriana	\N	\N	\N	\N	f
65	1252197254	\N	EILEEN ANGELINA	REYES CARDENAS	\N	\N	\N	\N	\N	recaeian15477210@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:55.669711+00	2026-07-08 19:44:55.669711+00	\N	Ecuatoriana	\N	\N	\N	\N	f
66	1353431313	\N	JEREMY SEBASTIAN	RIVAS INTRIAGO	\N	\N	\N	\N	\N	riinjese15698068@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:57.337411+00	2026-07-08 19:44:57.337411+00	\N	Ecuatoriana	\N	\N	\N	\N	f
67	0964253751	\N	ANTHONY RUBEN	RODRIGUEZ LUCAS	\N	\N	\N	\N	\N	roluanru14882055@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:58.746736+00	2026-07-08 19:44:58.746736+00	\N	Ecuatoriana	\N	\N	\N	\N	f
68	0963898002	\N	ALICE VICTORIA	RODRIGUEZ POSLIGUA	\N	\N	\N	\N	\N	ropoalvi15427591@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:59.112173+00	2026-07-08 19:44:59.112173+00	\N	Ecuatoriana	\N	\N	\N	\N	f
69	1353283334	\N	FERNANDO JHOEL	RODRIGUEZ RODRIGUEZ	\N	\N	\N	\N	\N	rorofejh15046634@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:59.476239+00	2026-07-08 19:44:59.476239+00	\N	Ecuatoriana	\N	\N	\N	\N	f
70	0963485479	\N	ERICK GAEL	ROSADO HOLGUIN	\N	\N	\N	\N	\N	rohoerga14913296@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:59.843181+00	2026-07-08 19:44:59.843181+00	\N	Ecuatoriana	\N	\N	\N	\N	f
71	0963955851	\N	MELANY AYLIN	SACON SUAREZ	\N	\N	\N	\N	\N	sasumeay13950256@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:00.275065+00	2026-07-08 19:45:00.275065+00	\N	Ecuatoriana	\N	\N	\N	\N	f
72	1353424631	\N	AMAIA HAILY	SOLORZANO DELGADO	\N	\N	\N	\N	\N	sodeamha14442501@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:01.279852+00	2026-07-08 19:45:01.279852+00	\N	Ecuatoriana	\N	\N	\N	\N	f
73	0963939582	\N	LIAN ALEJANDRO	SOLORZANO GARCIA	\N	\N	\N	\N	\N	sogalial14037402@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:02.078064+00	2026-07-08 19:45:02.078064+00	\N	Ecuatoriana	\N	\N	\N	\N	f
74	0964207435	\N	LUCAS JHULIAN	TAPIA MENDOZA	\N	\N	\N	\N	\N	tamelujh14073932@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:02.760296+00	2026-07-08 19:45:02.760296+00	\N	Ecuatoriana	\N	\N	\N	\N	f
75	0964447999	\N	ARIANA MAILEN	TORRES HOLGUIN	\N	\N	\N	\N	\N	tohoarma14445623@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:03.82214+00	2026-07-08 19:45:03.82214+00	\N	Ecuatoriana	\N	\N	\N	\N	f
76	0964214597	\N	JEFFERSON ALEXANDER	VASQUEZ RISCO	\N	\N	\N	\N	\N	varijeal13930895@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:04.732534+00	2026-07-08 19:45:04.732534+00	\N	Ecuatoriana	\N	\N	\N	\N	f
77	0964139695	\N	DYLAN JESUS	VELASQUEZ CASTRO	\N	\N	\N	\N	\N	vecadyje14884961@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:05.562063+00	2026-07-08 19:45:05.562063+00	\N	Ecuatoriana	\N	\N	\N	\N	f
78	0964436323	\N	OHANA MONSERRATE	VELEZ MENDOZA	\N	\N	\N	\N	\N	venamavi14442452@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:06.35289+00	2026-07-08 19:45:06.35289+00	\N	Ecuatoriana	\N	\N	\N	\N	f
79	0964251946	\N	MARIA VICTORIA	VELEZ NAVARRETE	\N	\N	\N	\N	\N	vevemaja13938981@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:07.73397+00	2026-07-08 19:45:07.73397+00	\N	Ecuatoriana	\N	\N	\N	\N	f
80	0963988563	\N	MATHIUS JACOP	VERA VERA	\N	\N	\N	\N	\N	zamalima13964790@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:09.267843+00	2026-07-08 19:45:09.267843+00	\N	Ecuatoriana	\N	\N	\N	\N	f
81	0964212567	\N	LIAH MAYTE	ZAMORA MACIAS	\N	\N	\N	\N	\N		f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:11.066766+00	2026-07-08 19:45:11.066766+00	\N	Ecuatoriana	\N	\N	\N	\N	f
1	1654181385	\N	Ana María	González Reyes	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	ACTIVO	\N	1	2026-06-02 04:03:28.015797+00	2026-06-02 04:03:28.015797+00	\N	\N	\N	\N	\N	\N	f
82	0103321378	PRB-3-1	Mateo	Vera Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
83	0545190704	PRB-3-2	Valentina	Intriago Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
84	0504884560	PRB-3-3	Santiago	García Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
85	1341536413	PRB-3-4	Camila	Macías Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
86	1720392214	PRB-3-5	Sebastián	Delgado García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
87	1204040768	PRB-3-6	Isabella	Chávez Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
88	1211472772	PRB-3-7	Nicolás	Bravo Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
89	1835437250	PRB-3-8	Emma	Pincay Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
90	0948823406	PRB-3-9	Benjamín	Solórzano Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
91	1426436992	PRB-3-10	Sofía	Parrales Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
92	0447537820	PRB-3-11	Martín	Andrade Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
93	0448549469	PRB-3-12	Luciana	Moreira Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
94	1508160353	PRB-3-13	Emiliano	Rodríguez Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
95	0324681782	PRB-3-14	Renata	Alcívar Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
96	1510345604	PRB-3-15	Thiago	Cabrera Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
97	0424766368	PRB-3-16	Antonella	Ponce Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
98	2441363120	PRB-3-17	Dylan	Zambrano Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
99	0501898985	PRB-3-18	Mía	Mendoza Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
100	1246156358	PRB-3-19	Gael	Cedeño Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
101	2429217215	PRB-3-20	Julieta	Loor Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
102	1001313079	PRB-4-1	Mateo	Intriago Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
103	1357233228	PRB-4-2	Valentina	García Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
104	0629497306	PRB-4-3	Santiago	Macías Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
105	1724037799	PRB-4-4	Camila	Delgado Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
106	0719931602	PRB-4-5	Sebastián	Chávez García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
107	1347820209	PRB-4-6	Isabella	Bravo Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
108	1442845283	PRB-4-7	Nicolás	Pincay Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
109	0430727255	PRB-4-8	Emma	Solórzano Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
110	1223296698	PRB-4-9	Benjamín	Parrales Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
111	0816356265	PRB-4-10	Sofía	Andrade Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
112	1055089286	PRB-4-11	Martín	Moreira Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
113	0116174434	PRB-4-12	Luciana	Rodríguez Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
114	0159460385	PRB-4-13	Emiliano	Alcívar Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
115	1243039987	PRB-4-14	Renata	Cabrera Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
116	1051887360	PRB-4-15	Thiago	Ponce Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
117	2259771919	PRB-4-16	Antonella	Zambrano Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
118	1512751379	PRB-4-17	Dylan	Mendoza Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
119	0256086737	PRB-4-18	Mía	Cedeño Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
120	0459690632	PRB-4-19	Gael	Loor Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
121	1044356127	PRB-4-20	Julieta	Vera Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
122	0519192785	PRB-5-1	Mateo	García Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
123	2252270794	PRB-5-2	Valentina	Macías Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
124	1034950871	PRB-5-3	Santiago	Delgado Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
125	0806665808	PRB-5-4	Camila	Chávez García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
126	2042276242	PRB-5-5	Sebastián	Bravo Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
127	0757409081	PRB-5-6	Isabella	Pincay Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
128	2216310470	PRB-5-7	Nicolás	Solórzano Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
129	0803949965	PRB-5-8	Emma	Parrales Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
130	0619500184	PRB-5-9	Benjamín	Andrade Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
131	0835259896	PRB-5-10	Sofía	Moreira Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
132	2138647959	PRB-5-11	Martín	Rodríguez Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
133	1156072207	PRB-5-12	Luciana	Alcívar Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
134	2130071083	PRB-5-13	Emiliano	Cabrera Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
135	1557568928	PRB-5-14	Renata	Ponce Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
136	0927783878	PRB-5-15	Thiago	Zambrano Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
137	1041524651	PRB-5-16	Antonella	Mendoza Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
138	1206914192	PRB-5-17	Dylan	Cedeño Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
139	1003756853	PRB-5-18	Mía	Loor Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
140	1023438441	PRB-5-19	Gael	Vera Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
141	2027362025	PRB-5-20	Julieta	Intriago Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
142	1824130478	PRB-6-1	Mateo	Macías Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
143	2401584731	PRB-6-2	Valentina	Delgado Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
144	0327485223	PRB-6-3	Santiago	Chávez Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
145	1331640985	PRB-6-4	Camila	Bravo García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
146	0753708536	PRB-6-5	Sebastián	Pincay Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
147	0425227790	PRB-6-6	Isabella	Solórzano Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
148	1438514182	PRB-6-7	Nicolás	Parrales Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
149	2450358920	PRB-6-8	Emma	Andrade Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
150	0213141328	PRB-6-9	Benjamín	Moreira Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
151	1255420638	PRB-6-10	Sofía	Rodríguez Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
152	2405071156	PRB-6-11	Martín	Alcívar Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
153	0239849607	PRB-6-12	Luciana	Cabrera Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
154	1525041644	PRB-6-13	Emiliano	Ponce Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
155	1657586606	PRB-6-14	Renata	Zambrano Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
156	0320897184	PRB-6-15	Thiago	Mendoza Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
157	0506556737	PRB-6-16	Antonella	Cedeño Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
158	1459375166	PRB-6-17	Dylan	Loor Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
159	1704230315	PRB-6-18	Mía	Vera Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
160	1657359483	PRB-6-19	Gael	Intriago Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
161	1607595152	PRB-6-20	Julieta	García Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
162	1749203699	PRB-7-1	Mateo	Delgado Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
163	2027906995	PRB-7-2	Valentina	Chávez Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
164	2326217979	PRB-7-3	Santiago	Bravo García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
165	1654997863	PRB-7-4	Camila	Pincay Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
166	2149959773	PRB-7-5	Sebastián	Solórzano Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
167	1416144291	PRB-7-6	Isabella	Parrales Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
168	2148749266	PRB-7-7	Nicolás	Andrade Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
169	0104422688	PRB-7-8	Emma	Moreira Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
170	1758967903	PRB-7-9	Benjamín	Rodríguez Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
171	1011621289	PRB-7-10	Sofía	Alcívar Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
172	0520029778	PRB-7-11	Martín	Cabrera Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
173	1056102500	PRB-7-12	Luciana	Ponce Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
174	2258229422	PRB-7-13	Emiliano	Zambrano Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
175	1946746318	PRB-7-14	Renata	Mendoza Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
176	1642042749	PRB-7-15	Thiago	Cedeño Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
177	0809798630	PRB-7-16	Antonella	Loor Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
178	1107385039	PRB-7-17	Dylan	Vera Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
179	1836227486	PRB-7-18	Mía	Intriago Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
180	0622867661	PRB-7-19	Gael	García Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
181	0733634901	PRB-7-20	Julieta	Macías Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
182	2133128815	PRB-8-1	Mateo	Chávez Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
183	2124487980	PRB-8-2	Valentina	Bravo Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
184	1151593546	PRB-8-3	Santiago	Pincay García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
185	2301417669	PRB-8-4	Camila	Solórzano Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
186	2435168345	PRB-8-5	Sebastián	Parrales Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
187	0758630792	PRB-8-6	Isabella	Andrade Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
188	0518336896	PRB-8-7	Nicolás	Moreira Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
189	0201396983	PRB-8-8	Emma	Rodríguez Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
190	0850437518	PRB-8-9	Benjamín	Alcívar Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
191	2126558101	PRB-8-10	Sofía	Cabrera Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
192	0541793881	PRB-8-11	Martín	Ponce Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
193	1425663661	PRB-8-12	Luciana	Zambrano Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
194	1103505010	PRB-8-13	Emiliano	Mendoza Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
195	1155094723	PRB-8-14	Renata	Cedeño Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
196	1319249114	PRB-8-15	Thiago	Loor Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
197	2253354191	PRB-8-16	Antonella	Vera Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
198	1331348498	PRB-8-17	Dylan	Intriago Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
199	1649159173	PRB-8-18	Mía	García Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
200	1231394774	PRB-8-19	Gael	Macías Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
201	0435185822	PRB-8-20	Julieta	Delgado Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
202	1618127383	PRB-9-1	Mateo	Bravo Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
203	0748124112	PRB-9-2	Valentina	Pincay García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
204	1830199004	PRB-9-3	Santiago	Solórzano Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
205	1226977633	PRB-9-4	Camila	Parrales Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
206	1415277480	PRB-9-5	Sebastián	Andrade Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
207	1312363151	PRB-9-6	Isabella	Moreira Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
208	2305314086	PRB-9-7	Nicolás	Rodríguez Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
209	0204633291	PRB-9-8	Emma	Alcívar Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
210	0147317978	PRB-9-9	Benjamín	Cabrera Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
211	1027586146	PRB-9-10	Sofía	Ponce Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
212	0537751547	PRB-9-11	Martín	Zambrano Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
213	0321479834	PRB-9-12	Luciana	Mendoza Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
214	0137270930	PRB-9-13	Emiliano	Cedeño Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
215	1928607702	PRB-9-14	Renata	Loor Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
216	1108659507	PRB-9-15	Thiago	Vera Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
217	0644359465	PRB-9-16	Antonella	Intriago Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
218	2439519139	PRB-9-17	Dylan	García Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
219	0109744771	PRB-9-18	Mía	Macías Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
220	0931196885	PRB-9-19	Gael	Delgado Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
221	0441074838	PRB-9-20	Julieta	Chávez Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
222	2208089512	PRB-10-1	Mateo	Pincay Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
223	1517180889	PRB-10-2	Valentina	Solórzano García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
224	0256271065	PRB-10-3	Santiago	Parrales Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
225	0528694904	PRB-10-4	Camila	Andrade Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
226	0955390307	PRB-10-5	Sebastián	Moreira Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
227	0420106148	PRB-10-6	Isabella	Rodríguez Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
228	0552071086	PRB-10-7	Nicolás	Alcívar Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
229	2053150864	PRB-10-8	Emma	Cabrera Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
230	1305288456	PRB-10-9	Benjamín	Ponce Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
231	0237173851	PRB-10-10	Sofía	Zambrano Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
232	1312152513	PRB-10-11	Martín	Mendoza Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
233	0628900318	PRB-10-12	Luciana	Cedeño Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
234	0414005488	PRB-10-13	Emiliano	Loor Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
235	1247092735	PRB-10-14	Renata	Vera Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
236	1227164249	PRB-10-15	Thiago	Intriago Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
237	1647795325	PRB-10-16	Antonella	García Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
238	1453821306	PRB-10-17	Dylan	Macías Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
239	0140157967	PRB-10-18	Mía	Delgado Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
240	2212376780	PRB-10-19	Gael	Chávez Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
241	0911342681	PRB-10-20	Julieta	Bravo Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
242	1159121365	PRB-11-1	Mateo	Solórzano García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
243	1233879962	PRB-11-2	Valentina	Parrales Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
244	0212257315	PRB-11-3	Santiago	Andrade Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
245	1208157220	PRB-11-4	Camila	Moreira Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
246	1530800463	PRB-11-5	Sebastián	Rodríguez Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
247	1908343575	PRB-11-6	Isabella	Alcívar Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
248	1535872715	PRB-11-7	Nicolás	Cabrera Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
249	1112397771	PRB-11-8	Emma	Ponce Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
250	1700459710	PRB-11-9	Benjamín	Zambrano Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
251	1403941311	PRB-11-10	Sofía	Mendoza Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
252	0348750647	PRB-11-11	Martín	Cedeño Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
253	0251952297	PRB-11-12	Luciana	Loor Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
254	1508279310	PRB-11-13	Emiliano	Vera Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
255	1742431073	PRB-11-14	Renata	Intriago Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
256	1037510896	PRB-11-15	Thiago	García Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
257	0712180066	PRB-11-16	Antonella	Macías Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
258	0439196635	PRB-11-17	Dylan	Delgado Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
259	1607772967	PRB-11-18	Mía	Chávez Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
260	1426427801	PRB-11-19	Gael	Bravo Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
261	1215935436	PRB-11-20	Julieta	Pincay Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
262	2102734528	PRB-12-1	Mateo	Parrales García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
263	0709288740	PRB-12-2	Valentina	Andrade Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
264	0405084435	PRB-12-3	Santiago	Moreira Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
265	0626654313	PRB-12-4	Camila	Rodríguez Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
266	1940236936	PRB-12-5	Sebastián	Alcívar Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
267	0206129637	PRB-12-6	Isabella	Cabrera Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
268	2419454885	PRB-12-7	Nicolás	Ponce Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
269	2247829225	PRB-12-8	Emma	Zambrano Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
270	0629099789	PRB-12-9	Benjamín	Mendoza Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
271	0608891040	PRB-12-10	Sofía	Cedeño Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
272	0146200654	PRB-12-11	Martín	Loor Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
273	0721442556	PRB-12-12	Luciana	Vera Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
274	0505583369	PRB-12-13	Emiliano	Intriago Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
275	2309021752	PRB-12-14	Renata	García Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
276	1600064313	PRB-12-15	Thiago	Macías Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
277	1718794421	PRB-12-16	Antonella	Delgado Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
278	1524674171	PRB-12-17	Dylan	Chávez Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
279	1657601058	PRB-12-18	Mía	Bravo Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
280	2000606026	PRB-12-19	Gael	Pincay Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
281	0548965185	PRB-12-20	Julieta	Solórzano Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
282	0749797593	PRB-13-1	Mateo	Andrade Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
283	0411485089	PRB-13-2	Valentina	Moreira Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
284	2449486535	PRB-13-3	Santiago	Rodríguez Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
285	2015843770	PRB-13-4	Camila	Alcívar Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
286	0637480955	PRB-13-5	Sebastián	Cabrera Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
287	1502162652	PRB-13-6	Isabella	Ponce Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
288	2404533750	PRB-13-7	Nicolás	Zambrano Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
289	0632110045	PRB-13-8	Emma	Mendoza Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
290	1136697511	PRB-13-9	Benjamín	Cedeño Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
291	1324686912	PRB-13-10	Sofía	Loor Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
292	1743118323	PRB-13-11	Martín	Vera Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
293	0501123384	PRB-13-12	Luciana	Intriago Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
294	2054834508	PRB-13-13	Emiliano	García Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
295	0937751634	PRB-13-14	Renata	Macías Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
296	1102014824	PRB-13-15	Thiago	Delgado Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
297	1452223637	PRB-13-16	Antonella	Chávez Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
298	0428937825	PRB-13-17	Dylan	Bravo Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
299	0443203740	PRB-13-18	Mía	Pincay Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
300	1521841971	PRB-13-19	Gael	Solórzano Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
301	1853204202	PRB-13-20	Julieta	Parrales García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
302	0254740889	PRB-14-1	Mateo	Moreira Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
303	0913844890	PRB-14-2	Valentina	Rodríguez Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
304	1021413222	PRB-14-3	Santiago	Alcívar Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
305	0138476544	PRB-14-4	Camila	Cabrera Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
306	0311403067	PRB-14-5	Sebastián	Ponce Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
307	1908791401	PRB-14-6	Isabella	Zambrano Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
308	2000273447	PRB-14-7	Nicolás	Mendoza Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
309	0128042074	PRB-14-8	Emma	Cedeño Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
310	0444916837	PRB-14-9	Benjamín	Loor Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
311	2205044353	PRB-14-10	Sofía	Vera Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
312	0903629277	PRB-14-11	Martín	Intriago Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
313	1843969898	PRB-14-12	Luciana	García Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
314	1332849122	PRB-14-13	Emiliano	Macías Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
315	2310470717	PRB-14-14	Renata	Delgado Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
316	1827894278	PRB-14-15	Thiago	Chávez Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
317	1809134875	PRB-14-16	Antonella	Bravo Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
318	1225350790	PRB-14-17	Dylan	Pincay Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
319	2220251793	PRB-14-18	Mía	Solórzano Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
320	0859973067	PRB-14-19	Gael	Parrales Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
321	1122815317	PRB-14-20	Julieta	Andrade García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
322	0126205525	PRB-15-1	Mateo	Rodríguez Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
323	1753688082	PRB-15-2	Valentina	Alcívar Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
324	1757602980	PRB-15-3	Santiago	Cabrera Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
325	0905596383	PRB-15-4	Camila	Ponce Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
326	0123670333	PRB-15-5	Sebastián	Zambrano Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
327	0238449508	PRB-15-6	Isabella	Mendoza Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
328	1206393876	PRB-15-7	Nicolás	Cedeño Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
329	1619281254	PRB-15-8	Emma	Loor Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
330	0925803298	PRB-15-9	Benjamín	Vera Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
331	0918215500	PRB-15-10	Sofía	Intriago Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
332	0328948203	PRB-15-11	Martín	García Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
333	0451067912	PRB-15-12	Luciana	Macías Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
334	1810066140	PRB-15-13	Emiliano	Delgado Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
335	0334102118	PRB-15-14	Renata	Chávez Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
336	2415914098	PRB-15-15	Thiago	Bravo Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
337	0621246891	PRB-15-16	Antonella	Pincay Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
338	2239198308	PRB-15-17	Dylan	Solórzano Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
339	1251837090	PRB-15-18	Mía	Parrales Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
340	1329498222	PRB-15-19	Gael	Andrade García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
341	1525921712	PRB-15-20	Julieta	Moreira Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
342	1837106572	PRB-16-1	Mateo	Alcívar Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
343	0945236545	PRB-16-2	Valentina	Cabrera Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
344	1527087041	PRB-16-3	Santiago	Ponce Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
345	1816722662	PRB-16-4	Camila	Zambrano Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
346	0706514817	PRB-16-5	Sebastián	Mendoza Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
347	0250166287	PRB-16-6	Isabella	Cedeño Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
348	1407239878	PRB-16-7	Nicolás	Loor Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
349	1606309027	PRB-16-8	Emma	Vera Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
350	0631232402	PRB-16-9	Benjamín	Intriago Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
351	1422492932	PRB-16-10	Sofía	García Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
352	1152743256	PRB-16-11	Martín	Macías Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
353	0959133075	PRB-16-12	Luciana	Delgado Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
354	0902480128	PRB-16-13	Emiliano	Chávez Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
355	0206478794	PRB-16-14	Renata	Bravo Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
356	0552229411	PRB-16-15	Thiago	Pincay Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
357	1223987551	PRB-16-16	Antonella	Solórzano Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
358	2342211170	PRB-16-17	Dylan	Parrales Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
359	2229312646	PRB-16-18	Mía	Andrade Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
360	1203251358	PRB-16-19	Gael	Moreira García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
361	1425296322	PRB-16-20	Julieta	Rodríguez Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
362	0924467970	PRB-27-1	Mateo	Delgado Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
363	0230720419	PRB-27-2	Valentina	Chávez Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
364	0100107119	PRB-27-3	Santiago	Bravo Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
365	1530924362	PRB-27-4	Camila	Pincay Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
366	1531252870	PRB-27-5	Sebastián	Solórzano Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
367	0208241182	PRB-27-6	Isabella	Parrales Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
368	1601679622	PRB-27-7	Nicolás	Andrade Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
369	1428542839	PRB-27-8	Emma	Moreira Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
370	0925087322	PRB-27-9	Benjamín	Rodríguez Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
371	2146888934	PRB-27-10	Sofía	Alcívar Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
372	1942068238	PRB-27-11	Martín	Cabrera Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
373	0842704512	PRB-27-12	Luciana	Ponce Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
374	1817807330	PRB-27-13	Emiliano	Zambrano Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
375	2446031326	PRB-27-14	Renata	Mendoza Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
376	0454604463	PRB-27-15	Thiago	Cedeño Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
377	0539523936	PRB-27-16	Antonella	Loor Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
378	1647332251	PRB-27-17	Dylan	Vera Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
379	0128189743	PRB-27-18	Mía	Intriago Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
380	1250052113	PRB-27-19	Gael	García García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
381	1209365814	PRB-27-20	Julieta	Macías Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
382	0815196225	PRB-17-1	Mateo	Cabrera Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
383	1030111338	PRB-17-2	Valentina	Ponce Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
384	0334693561	PRB-17-3	Santiago	Zambrano Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
385	0304387152	PRB-17-4	Camila	Mendoza Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
386	1710768787	PRB-17-5	Sebastián	Cedeño Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
387	0412803793	PRB-17-6	Isabella	Loor Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
388	0111826848	PRB-17-7	Nicolás	Vera Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
389	0838698462	PRB-17-8	Emma	Intriago Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
390	1221581190	PRB-17-9	Benjamín	García Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
391	0609695275	PRB-17-10	Sofía	Macías Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
392	1755166061	PRB-17-11	Martín	Delgado Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
393	1256875087	PRB-17-12	Luciana	Chávez Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
394	0858088156	PRB-17-13	Emiliano	Bravo Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
395	1332591310	PRB-17-14	Renata	Pincay Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
396	1145339881	PRB-17-15	Thiago	Solórzano Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
397	0718766280	PRB-17-16	Antonella	Parrales Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
398	0243109568	PRB-17-17	Dylan	Andrade Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
399	2157171246	PRB-17-18	Mía	Moreira García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
400	1412536029	PRB-17-19	Gael	Rodríguez Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
401	0540451549	PRB-17-20	Julieta	Alcívar Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
402	1745972008	PRB-18-1	Mateo	Ponce Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
403	0845882216	PRB-18-2	Valentina	Zambrano Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
404	2004531881	PRB-18-3	Santiago	Mendoza Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
405	2339219004	PRB-18-4	Camila	Cedeño Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
406	0925728800	PRB-18-5	Sebastián	Loor Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
407	1744139567	PRB-18-6	Isabella	Vera Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
408	1146858012	PRB-18-7	Nicolás	Intriago Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
409	1520408814	PRB-18-8	Emma	García Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
410	1909883009	PRB-18-9	Benjamín	Macías Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
411	0134083559	PRB-18-10	Sofía	Delgado Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
412	2311008417	PRB-18-11	Martín	Chávez Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
413	1651252965	PRB-18-12	Luciana	Bravo Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
414	1859945709	PRB-18-13	Emiliano	Pincay Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
415	0700750045	PRB-18-14	Renata	Solórzano Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
416	0753188622	PRB-18-15	Thiago	Parrales Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
417	0622192797	PRB-18-16	Antonella	Andrade Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
418	2315020756	PRB-18-17	Dylan	Moreira Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
419	1212844185	PRB-18-18	Mía	Rodríguez García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
420	2059412912	PRB-18-19	Gael	Alcívar Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
421	2243566037	PRB-18-20	Julieta	Cabrera Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
422	0329247720	PRB-28-1	Mateo	Chávez Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
423	1814894885	PRB-28-2	Valentina	Bravo Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
424	1221243049	PRB-28-3	Santiago	Pincay Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
425	0938164407	PRB-28-4	Camila	Solórzano Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
426	2219400872	PRB-28-5	Sebastián	Parrales Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
427	1133836559	PRB-28-6	Isabella	Andrade Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
428	1332908134	PRB-28-7	Nicolás	Moreira Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
429	0243255163	PRB-28-8	Emma	Rodríguez Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
430	0415622620	PRB-28-9	Benjamín	Alcívar Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
431	2207717782	PRB-28-10	Sofía	Cabrera Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
432	0822773537	PRB-28-11	Martín	Ponce Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
433	2018843439	PRB-28-12	Luciana	Zambrano Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
434	1031616459	PRB-28-13	Emiliano	Mendoza Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
435	2342328651	PRB-28-14	Renata	Cedeño Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
436	1049250960	PRB-28-15	Thiago	Loor Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
437	2238744029	PRB-28-16	Antonella	Vera Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
438	0105718209	PRB-28-17	Dylan	Intriago Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
439	1205664681	PRB-28-18	Mía	García García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
440	0802294876	PRB-28-19	Gael	Macías Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
441	0105602056	PRB-28-20	Julieta	Delgado Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
442	1545406132	PRB-19-1	Mateo	Zambrano Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
443	0103409884	PRB-19-2	Valentina	Mendoza Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
444	1123841817	PRB-19-3	Santiago	Cedeño Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
445	1620798569	PRB-19-4	Camila	Loor Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
446	2048646430	PRB-19-5	Sebastián	Vera Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
447	2205538420	PRB-19-6	Isabella	Intriago Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
448	1231089440	PRB-19-7	Nicolás	García Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
449	1801602895	PRB-19-8	Emma	Macías Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
450	0805545308	PRB-19-9	Benjamín	Delgado Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
451	1939886279	PRB-19-10	Sofía	Chávez Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
452	1620750180	PRB-19-11	Martín	Bravo Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
453	1329020885	PRB-19-12	Luciana	Pincay Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
454	1953850623	PRB-19-13	Emiliano	Solórzano Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
455	1902008836	PRB-19-14	Renata	Parrales Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
456	1822447361	PRB-19-15	Thiago	Andrade Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
457	1027620655	PRB-19-16	Antonella	Moreira Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
458	1929003075	PRB-19-17	Dylan	Rodríguez García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
459	1611520733	PRB-19-18	Mía	Alcívar Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
460	0451320170	PRB-19-19	Gael	Cabrera Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
461	1529560466	PRB-19-20	Julieta	Ponce Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
462	2126808860	PRB-20-1	Mateo	Mendoza Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
463	2432540090	PRB-20-2	Valentina	Cedeño Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
464	0700089915	PRB-20-3	Santiago	Loor Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
465	0741710479	PRB-20-4	Camila	Vera Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
466	0520870445	PRB-20-5	Sebastián	Intriago Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
467	1422837755	PRB-20-6	Isabella	García Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
468	0124757618	PRB-20-7	Nicolás	Macías Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
469	0102721511	PRB-20-8	Emma	Delgado Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
470	1422677268	PRB-20-9	Benjamín	Chávez Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
471	0951418276	PRB-20-10	Sofía	Bravo Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
472	1544936113	PRB-20-11	Martín	Pincay Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
473	0645450115	PRB-20-12	Luciana	Solórzano Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
474	1926118629	PRB-20-13	Emiliano	Parrales Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
475	0543015648	PRB-20-14	Renata	Andrade Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
476	1052579503	PRB-20-15	Thiago	Moreira Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
477	0638099101	PRB-20-16	Antonella	Rodríguez Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
478	1101917324	PRB-20-17	Dylan	Alcívar García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
479	1058758267	PRB-20-18	Mía	Cabrera Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
480	2414378659	PRB-20-19	Gael	Ponce Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
481	0441443934	PRB-20-20	Julieta	Zambrano Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
482	0337627319	PRB-29-1	Mateo	Bravo Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
483	0800313595	PRB-29-2	Valentina	Pincay Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
484	1511922328	PRB-29-3	Santiago	Solórzano Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
485	1823127665	PRB-29-4	Camila	Parrales Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
486	0704082171	PRB-29-5	Sebastián	Andrade Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
487	1402669921	PRB-29-6	Isabella	Moreira Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
488	1440127288	PRB-29-7	Nicolás	Rodríguez Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
489	2310146507	PRB-29-8	Emma	Alcívar Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
490	0308260843	PRB-29-9	Benjamín	Cabrera Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
491	1646481497	PRB-29-10	Sofía	Ponce Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
492	1414717064	PRB-29-11	Martín	Zambrano Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
493	1711517324	PRB-29-12	Luciana	Mendoza Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
494	2415358783	PRB-29-13	Emiliano	Cedeño Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
495	1231232362	PRB-29-14	Renata	Loor Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
496	1954436828	PRB-29-15	Thiago	Vera Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
497	2113444083	PRB-29-16	Antonella	Intriago Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
498	1302261498	PRB-29-17	Dylan	García García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
499	2020895955	PRB-29-18	Mía	Macías Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
500	1255007807	PRB-29-19	Gael	Delgado Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
501	0456729524	PRB-29-20	Julieta	Chávez Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
502	0715782934	PRB-21-1	Mateo	Cedeño Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
503	1934656552	PRB-21-2	Valentina	Loor Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
504	0640717583	PRB-21-3	Santiago	Vera Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
505	0908974314	PRB-21-4	Camila	Intriago Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
506	0914080098	PRB-21-5	Sebastián	García Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
507	0923426324	PRB-21-6	Isabella	Macías Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
508	0716637004	PRB-21-7	Nicolás	Delgado Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
509	1319331813	PRB-21-8	Emma	Chávez Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
510	0240638908	PRB-21-9	Benjamín	Bravo Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
511	0836670786	PRB-21-10	Sofía	Pincay Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
512	0441989605	PRB-21-11	Martín	Solórzano Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
513	2325402226	PRB-21-12	Luciana	Parrales Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
514	2108418910	PRB-21-13	Emiliano	Andrade Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
515	0844714287	PRB-21-14	Renata	Moreira Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
516	1916567710	PRB-21-15	Thiago	Rodríguez Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
517	1249427319	PRB-21-16	Antonella	Alcívar García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
518	0815044110	PRB-21-17	Dylan	Cabrera Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
519	1658249287	PRB-21-18	Mía	Ponce Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
520	1551404039	PRB-21-19	Gael	Zambrano Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
521	2439092541	PRB-21-20	Julieta	Mendoza Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
522	0700396252	PRB-22-1	Mateo	Loor Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
523	1826338954	PRB-22-2	Valentina	Vera Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
524	0204209183	PRB-22-3	Santiago	Intriago Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
525	0229527379	PRB-22-4	Camila	García Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
526	0808209845	PRB-22-5	Sebastián	Macías Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
527	0920748621	PRB-22-6	Isabella	Delgado Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
528	0720274612	PRB-22-7	Nicolás	Chávez Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
529	2111700114	PRB-22-8	Emma	Bravo Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
530	1616485338	PRB-22-9	Benjamín	Pincay Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
531	1822196653	PRB-22-10	Sofía	Solórzano Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
532	0408228948	PRB-22-11	Martín	Parrales Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
533	1729610780	PRB-22-12	Luciana	Andrade Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
534	0230715773	PRB-22-13	Emiliano	Moreira Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
535	2413328457	PRB-22-14	Renata	Rodríguez Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
536	2441013691	PRB-22-15	Thiago	Alcívar Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
537	2007025576	PRB-22-16	Antonella	Cabrera García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
538	0722593951	PRB-22-17	Dylan	Ponce Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
539	0251058921	PRB-22-18	Mía	Zambrano Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
540	0401041363	PRB-22-19	Gael	Mendoza Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
541	1510799412	PRB-22-20	Julieta	Cedeño Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
542	1138669948	PRB-30-1	Mateo	Pincay Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
543	1751109370	PRB-30-2	Valentina	Solórzano Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
544	0719074312	PRB-30-3	Santiago	Parrales Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
545	0312378524	PRB-30-4	Camila	Andrade Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
546	0224667535	PRB-30-5	Sebastián	Moreira Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
547	1447964493	PRB-30-6	Isabella	Rodríguez Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
548	1523396933	PRB-30-7	Nicolás	Alcívar Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
549	2020771784	PRB-30-8	Emma	Cabrera Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
550	0521029686	PRB-30-9	Benjamín	Ponce Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
551	0440754406	PRB-30-10	Sofía	Zambrano Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
552	1203730419	PRB-30-11	Martín	Mendoza Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
553	0616225900	PRB-30-12	Luciana	Cedeño Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
554	0326329992	PRB-30-13	Emiliano	Loor Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
555	1653537371	PRB-30-14	Renata	Vera Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
556	0649543980	PRB-30-15	Thiago	Intriago Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
557	1456858669	PRB-30-16	Antonella	García García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
558	2108972395	PRB-30-17	Dylan	Macías Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
559	1526037815	PRB-30-18	Mía	Delgado Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
560	1511552562	PRB-30-19	Gael	Chávez Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
561	0932706526	PRB-30-20	Julieta	Bravo Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
562	1034861912	PRB-23-1	Mateo	Vera Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
563	2233655113	PRB-23-2	Valentina	Intriago Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
564	1822601587	PRB-23-3	Santiago	García Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
565	2004990665	PRB-23-4	Camila	Macías Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
566	0333474823	PRB-23-5	Sebastián	Delgado Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
567	0314390584	PRB-23-6	Isabella	Chávez Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
568	1750461285	PRB-23-7	Nicolás	Bravo Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
569	1109072684	PRB-23-8	Emma	Pincay Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
570	0442899886	PRB-23-9	Benjamín	Solórzano Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
571	1054175623	PRB-23-10	Sofía	Parrales Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
572	0325126027	PRB-23-11	Martín	Andrade Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
573	2128778939	PRB-23-12	Luciana	Moreira Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
574	1324918042	PRB-23-13	Emiliano	Rodríguez Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
575	0505490797	PRB-23-14	Renata	Alcívar Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
576	2253965061	PRB-23-15	Thiago	Cabrera García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
577	1047197726	PRB-23-16	Antonella	Ponce Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
578	2455152237	PRB-23-17	Dylan	Zambrano Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
579	0613711985	PRB-23-18	Mía	Mendoza Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
580	1039319429	PRB-23-19	Gael	Cedeño Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
581	1825587668	PRB-23-20	Julieta	Loor Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
582	0551270648	PRB-24-1	Mateo	Intriago Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
583	1111702237	PRB-24-2	Valentina	García Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
584	0322724832	PRB-24-3	Santiago	Macías Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
585	2125645529	PRB-24-4	Camila	Delgado Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
586	0534627765	PRB-24-5	Sebastián	Chávez Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
587	1827313196	PRB-24-6	Isabella	Bravo Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
588	2108112570	PRB-24-7	Nicolás	Pincay Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
589	1746751708	PRB-24-8	Emma	Solórzano Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
590	1139158651	PRB-24-9	Benjamín	Parrales Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
591	1905117352	PRB-24-10	Sofía	Andrade Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
592	2211225202	PRB-24-11	Martín	Moreira Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
593	1333343299	PRB-24-12	Luciana	Rodríguez Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
594	1517662860	PRB-24-13	Emiliano	Alcívar Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
595	1952770277	PRB-24-14	Renata	Cabrera Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
596	1602440701	PRB-24-15	Thiago	Ponce García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
597	0955897129	PRB-24-16	Antonella	Zambrano Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
598	0849109145	PRB-24-17	Dylan	Mendoza Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
599	1835580083	PRB-24-18	Mía	Cedeño Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
600	1032279133	PRB-24-19	Gael	Loor Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
601	0901848101	PRB-24-20	Julieta	Vera Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
602	0352418594	PRB-31-1	Mateo	Solórzano Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
603	0513239491	PRB-31-2	Valentina	Parrales Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
604	2122220581	PRB-31-3	Santiago	Andrade Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
605	0301589842	PRB-31-4	Camila	Moreira Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
606	1047735632	PRB-31-5	Sebastián	Rodríguez Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
607	1003435508	PRB-31-6	Isabella	Alcívar Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
608	2450826967	PRB-31-7	Nicolás	Cabrera Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
609	1050503422	PRB-31-8	Emma	Ponce Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
610	0201721511	PRB-31-9	Benjamín	Zambrano Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
611	0247918436	PRB-31-10	Sofía	Mendoza Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
612	1247860222	PRB-31-11	Martín	Cedeño Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
613	0134916766	PRB-31-12	Luciana	Loor Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
614	2000233508	PRB-31-13	Emiliano	Vera Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
615	0315428235	PRB-31-14	Renata	Intriago Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
616	1643457086	PRB-31-15	Thiago	García García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
617	1537709048	PRB-31-16	Antonella	Macías Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
618	1936947868	PRB-31-17	Dylan	Delgado Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
619	0407741735	PRB-31-18	Mía	Chávez Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
620	2447507050	PRB-31-19	Gael	Bravo Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
621	0956417059	PRB-31-20	Julieta	Pincay Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
622	0618248116	PRB-25-1	Mateo	García Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
623	0700759079	PRB-25-2	Valentina	Macías Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
624	0241128495	PRB-25-3	Santiago	Delgado Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
625	0227113867	PRB-25-4	Camila	Chávez Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
626	1040135129	PRB-25-5	Sebastián	Bravo Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
627	1134403102	PRB-25-6	Isabella	Pincay Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
628	0757851555	PRB-25-7	Nicolás	Solórzano Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
629	2120769530	PRB-25-8	Emma	Parrales Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
630	1134068400	PRB-25-9	Benjamín	Andrade Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
631	2321973469	PRB-25-10	Sofía	Moreira Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
632	0950671131	PRB-25-11	Martín	Rodríguez Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
633	0203640248	PRB-25-12	Luciana	Alcívar Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
634	0638610493	PRB-25-13	Emiliano	Cabrera Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
635	0558214623	PRB-25-14	Renata	Ponce García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
636	1855980775	PRB-25-15	Thiago	Zambrano Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
637	1449491313	PRB-25-16	Antonella	Mendoza Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
638	1157709815	PRB-25-17	Dylan	Cedeño Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
639	2248623379	PRB-25-18	Mía	Loor Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
640	0840028617	PRB-25-19	Gael	Vera Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
641	0259469955	PRB-25-20	Julieta	Intriago Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
642	1619049487	PRB-26-1	Mateo	Macías Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
643	1307217479	PRB-26-2	Valentina	Delgado Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
644	1945182390	PRB-26-3	Santiago	Chávez Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
645	0823449913	PRB-26-4	Camila	Bravo Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
646	0204821110	PRB-26-5	Sebastián	Pincay Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
647	1303343881	PRB-26-6	Isabella	Solórzano Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
648	0205539695	PRB-26-7	Nicolás	Parrales Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
649	1912618186	PRB-26-8	Emma	Andrade Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
650	1959369693	PRB-26-9	Benjamín	Moreira Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
651	0842767410	PRB-26-10	Sofía	Rodríguez Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
652	1315324556	PRB-26-11	Martín	Alcívar Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
653	0619018286	PRB-26-12	Luciana	Cabrera Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
654	2104236209	PRB-26-13	Emiliano	Ponce Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
655	1444277055	PRB-26-14	Renata	Zambrano García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
656	1458468210	PRB-26-15	Thiago	Mendoza Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
657	0455074294	PRB-26-16	Antonella	Cedeño Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
658	0530585439	PRB-26-17	Dylan	Loor Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
659	0504204579	PRB-26-18	Mía	Vera Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
660	1356206878	PRB-26-19	Gael	Intriago Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
661	0331051474	PRB-26-20	Julieta	García Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
662	0248841348	PRB-32-1	Mateo	Parrales Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
663	1324768066	PRB-32-2	Valentina	Andrade Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
664	1612509255	PRB-32-3	Santiago	Moreira Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
665	1150510939	PRB-32-4	Camila	Rodríguez Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
666	0434862405	PRB-32-5	Sebastián	Alcívar Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
667	1220734055	PRB-32-6	Isabella	Cabrera Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
668	1144280961	PRB-32-7	Nicolás	Ponce Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
669	1649678701	PRB-32-8	Emma	Zambrano Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
670	0639758242	PRB-32-9	Benjamín	Mendoza Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
671	1233138054	PRB-32-10	Sofía	Cedeño Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
672	0149757429	PRB-32-11	Martín	Loor Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
673	0301596441	PRB-32-12	Luciana	Vera Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
674	2350791493	PRB-32-13	Emiliano	Intriago Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
675	0633972559	PRB-32-14	Renata	García García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
676	0149138174	PRB-32-15	Thiago	Macías Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
677	0754323178	PRB-32-16	Antonella	Delgado Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
678	1303410896	PRB-32-17	Dylan	Chávez Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
679	1955068554	PRB-32-18	Mía	Bravo Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
680	0127475721	PRB-32-19	Gael	Pincay Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
681	1532648795	PRB-32-20	Julieta	Solórzano Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
\.


--
-- Data for Name: fichas_estudiante; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.fichas_estudiante (id_ficha, id_estudiante, tipo_sangre, alergias, medicacion_permanente, enfermedad_catastrofica, detalle_enfermedad, contacto_emergencia, telefono_emergencia, direccion_referencia, fecha_actualizacion) FROM stdin;
\.


--
-- Data for Name: grados; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.grados (id_grado, id_nivel, nombre, orden, capacidad_max, activo) FROM stdin;
1	1	Inicial 1	1	\N	t
2	1	Inicial 2	2	\N	t
3	2	Preparatoria (1er año EGB)	3	\N	t
4	3	Segundo año EGB	4	\N	t
5	3	Tercer año EGB	5	\N	t
6	3	Cuarto año EGB	6	\N	t
7	4	Quinto año EGB	7	\N	t
8	4	Sexto año EGB	8	\N	t
9	4	Séptimo año EGB	9	\N	t
10	5	Octavo año EGB	10	\N	t
11	5	Noveno año EGB	11	\N	t
12	5	Décimo año EGB	12	\N	t
\.


--
-- Data for Name: historial_promocion; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.historial_promocion (id_historial, id_matricula, id_estudiante, id_grado_origen, id_ano_lectivo, resultado, promedio_anual, observaciones, registrado_por, fecha_registro, lamport_ts) FROM stdin;
\.


--
-- Data for Name: horarios; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.horarios (id_horario, id_asignacion, id_periodo_diario, dia_semana) FROM stdin;
\.


--
-- Data for Name: malla_curricular; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.malla_curricular (id_malla, id_grado, id_asignatura, horas_semana, dias_semana, duracion, activo, fecha_creacion, id_ano_lectivo) FROM stdin;
1	3	14	25	\N	\N	t	2026-07-27 02:15:58.444356+00	1
2	3	5	3	\N	\N	t	2026-07-27 02:15:58.444356+00	1
3	3	6	2	\N	\N	t	2026-07-27 02:15:58.444356+00	1
4	4	14	20	\N	\N	t	2026-07-27 02:15:58.444356+00	1
5	4	5	3	\N	\N	t	2026-07-27 02:15:58.444356+00	1
6	4	6	2	\N	\N	t	2026-07-27 02:15:58.444356+00	1
7	4	15	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
8	4	8	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
9	4	7	3	\N	\N	t	2026-07-27 02:15:58.444356+00	1
10	5	14	20	\N	\N	t	2026-07-27 02:15:58.444356+00	1
11	5	5	3	\N	\N	t	2026-07-27 02:15:58.444356+00	1
12	5	6	2	\N	\N	t	2026-07-27 02:15:58.444356+00	1
13	5	15	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
14	5	8	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
15	5	7	3	\N	\N	t	2026-07-27 02:15:58.444356+00	1
16	6	14	20	\N	\N	t	2026-07-27 02:15:58.444356+00	1
17	6	5	3	\N	\N	t	2026-07-27 02:15:58.444356+00	1
18	6	6	2	\N	\N	t	2026-07-27 02:15:58.444356+00	1
19	6	15	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
20	6	8	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
21	6	7	3	\N	\N	t	2026-07-27 02:15:58.444356+00	1
22	7	1	6	\N	\N	t	2026-07-27 02:15:58.444356+00	1
23	7	2	6	\N	\N	t	2026-07-27 02:15:58.444356+00	1
24	7	4	4	\N	\N	t	2026-07-27 02:15:58.444356+00	1
25	7	3	4	\N	\N	t	2026-07-27 02:15:58.444356+00	1
26	7	6	2	\N	\N	t	2026-07-27 02:15:58.444356+00	1
27	7	7	3	\N	\N	t	2026-07-27 02:15:58.444356+00	1
28	7	5	3	\N	\N	t	2026-07-27 02:15:58.444356+00	1
29	7	8	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
30	7	15	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
31	8	1	6	\N	\N	t	2026-07-27 02:15:58.444356+00	1
32	8	2	6	\N	\N	t	2026-07-27 02:15:58.444356+00	1
33	8	4	4	\N	\N	t	2026-07-27 02:15:58.444356+00	1
34	8	3	4	\N	\N	t	2026-07-27 02:15:58.444356+00	1
35	8	6	2	\N	\N	t	2026-07-27 02:15:58.444356+00	1
36	8	7	3	\N	\N	t	2026-07-27 02:15:58.444356+00	1
37	8	5	3	\N	\N	t	2026-07-27 02:15:58.444356+00	1
38	8	8	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
39	8	15	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
40	9	1	6	\N	\N	t	2026-07-27 02:15:58.444356+00	1
41	9	2	6	\N	\N	t	2026-07-27 02:15:58.444356+00	1
42	9	4	4	\N	\N	t	2026-07-27 02:15:58.444356+00	1
43	9	3	4	\N	\N	t	2026-07-27 02:15:58.444356+00	1
44	9	6	2	\N	\N	t	2026-07-27 02:15:58.444356+00	1
45	9	7	3	\N	\N	t	2026-07-27 02:15:58.444356+00	1
46	9	5	3	\N	\N	t	2026-07-27 02:15:58.444356+00	1
47	9	8	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
48	9	15	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
49	10	1	6	\N	\N	t	2026-07-27 02:15:58.444356+00	1
50	10	2	6	\N	\N	t	2026-07-27 02:15:58.444356+00	1
51	10	4	4	\N	\N	t	2026-07-27 02:15:58.444356+00	1
52	10	3	4	\N	\N	t	2026-07-27 02:15:58.444356+00	1
53	10	6	2	\N	\N	t	2026-07-27 02:15:58.444356+00	1
54	10	7	3	\N	\N	t	2026-07-27 02:15:58.444356+00	1
55	10	5	2	\N	\N	t	2026-07-27 02:15:58.444356+00	1
56	10	8	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
57	10	15	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
58	10	13	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
59	11	1	6	\N	\N	t	2026-07-27 02:15:58.444356+00	1
60	11	2	6	\N	\N	t	2026-07-27 02:15:58.444356+00	1
61	11	4	4	\N	\N	t	2026-07-27 02:15:58.444356+00	1
62	11	3	4	\N	\N	t	2026-07-27 02:15:58.444356+00	1
63	11	6	2	\N	\N	t	2026-07-27 02:15:58.444356+00	1
64	11	7	3	\N	\N	t	2026-07-27 02:15:58.444356+00	1
65	11	5	2	\N	\N	t	2026-07-27 02:15:58.444356+00	1
66	11	8	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
67	11	15	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
68	11	13	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
69	12	1	6	\N	\N	t	2026-07-27 02:15:58.444356+00	1
70	12	2	6	\N	\N	t	2026-07-27 02:15:58.444356+00	1
71	12	4	4	\N	\N	t	2026-07-27 02:15:58.444356+00	1
72	12	3	4	\N	\N	t	2026-07-27 02:15:58.444356+00	1
73	12	6	2	\N	\N	t	2026-07-27 02:15:58.444356+00	1
74	12	7	3	\N	\N	t	2026-07-27 02:15:58.444356+00	1
75	12	5	2	\N	\N	t	2026-07-27 02:15:58.444356+00	1
76	12	8	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
77	12	15	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
78	12	13	1	\N	\N	t	2026-07-27 02:15:58.444356+00	1
\.


--
-- Data for Name: matriculas; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.matriculas (id_matricula, id_estudiante, id_grado, id_paralelo, id_ano_lectivo, numero_orden, fecha_registro, estado, observaciones, registrado_por, fecha_creacion) FROM stdin;
5	6	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:07.269328+00
6	7	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:07.747337+00
7	8	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:08.651567+00
8	9	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:09.470775+00
9	10	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:10.250461+00
10	11	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:11.032842+00
11	12	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:11.767466+00
12	13	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:12.229499+00
13	14	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:12.694348+00
14	15	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:13.510576+00
15	16	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:15.089629+00
16	17	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:16.85246+00
17	18	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:18.538751+00
18	19	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:19.306008+00
19	20	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:19.77454+00
20	21	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:20.243818+00
21	22	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:20.711423+00
22	23	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:21.179556+00
23	24	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:21.645648+00
24	25	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:22.56306+00
25	26	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:23.565704+00
26	27	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:24.485848+00
27	28	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:25.511763+00
28	29	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:26.229686+00
29	30	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:27.263026+00
30	31	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:28.824385+00
31	32	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:30.618548+00
32	33	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:32.807567+00
33	34	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:33.280156+00
34	35	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:33.74878+00
35	36	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:34.726758+00
36	37	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:35.531299+00
37	38	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:36.366225+00
38	39	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:37.003942+00
39	40	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:38.116406+00
40	41	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:39.68452+00
41	42	3	7	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:28:41.421589+00
42	43	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:35.712025+00
43	44	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:36.360321+00
44	45	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:37.377336+00
45	46	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:38.299672+00
46	47	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:39.139607+00
47	48	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:39.958565+00
48	49	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:40.973258+00
49	50	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:41.793756+00
50	51	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:43.623931+00
51	52	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:45.17246+00
52	53	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:46.855631+00
53	54	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:47.894032+00
54	55	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:48.271366+00
55	56	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:48.649644+00
56	57	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:49.021315+00
57	58	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:49.388993+00
58	59	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:49.752861+00
59	60	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:50.396176+00
60	61	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:51.304638+00
61	62	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:52.071731+00
62	63	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:52.766834+00
63	64	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:54.81638+00
64	65	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:56.546528+00
65	66	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:58.225843+00
66	67	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:58.928495+00
67	68	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:59.294176+00
68	69	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:44:59.658984+00
69	70	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:45:00.024979+00
70	71	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:45:00.829453+00
71	72	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:45:01.747388+00
72	73	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:45:02.375527+00
73	74	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:45:03.28479+00
74	75	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:45:04.312047+00
75	76	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:45:05.11711+00
76	77	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:45:06.064355+00
77	78	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:45:06.790336+00
78	79	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:45:08.626797+00
79	80	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:45:10.181271+00
80	81	4	9	1	\N	2026-07-08	ACTIVA	\N	\N	2026-07-08 19:45:11.870991+00
81	82	1	3	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
82	83	1	3	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
83	84	1	3	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
84	85	1	3	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
85	86	1	3	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
86	87	1	3	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
87	88	1	3	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
88	89	1	3	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
89	90	1	3	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
90	91	1	3	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
91	92	1	3	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
92	93	1	3	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
93	94	1	3	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
94	95	1	3	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
95	96	1	3	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
96	97	1	3	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
97	98	1	3	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
98	99	1	3	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
99	100	1	3	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
100	101	1	3	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
101	102	1	4	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
102	103	1	4	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
103	104	1	4	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
104	105	1	4	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
105	106	1	4	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
106	107	1	4	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
107	108	1	4	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
108	109	1	4	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
109	110	1	4	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
110	111	1	4	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
111	112	1	4	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
112	113	1	4	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
113	114	1	4	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
114	115	1	4	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
115	116	1	4	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
116	117	1	4	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
117	118	1	4	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
118	119	1	4	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
119	120	1	4	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
120	121	1	4	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
121	122	2	5	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
122	123	2	5	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
123	124	2	5	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
124	125	2	5	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
125	126	2	5	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
126	127	2	5	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
127	128	2	5	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
128	129	2	5	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
129	130	2	5	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
130	131	2	5	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
131	132	2	5	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
132	133	2	5	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
133	134	2	5	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
134	135	2	5	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
135	136	2	5	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
136	137	2	5	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
137	138	2	5	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
138	139	2	5	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
139	140	2	5	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
140	141	2	5	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
141	142	2	6	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
142	143	2	6	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
143	144	2	6	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
144	145	2	6	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
145	146	2	6	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
146	147	2	6	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
147	148	2	6	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
148	149	2	6	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
149	150	2	6	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
150	151	2	6	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
151	152	2	6	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
152	153	2	6	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
153	154	2	6	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
154	155	2	6	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
155	156	2	6	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
156	157	2	6	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
157	158	2	6	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
158	159	2	6	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
159	160	2	6	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
160	161	2	6	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
161	162	3	7	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
162	163	3	7	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
163	164	3	7	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
164	165	3	7	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
165	166	3	7	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
166	167	3	7	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
167	168	3	7	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
168	169	3	7	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
169	170	3	7	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
170	171	3	7	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
171	172	3	7	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
172	173	3	7	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
173	174	3	7	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
174	175	3	7	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
175	176	3	7	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
176	177	3	7	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
177	178	3	7	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
178	179	3	7	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
179	180	3	7	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
180	181	3	7	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
181	182	3	8	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
182	183	3	8	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
183	184	3	8	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
184	185	3	8	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
185	186	3	8	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
186	187	3	8	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
187	188	3	8	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
188	189	3	8	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
189	190	3	8	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
190	191	3	8	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
191	192	3	8	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
192	193	3	8	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
193	194	3	8	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
194	195	3	8	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
195	196	3	8	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
196	197	3	8	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
197	198	3	8	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
198	199	3	8	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
199	200	3	8	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
200	201	3	8	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
201	202	4	9	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
202	203	4	9	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
203	204	4	9	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
204	205	4	9	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
205	206	4	9	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
206	207	4	9	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
207	208	4	9	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
208	209	4	9	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
209	210	4	9	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
210	211	4	9	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
211	212	4	9	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
212	213	4	9	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
213	214	4	9	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
214	215	4	9	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
215	216	4	9	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
216	217	4	9	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
217	218	4	9	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
218	219	4	9	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
219	220	4	9	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
220	221	4	9	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
221	222	4	10	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
222	223	4	10	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
223	224	4	10	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
224	225	4	10	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
225	226	4	10	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
226	227	4	10	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
227	228	4	10	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
228	229	4	10	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
229	230	4	10	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
230	231	4	10	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
231	232	4	10	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
232	233	4	10	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
233	234	4	10	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
234	235	4	10	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
235	236	4	10	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
236	237	4	10	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
237	238	4	10	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
238	239	4	10	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
239	240	4	10	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
240	241	4	10	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
241	242	5	11	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
242	243	5	11	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
243	244	5	11	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
244	245	5	11	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
245	246	5	11	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
246	247	5	11	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
247	248	5	11	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
248	249	5	11	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
249	250	5	11	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
250	251	5	11	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
251	252	5	11	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
252	253	5	11	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
253	254	5	11	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
254	255	5	11	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
255	256	5	11	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
256	257	5	11	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
257	258	5	11	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
258	259	5	11	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
259	260	5	11	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
260	261	5	11	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
261	262	5	12	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
262	263	5	12	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
263	264	5	12	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
264	265	5	12	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
265	266	5	12	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
266	267	5	12	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
267	268	5	12	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
268	269	5	12	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
269	270	5	12	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
270	271	5	12	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
271	272	5	12	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
272	273	5	12	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
273	274	5	12	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
274	275	5	12	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
275	276	5	12	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
276	277	5	12	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
277	278	5	12	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
278	279	5	12	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
279	280	5	12	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
280	281	5	12	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
281	282	6	13	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
282	283	6	13	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
283	284	6	13	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
284	285	6	13	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
285	286	6	13	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
286	287	6	13	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
287	288	6	13	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
288	289	6	13	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
289	290	6	13	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
290	291	6	13	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
291	292	6	13	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
292	293	6	13	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
293	294	6	13	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
294	295	6	13	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
295	296	6	13	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
296	297	6	13	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
297	298	6	13	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
298	299	6	13	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
299	300	6	13	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
300	301	6	13	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
301	302	6	14	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
302	303	6	14	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
303	304	6	14	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
304	305	6	14	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
305	306	6	14	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
306	307	6	14	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
307	308	6	14	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
308	309	6	14	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
309	310	6	14	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
310	311	6	14	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
311	312	6	14	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
312	313	6	14	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
313	314	6	14	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
314	315	6	14	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
315	316	6	14	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
316	317	6	14	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
317	318	6	14	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
318	319	6	14	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
319	320	6	14	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
320	321	6	14	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
321	322	7	15	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
322	323	7	15	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
323	324	7	15	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
324	325	7	15	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
325	326	7	15	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
326	327	7	15	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
327	328	7	15	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
328	329	7	15	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
329	330	7	15	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
330	331	7	15	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
331	332	7	15	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
332	333	7	15	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
333	334	7	15	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
334	335	7	15	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
335	336	7	15	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
336	337	7	15	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
337	338	7	15	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
338	339	7	15	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
339	340	7	15	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
340	341	7	15	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
341	342	7	16	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
342	343	7	16	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
343	344	7	16	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
344	345	7	16	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
345	346	7	16	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
346	347	7	16	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
347	348	7	16	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
348	349	7	16	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
349	350	7	16	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
350	351	7	16	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
351	352	7	16	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
352	353	7	16	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
353	354	7	16	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
354	355	7	16	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
355	356	7	16	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
356	357	7	16	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
357	358	7	16	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
358	359	7	16	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
359	360	7	16	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
360	361	7	16	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
361	362	7	27	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
362	363	7	27	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
363	364	7	27	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
364	365	7	27	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
365	366	7	27	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
366	367	7	27	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
367	368	7	27	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
368	369	7	27	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
369	370	7	27	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
370	371	7	27	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
371	372	7	27	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
372	373	7	27	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
373	374	7	27	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
374	375	7	27	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
375	376	7	27	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
376	377	7	27	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
377	378	7	27	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
378	379	7	27	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
379	380	7	27	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
380	381	7	27	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
381	382	8	17	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
382	383	8	17	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
383	384	8	17	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
384	385	8	17	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
385	386	8	17	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
386	387	8	17	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
387	388	8	17	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
388	389	8	17	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
389	390	8	17	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
390	391	8	17	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
391	392	8	17	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
392	393	8	17	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
393	394	8	17	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
394	395	8	17	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
395	396	8	17	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
396	397	8	17	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
397	398	8	17	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
398	399	8	17	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
399	400	8	17	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
400	401	8	17	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
401	402	8	18	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
402	403	8	18	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
403	404	8	18	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
404	405	8	18	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
405	406	8	18	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
406	407	8	18	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
407	408	8	18	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
408	409	8	18	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
409	410	8	18	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
410	411	8	18	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
411	412	8	18	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
412	413	8	18	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
413	414	8	18	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
414	415	8	18	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
415	416	8	18	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
416	417	8	18	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
417	418	8	18	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
418	419	8	18	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
419	420	8	18	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
420	421	8	18	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
421	422	8	28	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
422	423	8	28	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
423	424	8	28	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
424	425	8	28	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
425	426	8	28	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
426	427	8	28	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
427	428	8	28	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
428	429	8	28	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
429	430	8	28	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
430	431	8	28	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
431	432	8	28	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
432	433	8	28	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
433	434	8	28	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
434	435	8	28	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
435	436	8	28	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
436	437	8	28	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
437	438	8	28	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
438	439	8	28	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
439	440	8	28	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
440	441	8	28	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
441	442	9	19	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
442	443	9	19	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
443	444	9	19	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
444	445	9	19	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
445	446	9	19	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
446	447	9	19	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
447	448	9	19	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
448	449	9	19	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
449	450	9	19	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
450	451	9	19	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
451	452	9	19	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
452	453	9	19	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
453	454	9	19	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
454	455	9	19	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
455	456	9	19	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
456	457	9	19	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
457	458	9	19	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
458	459	9	19	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
459	460	9	19	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
460	461	9	19	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
461	462	9	20	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
462	463	9	20	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
463	464	9	20	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
464	465	9	20	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
465	466	9	20	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
466	467	9	20	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
467	468	9	20	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
468	469	9	20	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
469	470	9	20	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
470	471	9	20	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
471	472	9	20	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
472	473	9	20	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
473	474	9	20	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
474	475	9	20	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
475	476	9	20	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
476	477	9	20	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
477	478	9	20	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
478	479	9	20	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
479	480	9	20	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
480	481	9	20	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
481	482	9	29	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
482	483	9	29	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
483	484	9	29	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
484	485	9	29	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
485	486	9	29	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
486	487	9	29	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
487	488	9	29	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
488	489	9	29	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
489	490	9	29	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
490	491	9	29	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
491	492	9	29	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
492	493	9	29	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
493	494	9	29	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
494	495	9	29	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
495	496	9	29	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
496	497	9	29	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
497	498	9	29	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
498	499	9	29	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
499	500	9	29	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
500	501	9	29	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
501	502	10	21	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
502	503	10	21	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
503	504	10	21	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
504	505	10	21	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
505	506	10	21	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
506	507	10	21	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
507	508	10	21	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
508	509	10	21	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
509	510	10	21	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
510	511	10	21	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
511	512	10	21	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
512	513	10	21	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
513	514	10	21	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
514	515	10	21	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
515	516	10	21	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
516	517	10	21	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
517	518	10	21	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
518	519	10	21	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
519	520	10	21	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
520	521	10	21	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
521	522	10	22	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
522	523	10	22	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
523	524	10	22	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
524	525	10	22	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
525	526	10	22	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
526	527	10	22	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
527	528	10	22	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
528	529	10	22	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
529	530	10	22	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
530	531	10	22	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
531	532	10	22	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
532	533	10	22	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
533	534	10	22	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
534	535	10	22	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
535	536	10	22	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
536	537	10	22	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
537	538	10	22	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
538	539	10	22	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
539	540	10	22	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
540	541	10	22	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
541	542	10	30	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
542	543	10	30	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
543	544	10	30	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
544	545	10	30	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
545	546	10	30	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
546	547	10	30	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
547	548	10	30	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
548	549	10	30	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
549	550	10	30	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
550	551	10	30	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
551	552	10	30	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
552	553	10	30	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
553	554	10	30	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
554	555	10	30	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
555	556	10	30	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
556	557	10	30	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
557	558	10	30	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
558	559	10	30	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
559	560	10	30	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
560	561	10	30	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
561	562	11	23	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
562	563	11	23	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
563	564	11	23	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
564	565	11	23	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
565	566	11	23	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
566	567	11	23	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
567	568	11	23	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
568	569	11	23	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
569	570	11	23	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
570	571	11	23	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
571	572	11	23	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
572	573	11	23	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
573	574	11	23	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
574	575	11	23	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
575	576	11	23	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
576	577	11	23	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
577	578	11	23	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
578	579	11	23	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
579	580	11	23	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
580	581	11	23	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
581	582	11	24	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
582	583	11	24	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
583	584	11	24	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
584	585	11	24	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
585	586	11	24	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
586	587	11	24	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
587	588	11	24	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
588	589	11	24	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
589	590	11	24	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
590	591	11	24	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
591	592	11	24	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
592	593	11	24	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
593	594	11	24	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
594	595	11	24	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
595	596	11	24	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
596	597	11	24	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
597	598	11	24	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
598	599	11	24	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
599	600	11	24	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
600	601	11	24	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
601	602	11	31	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
602	603	11	31	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
603	604	11	31	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
604	605	11	31	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
605	606	11	31	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
606	607	11	31	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
607	608	11	31	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
608	609	11	31	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
609	610	11	31	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
610	611	11	31	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
611	612	11	31	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
612	613	11	31	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
613	614	11	31	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
614	615	11	31	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
615	616	11	31	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
616	617	11	31	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
617	618	11	31	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
618	619	11	31	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
619	620	11	31	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
620	621	11	31	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
621	622	12	25	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
622	623	12	25	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
623	624	12	25	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
624	625	12	25	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
625	626	12	25	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
626	627	12	25	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
627	628	12	25	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
628	629	12	25	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
629	630	12	25	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
630	631	12	25	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
631	632	12	25	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
632	633	12	25	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
633	634	12	25	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
634	635	12	25	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
635	636	12	25	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
636	637	12	25	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
637	638	12	25	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
638	639	12	25	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
639	640	12	25	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
640	641	12	25	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
641	642	12	26	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
642	643	12	26	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
643	644	12	26	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
644	645	12	26	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
645	646	12	26	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
646	647	12	26	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
647	648	12	26	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
648	649	12	26	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
649	650	12	26	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
650	651	12	26	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
651	652	12	26	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
652	653	12	26	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
653	654	12	26	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
654	655	12	26	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
655	656	12	26	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
656	657	12	26	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
657	658	12	26	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
658	659	12	26	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
659	660	12	26	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
660	661	12	26	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
661	662	12	32	1	1	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
662	663	12	32	1	2	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
663	664	12	32	1	3	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
664	665	12	32	1	4	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
665	666	12	32	1	5	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
666	667	12	32	1	6	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
667	668	12	32	1	7	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
668	669	12	32	1	8	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
669	670	12	32	1	9	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
670	671	12	32	1	10	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
671	672	12	32	1	11	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
672	673	12	32	1	12	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
673	674	12	32	1	13	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
674	675	12	32	1	14	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
675	676	12	32	1	15	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
676	677	12	32	1	16	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
677	678	12	32	1	17	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
678	679	12	32	1	18	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
679	680	12	32	1	19	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
680	681	12	32	1	20	2026-07-27	ACTIVA	\N	\N	2026-07-27 01:28:43.196068+00
\.


--
-- Data for Name: niveles_educativos; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.niveles_educativos (id_nivel, nombre, tipo_escala, grado_inicio, grado_fin) FROM stdin;
1	Inicial	CUALITATIVA	1	2
2	Preparatoria	CUALITATIVA	3	3
3	Básica Elemental	CUALITATIVA	4	6
4	Básica Media	CUANTITATIVA	7	9
5	Básica Superior	CUANTITATIVA	10	12
\.


--
-- Data for Name: paralelos; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.paralelos (id_paralelo, id_grado, letra, activo) FROM stdin;
3	1	A	t
4	1	B	t
5	2	A	t
6	2	B	t
7	3	A	t
8	3	B	t
9	4	A	t
10	4	B	t
11	5	A	t
12	5	B	t
13	6	A	t
14	6	B	t
15	7	A	t
16	7	B	t
17	8	A	t
18	8	B	t
19	9	A	t
20	9	B	t
21	10	A	t
22	10	B	t
23	11	A	t
24	11	B	t
25	12	A	t
26	12	B	t
27	7	C	t
28	8	C	t
29	9	C	t
30	10	C	t
31	11	C	t
32	12	C	t
\.


--
-- Data for Name: paralelos_ano_lectivo; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.paralelos_ano_lectivo (id_paralelo_al, id_paralelo, id_ano_lectivo, capacidad_max, activo) FROM stdin;
\.


--
-- Data for Name: periodos_diarios; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.periodos_diarios (id_periodo_diario, numero, hora_inicio, hora_fin, aplica_nivel) FROM stdin;
1	1	07:30:00	08:15:00	\N
2	2	08:15:00	09:00:00	\N
3	3	09:00:00	09:45:00	\N
4	4	09:45:00	10:30:00	BASICA_ELEMENTAL
5	4	09:45:00	10:30:00	BASICA_MEDIA
6	4	09:45:00	10:30:00	BASICA_SUPERIOR
7	5	10:30:00	11:15:00	INICIAL_1
8	5	10:30:00	11:15:00	INICIAL_2
9	5	10:30:00	11:15:00	PREPARATORIA
10	5	11:00:00	11:45:00	BASICA_ELEMENTAL
11	5	11:00:00	11:45:00	BASICA_MEDIA
12	5	11:00:00	11:45:00	BASICA_SUPERIOR
13	6	11:45:00	12:30:00	\N
\.


--
-- Data for Name: periodos_evaluacion; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.periodos_evaluacion (id_periodo, id_ano_lectivo, tipo, nombre, fecha_inicio, fecha_fin, activo) FROM stdin;
1	1	PRIMER_TRIMESTRE	Primer Trimestre	2026-05-01	2026-08-10	t
2	1	SEGUNDO_TRIMESTRE	Segundo Trimestre	2026-08-11	2026-11-19	t
3	1	TERCER_TRIMESTRE	Tercer Trimestre	2026-11-20	2027-02-28	t
\.


--
-- Data for Name: personas; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.personas (id_persona, id_usuario, cedula, nombres, apellidos, fecha_nacimiento, genero, telefono, telefono_alt, direccion, correo_personal, titulo_academico, especializacion, fecha_ingreso_inst, cargo, foto_url, fecha_creacion, fecha_actualizacion) FROM stdin;
5	12	1207122753	PEDRO LEONARDO	CASTRO LOPEZ	\N	\N	0969140899	\N	EL EMPALME	PC1207122753@GMAIL.COM	LIC . PUTOLOGIA	EN LA CALLE	\N	\N	/uploads/fotos/a25f9053-840c-4476-bccc-3ddb0360f975.jpg	2026-07-26 17:57:22.816872+00	2026-07-26 17:59:26.793904+00
6	13	1308414943	JAIRO SEGUNDO	 JIMENEZ TOVAR	1979-12-19	MASCULINO	0983621086	0983621086	av quevedo - las tecas	jj6041782@gmail	LICENCIADO EN EDUCACION INFORMATICA	ESTUDIOS SOCIALES	\N	\N	/uploads/fotos/a8593cf2-bc14-42cf-a5ee-acb32a7bc003.png	2026-07-27 03:50:12.52819+00	2026-07-27 03:50:12.52819+00
1	1	0759555451	Pedro	Castro	\N	\N	\N	\N	\N	\N	\N	\N	\N	Docente	\N	2026-06-02 04:03:15.065205+00	2026-07-27 04:45:13.732795+00
10	10	0347473753	Pedro	Castro	\N	\N	\N	\N	\N	\N	\N	\N	\N	DOCENTE	\N	2026-07-23 00:36:05.134923+00	2026-07-27 04:45:13.732795+00
11	14	0723394714	ALBA ALEXANDRA	ALCIVAR OSORIO	\N	\N	\N	\N	\N	\N	LIC.	\N	\N	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:45:13.732795+00
12	15	0136392172	CRUZ MARIA	MACIAS RODRIGUEZ	\N	\N	\N	\N	\N	\N	LIC.	\N	\N	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:45:13.732795+00
13	16	0927061945	GLADYS MARIA	CARRERA ZAMBRANO	\N	\N	\N	\N	\N	\N	LIC.	\N	\N	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:45:13.732795+00
14	17	2144802234	GLADYS ROXANA	VERA INTRIAGO	\N	\N	\N	\N	\N	\N	LIC.	\N	\N	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:45:13.732795+00
15	18	0737936492	GLENDA MIRELLA	RUIZ TUAREZ	\N	\N	\N	\N	\N	\N	LIC.	\N	\N	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:45:13.732795+00
16	19	1003855424	JORGE EMILIO	VERA TRIVINO	\N	\N	\N	\N	\N	\N	LIC.	\N	\N	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:45:13.732795+00
17	20	0534857503	KAREN STEFANIA	GONZALEZ SABANDO	\N	\N	\N	\N	\N	\N	LIC.	\N	\N	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:45:13.732795+00
18	21	0528539638	NEXABEL LILIANA	LITARDO FIGUEROA	\N	\N	\N	\N	\N	\N	LIC.	\N	\N	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:45:13.732795+00
19	22	1327349534	PIEDAD ALICIA	GUAGAJE LLANO	\N	\N	\N	\N	\N	\N	LIC.	\N	\N	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:45:13.732795+00
20	23	0720498344	RITA CAROLINA	CANSIONG VELEZ	\N	\N	\N	\N	\N	\N	LIC.	\N	\N	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:45:13.732795+00
21	24	1449986320	ROGELIO LIZARDO	MUNOZ OLIVO	\N	\N	\N	\N	\N	\N	LIC.	\N	\N	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:45:13.732795+00
22	25	1938313796	ADRIAN ANTONIO	MOREIRA ALAVA	\N	\N	\N	\N	\N	\N	MSC.	\N	\N	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:45:13.732795+00
23	26	0345622393	EVELYN XIOMARA	ARTEAGA SABANDO	\N	\N	\N	\N	\N	\N	MSC.	\N	\N	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:45:13.732795+00
\.


--
-- Data for Name: representantes; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.representantes (id_representante, cedula, nombres, apellidos, parentesco, telefono_principal, telefono_alt, correo, direccion, fecha_creacion, fecha_actualizacion) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.roles (id_rol, nombre, descripcion, activo, fecha_creacion) FROM stdin;
1	DIRECTOR	Gestiona configuración académica institucional	t	2026-05-29 04:18:24.904419+00
2	SECRETARIA	Registro de estudiantes y matrículas	t	2026-05-29 04:18:24.904419+00
3	DOCENTE	Registra calificaciones y asistencia	t	2026-05-29 04:18:24.904419+00
4	SOPORTE_TECNICO	Administración técnica del sistema	t	2026-05-29 04:18:24.904419+00
\.


--
-- Data for Name: tipos_aporte; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.tipos_aporte (id_tipo_aporte, id_ano_lectivo, nombre, tipo_evaluacion, orden, activo) FROM stdin;
1	1	Lección Oral	FORMATIVA	1	t
2	1	Lección Escrita	FORMATIVA	2	t
3	1	Tareas	FORMATIVA	3	t
4	1	Talleres	FORMATIVA	4	t
5	1	Cuaderno	FORMATIVA	5	t
6	1	Trabajo Individual	FORMATIVA	6	t
7	1	Exposición	FORMATIVA	7	t
8	1	Proyecto Interdisciplinario	SUMATIVA	1	t
9	1	Examen del Trimestre	SUMATIVA	2	t
\.


--
-- Data for Name: usuario_roles; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.usuario_roles (id_usuario, id_rol, asignado_por, asignado_el) FROM stdin;
4	4	\N	2026-06-09 02:10:46.711574+00
9	2	\N	2026-06-30 16:37:25.823286+00
1	2	\N	2026-06-30 16:40:40.414861+00
10	3	\N	2026-07-13 14:01:37.943987+00
11	2	\N	2026-07-14 02:23:02.32401+00
3	1	\N	2026-07-20 21:54:10.59216+00
3	2	\N	2026-07-20 21:54:10.59216+00
3	4	\N	2026-07-20 21:54:10.59216+00
3	3	\N	2026-07-20 21:54:10.59216+00
12	2	\N	2026-07-26 17:58:00.501235+00
12	3	\N	2026-07-26 17:58:00.501235+00
12	4	\N	2026-07-26 17:58:00.501235+00
12	1	\N	2026-07-26 17:58:00.501235+00
13	3	\N	2026-07-27 03:50:04.914487+00
14	3	\N	2026-07-27 04:06:32.775994+00
15	3	\N	2026-07-27 04:06:32.775994+00
16	3	\N	2026-07-27 04:06:32.775994+00
17	3	\N	2026-07-27 04:06:32.775994+00
18	3	\N	2026-07-27 04:06:32.775994+00
19	3	\N	2026-07-27 04:06:32.775994+00
20	3	\N	2026-07-27 04:06:32.775994+00
21	3	\N	2026-07-27 04:06:32.775994+00
22	3	\N	2026-07-27 04:06:32.775994+00
23	3	\N	2026-07-27 04:06:32.775994+00
24	3	\N	2026-07-27 04:06:32.775994+00
25	3	\N	2026-07-27 04:06:32.775994+00
26	1	\N	2026-07-27 04:06:32.775994+00
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: sga_principal; Owner: postgres
--

COPY sga_principal.usuarios (id_usuario, uuid, username, correo, password_hash, primer_ingreso, intentos_fallidos, bloqueado_hasta, estado, ultimo_acceso, creado_por, fecha_creacion, fecha_actualizacion) FROM stdin;
3	867bf00c-853f-4f6f-a3cf-758754766dfb	pcastrol2	pcastrol2@sga.com	$2a$10$550UnewwgLmNjlYOz5CCVu3W6Nn0gmWtws6IE0vDqQEpWqHUt0Q26	f	0	\N	t	\N	\N	2026-05-31 04:13:44.251959+00	2026-05-31 04:13:44.251959+00
1	45c64850-5d3f-4bc1-9747-c39b86dc51fb	plcastrol	plcastrol@sga.com	$2a$10$s8i4c2tW5Dq7dGeh7Uv.Xu4uAc/qISf9RQ7fvg4oBcvGI81WfhLvC	f	0	\N	t	\N	\N	2026-05-31 04:04:14.206932+00	2026-05-31 04:04:14.206932+00
9	459e1bcc-65b4-4458-a598-bb1ff661da5a	eluna	ernestolunamora2004@gmail.com	$2a$10$i3MydX62cEZu0kmD7iy91.5R3ZEFZpGSjFixpTN9GhoJfMtveY1tS	f	0	\N	t	\N	\N	2026-06-27 22:50:21.839068+00	2026-06-27 22:50:21.839068+00
4	0db83cd2-55aa-477e-8c7b-6780e81ada84	jemanuel	jemanuelp@uteq.edu.ec	$2b$10$IVKyybmg00ggBJ7hKZ0mWOm2dfxbJqC7MS.RolVuhqbr8WHXvMqxm	t	0	\N	t	\N	\N	2026-06-09 02:10:23.360528+00	2026-06-09 02:10:23.360528+00
11	f7321377-26c8-41d1-a4ee-87326359cf2d	test.secretaria	test.secretaria@sga.com	$2b$12$4aoRk6Qe8l4h2e1NApGQWOFEOqPc2ofJZrmpA4ER6oKZvDjRyTMim	f	0	\N	t	\N	\N	2026-07-14 02:23:02.32401+00	2026-07-14 02:23:02.32401+00
10	5512eddc-3b62-43dd-b202-eb45c5116c55	pcastro	pc1207122753@gmail.com	$2a$10$L0Qb3hAbjRRqT4s/ld3a/uwV1MvyNXgjFzm01x/7UFY/OBf3IWBKG	f	0	\N	t	\N	\N	2026-07-13 14:01:38.054381+00	2026-07-13 14:01:38.054381+00
12	fecfbbc2-70cc-4047-8033-1cb1f388ab3d	lcastro	jj6041782@gmail.com	$2a$10$043mspseQMhVVKrrI2/PJeAX6EDqN.dfRpk8qQdQCyXOg7nh085VW	f	0	\N	t	\N	\N	2026-07-26 15:59:25.570316+00	2026-07-26 15:59:25.570316+00
13	7e92e149-381b-47cc-a3c2-e5bfc3c956f5	jsjimenezt	asosantalucialaguayas@gmail.com	$2a$10$fYXc5GECDA3pm2Bb5AcA7uMhYJH8Z2JazTOBg5HnIlbh1vu8J8Z3e	f	0	\N	t	\N	\N	2026-07-27 03:50:06.485119+00	2026-07-27 03:50:06.485119+00
14	036b93da-2a22-4bc9-9216-1eff9fb7808f	aalcivar	aalcivar@provinciasunidaselrosario.com	$2b$10$9UUQAeSl6GZzOOEptLW8H.gjm/uQmOR8zOo.uBQNUV2kuFCwdN932	f	0	\N	t	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:06:32.775994+00
15	c13d9d2e-b9a9-4e07-983b-1c2c960b0896	cmacias	cmacias@provinciasunidaselrosario.com	$2b$10$4PzVeCVwV0oMCJjJ.1aGxOePEhHeR9u0RKnYJ8Cr0u2TEDWogwoKu	f	0	\N	t	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:06:32.775994+00
16	50199e46-efc1-4f06-b9c6-e07859d05bf1	gcarrera	gcarrera@provinciasunidaselrosario.com	$2b$10$oOtsxRvQSVfyUfVlU961XeR/r2J2efdwUa/rCA95cPHiJO/E5Nn9G	f	0	\N	t	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:06:32.775994+00
17	070dd45b-1456-43bc-ad85-5c1c4c828461	gvera	gvera@provinciasunidaselrosario.com	$2b$10$ByeIr467ytPeZy/SuTBSl.q1S9DoYL3zvPfu9/VdMqiTlfkO/B2R6	f	0	\N	t	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:06:32.775994+00
18	f06124c3-a55d-4f54-9115-c6a6c8c73802	gruiz	gruiz@provinciasunidaselrosario.com	$2b$10$TGDg0h/IuOzW3e1dPw1XouHdBJbqjmP0F5ztUKG1WIJEGfarcO67.	f	0	\N	t	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:06:32.775994+00
19	0395c47a-0b40-4b3e-bb63-2c58a355fb66	jvera	jvera@provinciasunidaselrosario.com	$2b$10$yGDdTIZ5XinFyNBrlPhSrOyctTpWqJIlf8UIa5L9Pog0s7lfWSQUO	f	0	\N	t	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:06:32.775994+00
20	12f18575-dd09-4f11-b394-1d898e530c4e	kgonzalez	kgonzalez@provinciasunidaselrosario.com	$2b$10$GaeqkU1zBaX1qtSotY6HW.SGF/iKzK6x0i4pIdqCNK62sBNk3feQa	f	0	\N	t	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:06:32.775994+00
21	75eef7df-66a4-4fa1-9c13-277c436e5c9c	nlitardo	nlitardo@provinciasunidaselrosario.com	$2b$10$AtGNykngszyaNKG3NKTr0utnEB5ehr3b8fOyVWQ3NSfgpJeMtvRh2	f	0	\N	t	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:06:32.775994+00
22	05f89a14-4560-40e6-b291-00ca70fca787	pguagaje	pguagaje@provinciasunidaselrosario.com	$2b$10$D7W.5yhcvmqhejLpAptomuV0bt0ygtF8kktzdnlj2AxJj3YyIAhGu	f	0	\N	t	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:06:32.775994+00
23	038f997d-571a-49d6-824a-b862c7718d38	rcansiong	rcansiong@provinciasunidaselrosario.com	$2b$10$epK39qqUXJS9/lI49Ye3TOLTFcch6Jz/sMrDNpXXVDe1EldTwgEdC	f	0	\N	t	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:06:32.775994+00
24	e40a765d-b873-4b92-87f1-988c86623f2d	rmunoz	rmunoz@provinciasunidaselrosario.com	$2b$10$7hi9JK5ZX1YfcrJ.0NYYJe41WkE.GhAdVb7hqwkZofU92zw20Sgnq	f	0	\N	t	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:06:32.775994+00
25	28f40248-c62e-4be0-8006-926aba0c5af3	amoreira	amoreira@provinciasunidaselrosario.com	$2b$10$6xwvee8yJfd1ye9fXBOm6OECE.960qLbZb7TXymzfsbGQV/9Q/jBG	f	0	\N	t	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:06:32.775994+00
26	8586d257-430b-4cdc-a7c2-56ea972c7ac8	admin2	admin2@provinciasunidaselrosario.com	$2b$10$hzHSeSwVHBe77ikjW6IsBOzGU3pgWDeMzKwRYU6oFYFzrYCIIjW7S	f	0	\N	t	\N	\N	2026-07-27 04:06:32.775994+00	2026-07-27 04:06:32.775994+00
\.


--
-- Data for Name: documentos_matricula; Type: TABLE DATA; Schema: sga_secretaria; Owner: postgres
--

COPY sga_secretaria.documentos_matricula (id_documento, id_matricula, tipo_documento, nombre_archivo, ruta_archivo, subido_por) FROM stdin;
\.


--
-- Data for Name: estudiantes; Type: TABLE DATA; Schema: sga_secretaria; Owner: postgres
--

COPY sga_secretaria.estudiantes (id_estudiante, cedula, codigo_estudiante, nombres, apellidos, fecha_nacimiento, genero, direccion, telefono, telefono_alt, correo, discapacidad, tipo_discapacidad, porcentaje_disc, id_representante, origen_listado, estado, foto_url, creado_por, fecha_creacion, fecha_actualizacion, carnet_conadis, nacionalidad, etnia, lugar_nacimiento, vive_con, numeros_hermanos, beneficio_social) FROM stdin;
7	1353464074	\N	JOYMI MILAGROS	AMAGUA PAREDES	\N	\N	\N	\N	\N	ampajomi14810424@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:07.513604+00	2026-07-08 19:28:07.513604+00	\N	Ecuatoriana	\N	\N	\N	\N	f
8	0964892095	\N	YEIMY ISABELLA	CATAGUA PARRAGA	\N	\N	\N	\N	\N	capayeis14833522@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:08.244245+00	2026-07-08 19:28:08.244245+00	\N	Ecuatoriana	\N	\N	\N	\N	f
9	0964533913	\N	JANDER MOISES	CEDEÑO RODRIGUEZ	\N	\N	\N	\N	\N	cerojamo14811752@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:08.953773+00	2026-07-08 19:28:08.953773+00	\N	Ecuatoriana	\N	\N	\N	\N	f
10	1252540669	\N	EMMANUEL ALEJANDRO	CHAVARRIA PINCAY	\N	\N	\N	\N	\N	chpiemal14732931@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:09.835521+00	2026-07-08 19:28:09.835521+00	\N	Ecuatoriana	\N	\N	\N	\N	f
11	0965078967	\N	ALICIA VICTORIA	CHAVEZ MACIAS	\N	\N	\N	\N	\N	chmaalvi14885883@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:10.783193+00	2026-07-08 19:28:10.783193+00	\N	Ecuatoriana	\N	\N	\N	\N	f
12	0964616148	\N	ANDER EMIR	CHILAN SOLORZANO	\N	\N	\N	\N	\N	chsoanem14840300@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:11.41712+00	2026-07-08 19:28:11.41712+00	\N	Ecuatoriana	\N	\N	\N	\N	f
13	1252528946	\N	CARLOS THOMAS	DELGADO ZAMBRANO	\N	\N	\N	\N	\N	dezacath14813120@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:11.993575+00	2026-07-08 19:28:11.993575+00	\N	Ecuatoriana	\N	\N	\N	\N	f
14	0964914279	\N	MARIANA NOHEMY	GARCIA MERO	\N	\N	\N	\N	\N	gavenagu14763212@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:12.462324+00	2026-07-08 19:28:12.462324+00	\N	Ecuatoriana	\N	\N	\N	\N	f
15	1252500267	\N	NARCISA GUADALUPE	GARCIA VELEZ	\N	\N	\N	\N	\N	hocemaar14763310@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:12.927485+00	2026-07-08 19:28:12.927485+00	\N	Ecuatoriana	\N	\N	\N	\N	f
16	0965034499	\N	MARIETZY ARISBETH	HOLGUIN CEDEÑO	\N	\N	\N	\N	\N	ingasnal15702639@estudiantes2.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:14.394462+00	2026-07-08 19:28:14.394462+00	\N	Ecuatoriana	\N	\N	\N	\N	f
17	0751919648	\N	SNAIDER ALEXANDER	INTRIAGO GARCIA	\N	\N	\N	\N	\N	intualya14811668@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:15.946439+00	2026-07-08 19:28:15.946439+00	\N	Ecuatoriana	\N	\N	\N	\N	f
18	0964875538	\N	ALEXA YAMILET	INTRIAGO TUAREZ	\N	\N	\N	\N	\N	lamojosu14732934@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:17.654937+00	2026-07-08 19:28:17.654937+00	\N	Ecuatoriana	\N	\N	\N	\N	f
19	0964544274	\N	JOSEPH SURIEL	LAAZ MONTECE	\N	\N	\N	\N	\N	lojaanma14810677@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:19.07914+00	2026-07-08 19:28:19.07914+00	\N	Ecuatoriana	\N	\N	\N	\N	f
20	0965018583	\N	ANGELICA MARILUZ	LOOR JAIME	\N	\N	\N	\N	\N	lomaarju14856919@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:19.540823+00	2026-07-08 19:28:19.540823+00	\N	Ecuatoriana	\N	\N	\N	\N	f
21	0964505879	\N	ARELYS JULIETH	LOPEZ MARCILLO	\N	\N	\N	\N	\N	lujaedga14811454@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:20.011247+00	2026-07-08 19:28:20.011247+00	\N	Ecuatoriana	\N	\N	\N	\N	f
22	0964510648	\N	EDUAR GABRIEL	LUCAS JAMA	\N	\N	\N	\N	\N	mevalist14728799@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:20.478828+00	2026-07-08 19:28:20.478828+00	\N	Ecuatoriana	\N	\N	\N	\N	f
23	0964893234	\N	LISBETH STEFANIA	MENDOZA VASQUEZ	\N	\N	\N	\N	\N	moalxaem16166351@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:20.94457+00	2026-07-08 19:28:20.94457+00	\N	Ecuatoriana	\N	\N	\N	\N	f
24	0964527907	\N	XAVIER EMIR	MORAN ALVARADO	\N	\N	\N	\N	\N	moansnja14812461@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:21.412638+00	2026-07-08 19:28:21.412638+00	\N	Ecuatoriana	\N	\N	\N	\N	f
25	0964455778	\N	SNAIDER JAVIER	MOREIRA ANDRADE	\N	\N	\N	\N	\N	momoalyu14714961@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:22.044164+00	2026-07-08 19:28:22.044164+00	\N	Ecuatoriana	\N	\N	\N	\N	f
26	0964911242	\N	ALEXA YURHEY	MORETA MORALES	\N	\N	\N	\N	\N	muavgrya16174283@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:23.154628+00	2026-07-08 19:28:23.154628+00	\N	Ecuatoriana	\N	\N	\N	\N	f
27	0964825657	\N	GRAZMELY YARDLEY	MUÑOZ AVILA	\N	\N	\N	\N	\N	oraraxga14847166@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:24.013468+00	2026-07-08 19:28:24.013468+00	\N	Ecuatoriana	\N	\N	\N	\N	f
28	0964525224	\N	AXEL GAEL	ORMAZA ARTEAGA	\N	\N	\N	\N	\N	pavalial14763222@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:25.021877+00	2026-07-08 19:28:25.021877+00	\N	Ecuatoriana	\N	\N	\N	\N	f
29	0964491062	\N	LIZ ALEXA	PARRAGA VALENZUELA	\N	\N	\N	\N	\N	pelakada14813329@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:25.834893+00	2026-07-08 19:28:25.834893+00	\N	Ecuatoriana	\N	\N	\N	\N	f
30	0964934731	\N	KATIHUSKA DANAE	PEÑAFIEL LAJE	\N	\N	\N	\N	\N	piloeiad14713526@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:26.652894+00	2026-07-08 19:28:26.652894+00	\N	Ecuatoriana	\N	\N	\N	\N	f
31	0964586903	\N	EINER ADRIEL	PINARGOTE LOZANO	\N	\N	\N	\N	\N	recamada16111208@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:28.137071+00	2026-07-08 19:28:28.137071+00	\N	Ecuatoriana	\N	\N	\N	\N	f
32	1252516958	\N	MARCOS DAVID	REYES CARDENAS	\N	\N	\N	\N	\N	ricasaju14730615@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:29.695642+00	2026-07-08 19:28:29.695642+00	\N	Ecuatoriana	\N	\N	\N	\N	f
33	0964540686	\N	SAMARA JULIETTE	RISCO CARREÑO	\N	\N	\N	\N	\N	romadeez14812311@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:31.416787+00	2026-07-08 19:28:31.416787+00	\N	Ecuatoriana	\N	\N	\N	\N	f
34	1353484775	\N	DERECK EZEQUIELL	ROSADO MACIAS	\N	\N	\N	\N	\N	sabrkiai16162971@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:33.042731+00	2026-07-08 19:28:33.042731+00	\N	Ecuatoriana	\N	\N	\N	\N	f
35	1353564055	\N	KIMBERLY AILYN	SALDAÑA BRAVO	\N	\N	\N	\N	\N	sachwajo14812066@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:33.515518+00	2026-07-08 19:28:33.515518+00	\N	Ecuatoriana	\N	\N	\N	\N	f
36	0964451033	\N	WALTER JOHAN	SALTOS CHILAN	\N	\N	\N	\N	\N	sagamami14811172@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:34.313467+00	2026-07-08 19:28:34.313467+00	\N	Ecuatoriana	\N	\N	\N	\N	f
37	0965195092	\N	MARIA MILAGROS	SANCHEZ GARCIA	\N	\N	\N	\N	\N	sapithma16165957@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:35.235752+00	2026-07-08 19:28:35.235752+00	\N	Ecuatoriana	\N	\N	\N	\N	f
38	0964984371	\N	THIAGO MATEO	SANCHEZ PINARGOTE	\N	\N	\N	\N	\N	varedajo16165467@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:35.912966+00	2026-07-08 19:28:35.912966+00	\N	Ecuatoriana	\N	\N	\N	\N	f
39	0964622138	\N	DARIXON JOSUE	VALENCIA REYES	\N	\N	\N	\N	\N	zacemaza14814255@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:36.608714+00	2026-07-08 19:28:36.608714+00	\N	Ecuatoriana	\N	\N	\N	\N	f
40	0964958789	\N	MATEO ZABDIEL	ZAMBRANO CEDEÑO	\N	\N	\N	\N	\N	zapadoad14801398@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:37.476156+00	2026-07-08 19:28:37.476156+00	\N	Ecuatoriana	\N	\N	\N	\N	f
41	0964961890	\N	DORIAN ADRIAN	ZAMBRANO PARRAGA	\N	\N	\N	\N	\N	zadeaxez14813578@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:38.999427+00	2026-07-08 19:28:38.999427+00	\N	Ecuatoriana	\N	\N	\N	\N	f
42	0965130974	\N	AXEL EZEQUIEL	ZAMORA DELGADO	\N	\N	\N	\N	\N		f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:40.548938+00	2026-07-08 19:28:40.548938+00	\N	Ecuatoriana	\N	\N	\N	\N	f
6	1353490590	\N	DAVID SANTIAGO	ALCIVAR INTRIAGO	2002-05-08	M	av quevedo - las tecas	0983621086	\N	alindasa14810863@estudiantes3.edu.ec	f		\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:28:06.986931+00	2026-07-08 19:31:40.314389+00		Ecuatoriana	Mestizo/a	El empalme	Solo Madre	0	t
43	0963708177	\N	ANGELA MARIA	CARRASCO CATAGUA	\N	\N	\N	\N	\N	cacaanma14051224@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:35.485223+00	2026-07-08 19:44:35.485223+00	\N	Ecuatoriana	\N	\N	\N	\N	f
44	0964049381	\N	LIAM JOSE	CARREÑO CRUZATTY	\N	\N	\N	\N	\N	cacrlijo14046724@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:35.899203+00	2026-07-08 19:44:35.899203+00	\N	Ecuatoriana	\N	\N	\N	\N	f
45	1353286261	\N	JOSHUA DAYAN	CATAGUA MOREIRA	\N	\N	\N	\N	\N	camojoda13950290@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:36.784729+00	2026-07-08 19:44:36.784729+00	\N	Ecuatoriana	\N	\N	\N	\N	f
46	0964200190	\N	ULBIO JUNIOR	CONFORME GANCHOZO	\N	\N	\N	\N	\N	cogaulju14043634@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:37.890604+00	2026-07-08 19:44:37.890604+00	\N	Ecuatoriana	\N	\N	\N	\N	f
47	0963913470	\N	ERICKA ZHARICK	CRUZATTI SANCHEZ	\N	\N	\N	\N	\N	crsaerzh16176913@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:38.729942+00	2026-07-08 19:44:38.729942+00	\N	Ecuatoriana	\N	\N	\N	\N	f
48	0963848882	\N	JESSICA SAMHARA	DELVALLE VERA	\N	\N	\N	\N	\N	devejesa14044754@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:39.528351+00	2026-07-08 19:44:39.528351+00	\N	Ecuatoriana	\N	\N	\N	\N	f
49	1353360009	\N	MAYEXY ESPERANZA	ESPINALES MENDOZA	\N	\N	\N	\N	\N	esmemaes13930738@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:40.47035+00	2026-07-08 19:44:40.47035+00	\N	Ecuatoriana	\N	\N	\N	\N	f
50	0964145767	\N	ANGELO NARCISO	ESPINALES RODRIGUEZ	\N	\N	\N	\N	\N	esroanna14108938@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:41.391459+00	2026-07-08 19:44:41.391459+00	\N	Ecuatoriana	\N	\N	\N	\N	f
51	0963913520	\N	EDUARDO JOEL	GARCIA MERO	\N	\N	\N	\N	\N	gameedjo15474303@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:42.73723+00	2026-07-08 19:44:42.73723+00	\N	Ecuatoriana	\N	\N	\N	\N	f
52	0963729678	\N	JULITZA SCARLETH	GARCIA RODRIGUEZ	\N	\N	\N	\N	\N	garojusc15475604@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:44.259781+00	2026-07-08 19:44:44.259781+00	\N	Ecuatoriana	\N	\N	\N	\N	f
53	1252409808	\N	JULIETH KATHERINE	GARCIA SALTOS	\N	\N	\N	\N	\N	gasajuka14038171@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:46.05632+00	2026-07-08 19:44:46.05632+00	\N	Ecuatoriana	\N	\N	\N	\N	f
54	0963695507	\N	ANGELICA MARIED	HOLGUIN CEDEÑO	\N	\N	\N	\N	\N	hoceanma13950326@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:47.710663+00	2026-07-08 19:44:47.710663+00	\N	Ecuatoriana	\N	\N	\N	\N	f
55	0964236608	\N	ANGEL SEBASTIAN	JAMA MOREIRA	\N	\N	\N	\N	\N	jamoanse14442688@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:48.082146+00	2026-07-08 19:44:48.082146+00	\N	Ecuatoriana	\N	\N	\N	\N	f
56	0963852033	\N	ANDRY JOAN	LUCAS SANTANA	\N	\N	\N	\N	\N	lusaanjo14070020@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:48.459643+00	2026-07-08 19:44:48.459643+00	\N	Ecuatoriana	\N	\N	\N	\N	f
57	0963964804	\N	CRISTOPHER JAVIER	MENDOZA MARCILLO	\N	\N	\N	\N	\N	memacrja14138959@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:48.8345+00	2026-07-08 19:44:48.8345+00	\N	Ecuatoriana	\N	\N	\N	\N	f
58	1353434994	\N	MARYS ALEJANDRA	MORALES RODRIGUEZ	\N	\N	\N	\N	\N	moromaal14728114@estudiantes2.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:49.207058+00	2026-07-08 19:44:49.207058+00	\N	Ecuatoriana	\N	\N	\N	\N	f
59	1353396870	\N	JOSUA AGUSTIN	MOREIRA CATAGUA	\N	\N	\N	\N	\N	mocajoag14442361@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:49.571433+00	2026-07-08 19:44:49.571433+00	\N	Ecuatoriana	\N	\N	\N	\N	f
60	0964034888	\N	MARIA VALENTINA	MOSQUERA RODRIGUEZ	\N	\N	\N	\N	\N	moromava14814633@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:49.934797+00	2026-07-08 19:44:49.934797+00	\N	Ecuatoriana	\N	\N	\N	\N	f
61	0963977046	\N	ELIANYS MIRELYS	MUÑOZ VASQUEZ	\N	\N	\N	\N	\N	muvaelmi13929890@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:50.786455+00	2026-07-08 19:44:50.786455+00	\N	Ecuatoriana	\N	\N	\N	\N	f
62	0964060842	\N	ROMINA ISABELLA	ORMAZA MANTUANO	\N	\N	\N	\N	\N	ormarois14068337@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:51.837992+00	2026-07-08 19:44:51.837992+00	\N	Ecuatoriana	\N	\N	\N	\N	f
63	1252316474	\N	KARLEY ELIZABETH	PALACIOS OLMEDO	\N	\N	\N	\N	\N	paolkael14056304@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:52.444701+00	2026-07-08 19:44:52.444701+00	\N	Ecuatoriana	\N	\N	\N	\N	f
64	0964263909	\N	GUADALUPE RAQUEL	QUIROZ SANCHEZ	\N	\N	\N	\N	\N	qusagura14885033@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:53.738655+00	2026-07-08 19:44:53.738655+00	\N	Ecuatoriana	\N	\N	\N	\N	f
65	1252197254	\N	EILEEN ANGELINA	REYES CARDENAS	\N	\N	\N	\N	\N	recaeian15477210@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:55.669711+00	2026-07-08 19:44:55.669711+00	\N	Ecuatoriana	\N	\N	\N	\N	f
66	1353431313	\N	JEREMY SEBASTIAN	RIVAS INTRIAGO	\N	\N	\N	\N	\N	riinjese15698068@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:57.337411+00	2026-07-08 19:44:57.337411+00	\N	Ecuatoriana	\N	\N	\N	\N	f
67	0964253751	\N	ANTHONY RUBEN	RODRIGUEZ LUCAS	\N	\N	\N	\N	\N	roluanru14882055@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:58.746736+00	2026-07-08 19:44:58.746736+00	\N	Ecuatoriana	\N	\N	\N	\N	f
68	0963898002	\N	ALICE VICTORIA	RODRIGUEZ POSLIGUA	\N	\N	\N	\N	\N	ropoalvi15427591@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:59.112173+00	2026-07-08 19:44:59.112173+00	\N	Ecuatoriana	\N	\N	\N	\N	f
69	1353283334	\N	FERNANDO JHOEL	RODRIGUEZ RODRIGUEZ	\N	\N	\N	\N	\N	rorofejh15046634@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:59.476239+00	2026-07-08 19:44:59.476239+00	\N	Ecuatoriana	\N	\N	\N	\N	f
70	0963485479	\N	ERICK GAEL	ROSADO HOLGUIN	\N	\N	\N	\N	\N	rohoerga14913296@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:44:59.843181+00	2026-07-08 19:44:59.843181+00	\N	Ecuatoriana	\N	\N	\N	\N	f
71	0963955851	\N	MELANY AYLIN	SACON SUAREZ	\N	\N	\N	\N	\N	sasumeay13950256@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:00.275065+00	2026-07-08 19:45:00.275065+00	\N	Ecuatoriana	\N	\N	\N	\N	f
72	1353424631	\N	AMAIA HAILY	SOLORZANO DELGADO	\N	\N	\N	\N	\N	sodeamha14442501@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:01.279852+00	2026-07-08 19:45:01.279852+00	\N	Ecuatoriana	\N	\N	\N	\N	f
73	0963939582	\N	LIAN ALEJANDRO	SOLORZANO GARCIA	\N	\N	\N	\N	\N	sogalial14037402@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:02.078064+00	2026-07-08 19:45:02.078064+00	\N	Ecuatoriana	\N	\N	\N	\N	f
74	0964207435	\N	LUCAS JHULIAN	TAPIA MENDOZA	\N	\N	\N	\N	\N	tamelujh14073932@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:02.760296+00	2026-07-08 19:45:02.760296+00	\N	Ecuatoriana	\N	\N	\N	\N	f
75	0964447999	\N	ARIANA MAILEN	TORRES HOLGUIN	\N	\N	\N	\N	\N	tohoarma14445623@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:03.82214+00	2026-07-08 19:45:03.82214+00	\N	Ecuatoriana	\N	\N	\N	\N	f
76	0964214597	\N	JEFFERSON ALEXANDER	VASQUEZ RISCO	\N	\N	\N	\N	\N	varijeal13930895@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:04.732534+00	2026-07-08 19:45:04.732534+00	\N	Ecuatoriana	\N	\N	\N	\N	f
77	0964139695	\N	DYLAN JESUS	VELASQUEZ CASTRO	\N	\N	\N	\N	\N	vecadyje14884961@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:05.562063+00	2026-07-08 19:45:05.562063+00	\N	Ecuatoriana	\N	\N	\N	\N	f
78	0964436323	\N	OHANA MONSERRATE	VELEZ MENDOZA	\N	\N	\N	\N	\N	venamavi14442452@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:06.35289+00	2026-07-08 19:45:06.35289+00	\N	Ecuatoriana	\N	\N	\N	\N	f
79	0964251946	\N	MARIA VICTORIA	VELEZ NAVARRETE	\N	\N	\N	\N	\N	vevemaja13938981@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:07.73397+00	2026-07-08 19:45:07.73397+00	\N	Ecuatoriana	\N	\N	\N	\N	f
80	0963988563	\N	MATHIUS JACOP	VERA VERA	\N	\N	\N	\N	\N	zamalima13964790@estudiantes3.edu.ec	f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:09.267843+00	2026-07-08 19:45:09.267843+00	\N	Ecuatoriana	\N	\N	\N	\N	f
81	0964212567	\N	LIAH MAYTE	ZAMORA MACIAS	\N	\N	\N	\N	\N		f	\N	\N	\N	CAS	ACTIVA	\N	\N	2026-07-08 19:45:11.066766+00	2026-07-08 19:45:11.066766+00	\N	Ecuatoriana	\N	\N	\N	\N	f
1	1654181385	\N	Ana María	González Reyes	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	ACTIVO	\N	1	2026-06-02 04:03:28.015797+00	2026-06-02 04:03:28.015797+00	\N	\N	\N	\N	\N	\N	f
82	0103321378	PRB-3-1	Mateo	Vera Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
83	0545190704	PRB-3-2	Valentina	Intriago Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
84	0504884560	PRB-3-3	Santiago	García Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
85	1341536413	PRB-3-4	Camila	Macías Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
86	1720392214	PRB-3-5	Sebastián	Delgado García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
87	1204040768	PRB-3-6	Isabella	Chávez Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
88	1211472772	PRB-3-7	Nicolás	Bravo Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
89	1835437250	PRB-3-8	Emma	Pincay Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
90	0948823406	PRB-3-9	Benjamín	Solórzano Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
91	1426436992	PRB-3-10	Sofía	Parrales Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
92	0447537820	PRB-3-11	Martín	Andrade Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
93	0448549469	PRB-3-12	Luciana	Moreira Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
94	1508160353	PRB-3-13	Emiliano	Rodríguez Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
95	0324681782	PRB-3-14	Renata	Alcívar Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
96	1510345604	PRB-3-15	Thiago	Cabrera Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
97	0424766368	PRB-3-16	Antonella	Ponce Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
98	2441363120	PRB-3-17	Dylan	Zambrano Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
99	0501898985	PRB-3-18	Mía	Mendoza Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
100	1246156358	PRB-3-19	Gael	Cedeño Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
101	2429217215	PRB-3-20	Julieta	Loor Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
102	1001313079	PRB-4-1	Mateo	Intriago Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
103	1357233228	PRB-4-2	Valentina	García Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
104	0629497306	PRB-4-3	Santiago	Macías Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
105	1724037799	PRB-4-4	Camila	Delgado Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
106	0719931602	PRB-4-5	Sebastián	Chávez García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
107	1347820209	PRB-4-6	Isabella	Bravo Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
108	1442845283	PRB-4-7	Nicolás	Pincay Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
109	0430727255	PRB-4-8	Emma	Solórzano Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
110	1223296698	PRB-4-9	Benjamín	Parrales Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
111	0816356265	PRB-4-10	Sofía	Andrade Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
112	1055089286	PRB-4-11	Martín	Moreira Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
113	0116174434	PRB-4-12	Luciana	Rodríguez Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
114	0159460385	PRB-4-13	Emiliano	Alcívar Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
115	1243039987	PRB-4-14	Renata	Cabrera Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
116	1051887360	PRB-4-15	Thiago	Ponce Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
117	2259771919	PRB-4-16	Antonella	Zambrano Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
118	1512751379	PRB-4-17	Dylan	Mendoza Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
119	0256086737	PRB-4-18	Mía	Cedeño Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
120	0459690632	PRB-4-19	Gael	Loor Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
121	1044356127	PRB-4-20	Julieta	Vera Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
122	0519192785	PRB-5-1	Mateo	García Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
123	2252270794	PRB-5-2	Valentina	Macías Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
124	1034950871	PRB-5-3	Santiago	Delgado Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
125	0806665808	PRB-5-4	Camila	Chávez García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
126	2042276242	PRB-5-5	Sebastián	Bravo Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
127	0757409081	PRB-5-6	Isabella	Pincay Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
128	2216310470	PRB-5-7	Nicolás	Solórzano Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
129	0803949965	PRB-5-8	Emma	Parrales Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
130	0619500184	PRB-5-9	Benjamín	Andrade Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
131	0835259896	PRB-5-10	Sofía	Moreira Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
132	2138647959	PRB-5-11	Martín	Rodríguez Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
133	1156072207	PRB-5-12	Luciana	Alcívar Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
134	2130071083	PRB-5-13	Emiliano	Cabrera Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
135	1557568928	PRB-5-14	Renata	Ponce Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
136	0927783878	PRB-5-15	Thiago	Zambrano Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
137	1041524651	PRB-5-16	Antonella	Mendoza Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
138	1206914192	PRB-5-17	Dylan	Cedeño Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
139	1003756853	PRB-5-18	Mía	Loor Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
140	1023438441	PRB-5-19	Gael	Vera Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
141	2027362025	PRB-5-20	Julieta	Intriago Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
142	1824130478	PRB-6-1	Mateo	Macías Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
143	2401584731	PRB-6-2	Valentina	Delgado Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
144	0327485223	PRB-6-3	Santiago	Chávez Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
145	1331640985	PRB-6-4	Camila	Bravo García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
146	0753708536	PRB-6-5	Sebastián	Pincay Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
147	0425227790	PRB-6-6	Isabella	Solórzano Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
148	1438514182	PRB-6-7	Nicolás	Parrales Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
149	2450358920	PRB-6-8	Emma	Andrade Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
150	0213141328	PRB-6-9	Benjamín	Moreira Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
151	1255420638	PRB-6-10	Sofía	Rodríguez Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
152	2405071156	PRB-6-11	Martín	Alcívar Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
153	0239849607	PRB-6-12	Luciana	Cabrera Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
154	1525041644	PRB-6-13	Emiliano	Ponce Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
155	1657586606	PRB-6-14	Renata	Zambrano Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
156	0320897184	PRB-6-15	Thiago	Mendoza Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
157	0506556737	PRB-6-16	Antonella	Cedeño Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
158	1459375166	PRB-6-17	Dylan	Loor Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
159	1704230315	PRB-6-18	Mía	Vera Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
160	1657359483	PRB-6-19	Gael	Intriago Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
161	1607595152	PRB-6-20	Julieta	García Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
162	1749203699	PRB-7-1	Mateo	Delgado Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
163	2027906995	PRB-7-2	Valentina	Chávez Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
164	2326217979	PRB-7-3	Santiago	Bravo García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
165	1654997863	PRB-7-4	Camila	Pincay Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
166	2149959773	PRB-7-5	Sebastián	Solórzano Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
167	1416144291	PRB-7-6	Isabella	Parrales Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
168	2148749266	PRB-7-7	Nicolás	Andrade Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
169	0104422688	PRB-7-8	Emma	Moreira Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
170	1758967903	PRB-7-9	Benjamín	Rodríguez Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
171	1011621289	PRB-7-10	Sofía	Alcívar Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
172	0520029778	PRB-7-11	Martín	Cabrera Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
173	1056102500	PRB-7-12	Luciana	Ponce Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
174	2258229422	PRB-7-13	Emiliano	Zambrano Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
175	1946746318	PRB-7-14	Renata	Mendoza Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
176	1642042749	PRB-7-15	Thiago	Cedeño Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
177	0809798630	PRB-7-16	Antonella	Loor Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
178	1107385039	PRB-7-17	Dylan	Vera Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
179	1836227486	PRB-7-18	Mía	Intriago Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
180	0622867661	PRB-7-19	Gael	García Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
181	0733634901	PRB-7-20	Julieta	Macías Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
182	2133128815	PRB-8-1	Mateo	Chávez Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
183	2124487980	PRB-8-2	Valentina	Bravo Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
184	1151593546	PRB-8-3	Santiago	Pincay García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
185	2301417669	PRB-8-4	Camila	Solórzano Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
186	2435168345	PRB-8-5	Sebastián	Parrales Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
187	0758630792	PRB-8-6	Isabella	Andrade Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
188	0518336896	PRB-8-7	Nicolás	Moreira Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
189	0201396983	PRB-8-8	Emma	Rodríguez Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
190	0850437518	PRB-8-9	Benjamín	Alcívar Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
191	2126558101	PRB-8-10	Sofía	Cabrera Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
192	0541793881	PRB-8-11	Martín	Ponce Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
193	1425663661	PRB-8-12	Luciana	Zambrano Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
194	1103505010	PRB-8-13	Emiliano	Mendoza Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
195	1155094723	PRB-8-14	Renata	Cedeño Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
196	1319249114	PRB-8-15	Thiago	Loor Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
197	2253354191	PRB-8-16	Antonella	Vera Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
198	1331348498	PRB-8-17	Dylan	Intriago Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
199	1649159173	PRB-8-18	Mía	García Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
200	1231394774	PRB-8-19	Gael	Macías Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
201	0435185822	PRB-8-20	Julieta	Delgado Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
202	1618127383	PRB-9-1	Mateo	Bravo Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
203	0748124112	PRB-9-2	Valentina	Pincay García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
204	1830199004	PRB-9-3	Santiago	Solórzano Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
205	1226977633	PRB-9-4	Camila	Parrales Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
206	1415277480	PRB-9-5	Sebastián	Andrade Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
207	1312363151	PRB-9-6	Isabella	Moreira Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
208	2305314086	PRB-9-7	Nicolás	Rodríguez Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
209	0204633291	PRB-9-8	Emma	Alcívar Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
210	0147317978	PRB-9-9	Benjamín	Cabrera Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
211	1027586146	PRB-9-10	Sofía	Ponce Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
212	0537751547	PRB-9-11	Martín	Zambrano Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
213	0321479834	PRB-9-12	Luciana	Mendoza Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
214	0137270930	PRB-9-13	Emiliano	Cedeño Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
215	1928607702	PRB-9-14	Renata	Loor Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
216	1108659507	PRB-9-15	Thiago	Vera Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
217	0644359465	PRB-9-16	Antonella	Intriago Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
218	2439519139	PRB-9-17	Dylan	García Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
219	0109744771	PRB-9-18	Mía	Macías Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
220	0931196885	PRB-9-19	Gael	Delgado Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
221	0441074838	PRB-9-20	Julieta	Chávez Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
222	2208089512	PRB-10-1	Mateo	Pincay Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
223	1517180889	PRB-10-2	Valentina	Solórzano García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
224	0256271065	PRB-10-3	Santiago	Parrales Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
225	0528694904	PRB-10-4	Camila	Andrade Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
226	0955390307	PRB-10-5	Sebastián	Moreira Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
227	0420106148	PRB-10-6	Isabella	Rodríguez Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
228	0552071086	PRB-10-7	Nicolás	Alcívar Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
229	2053150864	PRB-10-8	Emma	Cabrera Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
230	1305288456	PRB-10-9	Benjamín	Ponce Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
231	0237173851	PRB-10-10	Sofía	Zambrano Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
232	1312152513	PRB-10-11	Martín	Mendoza Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
233	0628900318	PRB-10-12	Luciana	Cedeño Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
234	0414005488	PRB-10-13	Emiliano	Loor Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
235	1247092735	PRB-10-14	Renata	Vera Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
236	1227164249	PRB-10-15	Thiago	Intriago Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
237	1647795325	PRB-10-16	Antonella	García Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
238	1453821306	PRB-10-17	Dylan	Macías Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
239	0140157967	PRB-10-18	Mía	Delgado Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
240	2212376780	PRB-10-19	Gael	Chávez Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
241	0911342681	PRB-10-20	Julieta	Bravo Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
242	1159121365	PRB-11-1	Mateo	Solórzano García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
243	1233879962	PRB-11-2	Valentina	Parrales Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
244	0212257315	PRB-11-3	Santiago	Andrade Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
245	1208157220	PRB-11-4	Camila	Moreira Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
246	1530800463	PRB-11-5	Sebastián	Rodríguez Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
247	1908343575	PRB-11-6	Isabella	Alcívar Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
248	1535872715	PRB-11-7	Nicolás	Cabrera Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
249	1112397771	PRB-11-8	Emma	Ponce Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
250	1700459710	PRB-11-9	Benjamín	Zambrano Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
251	1403941311	PRB-11-10	Sofía	Mendoza Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
252	0348750647	PRB-11-11	Martín	Cedeño Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
253	0251952297	PRB-11-12	Luciana	Loor Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
254	1508279310	PRB-11-13	Emiliano	Vera Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
255	1742431073	PRB-11-14	Renata	Intriago Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
256	1037510896	PRB-11-15	Thiago	García Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
257	0712180066	PRB-11-16	Antonella	Macías Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
258	0439196635	PRB-11-17	Dylan	Delgado Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
259	1607772967	PRB-11-18	Mía	Chávez Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
260	1426427801	PRB-11-19	Gael	Bravo Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
261	1215935436	PRB-11-20	Julieta	Pincay Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
262	2102734528	PRB-12-1	Mateo	Parrales García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
263	0709288740	PRB-12-2	Valentina	Andrade Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
264	0405084435	PRB-12-3	Santiago	Moreira Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
265	0626654313	PRB-12-4	Camila	Rodríguez Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
266	1940236936	PRB-12-5	Sebastián	Alcívar Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
267	0206129637	PRB-12-6	Isabella	Cabrera Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
268	2419454885	PRB-12-7	Nicolás	Ponce Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
269	2247829225	PRB-12-8	Emma	Zambrano Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
270	0629099789	PRB-12-9	Benjamín	Mendoza Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
271	0608891040	PRB-12-10	Sofía	Cedeño Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
272	0146200654	PRB-12-11	Martín	Loor Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
273	0721442556	PRB-12-12	Luciana	Vera Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
274	0505583369	PRB-12-13	Emiliano	Intriago Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
275	2309021752	PRB-12-14	Renata	García Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
276	1600064313	PRB-12-15	Thiago	Macías Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
277	1718794421	PRB-12-16	Antonella	Delgado Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
278	1524674171	PRB-12-17	Dylan	Chávez Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
279	1657601058	PRB-12-18	Mía	Bravo Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
280	2000606026	PRB-12-19	Gael	Pincay Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
281	0548965185	PRB-12-20	Julieta	Solórzano Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
282	0749797593	PRB-13-1	Mateo	Andrade Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
283	0411485089	PRB-13-2	Valentina	Moreira Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
284	2449486535	PRB-13-3	Santiago	Rodríguez Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
285	2015843770	PRB-13-4	Camila	Alcívar Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
286	0637480955	PRB-13-5	Sebastián	Cabrera Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
287	1502162652	PRB-13-6	Isabella	Ponce Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
288	2404533750	PRB-13-7	Nicolás	Zambrano Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
289	0632110045	PRB-13-8	Emma	Mendoza Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
290	1136697511	PRB-13-9	Benjamín	Cedeño Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
291	1324686912	PRB-13-10	Sofía	Loor Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
292	1743118323	PRB-13-11	Martín	Vera Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
293	0501123384	PRB-13-12	Luciana	Intriago Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
294	2054834508	PRB-13-13	Emiliano	García Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
295	0937751634	PRB-13-14	Renata	Macías Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
296	1102014824	PRB-13-15	Thiago	Delgado Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
297	1452223637	PRB-13-16	Antonella	Chávez Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
298	0428937825	PRB-13-17	Dylan	Bravo Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
299	0443203740	PRB-13-18	Mía	Pincay Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
300	1521841971	PRB-13-19	Gael	Solórzano Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
301	1853204202	PRB-13-20	Julieta	Parrales García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
302	0254740889	PRB-14-1	Mateo	Moreira Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
303	0913844890	PRB-14-2	Valentina	Rodríguez Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
304	1021413222	PRB-14-3	Santiago	Alcívar Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
305	0138476544	PRB-14-4	Camila	Cabrera Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
306	0311403067	PRB-14-5	Sebastián	Ponce Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
307	1908791401	PRB-14-6	Isabella	Zambrano Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
308	2000273447	PRB-14-7	Nicolás	Mendoza Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
309	0128042074	PRB-14-8	Emma	Cedeño Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
310	0444916837	PRB-14-9	Benjamín	Loor Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
311	2205044353	PRB-14-10	Sofía	Vera Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
312	0903629277	PRB-14-11	Martín	Intriago Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
313	1843969898	PRB-14-12	Luciana	García Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
314	1332849122	PRB-14-13	Emiliano	Macías Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
315	2310470717	PRB-14-14	Renata	Delgado Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
316	1827894278	PRB-14-15	Thiago	Chávez Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
317	1809134875	PRB-14-16	Antonella	Bravo Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
318	1225350790	PRB-14-17	Dylan	Pincay Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
319	2220251793	PRB-14-18	Mía	Solórzano Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
320	0859973067	PRB-14-19	Gael	Parrales Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
321	1122815317	PRB-14-20	Julieta	Andrade García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
322	0126205525	PRB-15-1	Mateo	Rodríguez Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
323	1753688082	PRB-15-2	Valentina	Alcívar Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
324	1757602980	PRB-15-3	Santiago	Cabrera Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
325	0905596383	PRB-15-4	Camila	Ponce Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
326	0123670333	PRB-15-5	Sebastián	Zambrano Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
327	0238449508	PRB-15-6	Isabella	Mendoza Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
328	1206393876	PRB-15-7	Nicolás	Cedeño Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
329	1619281254	PRB-15-8	Emma	Loor Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
330	0925803298	PRB-15-9	Benjamín	Vera Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
331	0918215500	PRB-15-10	Sofía	Intriago Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
332	0328948203	PRB-15-11	Martín	García Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
333	0451067912	PRB-15-12	Luciana	Macías Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
334	1810066140	PRB-15-13	Emiliano	Delgado Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
335	0334102118	PRB-15-14	Renata	Chávez Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
336	2415914098	PRB-15-15	Thiago	Bravo Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
337	0621246891	PRB-15-16	Antonella	Pincay Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
338	2239198308	PRB-15-17	Dylan	Solórzano Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
339	1251837090	PRB-15-18	Mía	Parrales Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
340	1329498222	PRB-15-19	Gael	Andrade García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
341	1525921712	PRB-15-20	Julieta	Moreira Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
342	1837106572	PRB-16-1	Mateo	Alcívar Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
343	0945236545	PRB-16-2	Valentina	Cabrera Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
344	1527087041	PRB-16-3	Santiago	Ponce Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
345	1816722662	PRB-16-4	Camila	Zambrano Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
346	0706514817	PRB-16-5	Sebastián	Mendoza Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
347	0250166287	PRB-16-6	Isabella	Cedeño Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
348	1407239878	PRB-16-7	Nicolás	Loor Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
349	1606309027	PRB-16-8	Emma	Vera Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
350	0631232402	PRB-16-9	Benjamín	Intriago Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
351	1422492932	PRB-16-10	Sofía	García Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
352	1152743256	PRB-16-11	Martín	Macías Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
353	0959133075	PRB-16-12	Luciana	Delgado Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
354	0902480128	PRB-16-13	Emiliano	Chávez Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
355	0206478794	PRB-16-14	Renata	Bravo Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
356	0552229411	PRB-16-15	Thiago	Pincay Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
357	1223987551	PRB-16-16	Antonella	Solórzano Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
358	2342211170	PRB-16-17	Dylan	Parrales Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
359	2229312646	PRB-16-18	Mía	Andrade Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
360	1203251358	PRB-16-19	Gael	Moreira García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
361	1425296322	PRB-16-20	Julieta	Rodríguez Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
362	0924467970	PRB-27-1	Mateo	Delgado Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
363	0230720419	PRB-27-2	Valentina	Chávez Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
364	0100107119	PRB-27-3	Santiago	Bravo Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
365	1530924362	PRB-27-4	Camila	Pincay Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
366	1531252870	PRB-27-5	Sebastián	Solórzano Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
367	0208241182	PRB-27-6	Isabella	Parrales Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
368	1601679622	PRB-27-7	Nicolás	Andrade Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
369	1428542839	PRB-27-8	Emma	Moreira Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
370	0925087322	PRB-27-9	Benjamín	Rodríguez Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
371	2146888934	PRB-27-10	Sofía	Alcívar Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
372	1942068238	PRB-27-11	Martín	Cabrera Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
373	0842704512	PRB-27-12	Luciana	Ponce Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
374	1817807330	PRB-27-13	Emiliano	Zambrano Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
375	2446031326	PRB-27-14	Renata	Mendoza Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
376	0454604463	PRB-27-15	Thiago	Cedeño Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
377	0539523936	PRB-27-16	Antonella	Loor Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
378	1647332251	PRB-27-17	Dylan	Vera Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
379	0128189743	PRB-27-18	Mía	Intriago Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
380	1250052113	PRB-27-19	Gael	García García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
381	1209365814	PRB-27-20	Julieta	Macías Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
382	0815196225	PRB-17-1	Mateo	Cabrera Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
383	1030111338	PRB-17-2	Valentina	Ponce Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
384	0334693561	PRB-17-3	Santiago	Zambrano Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
385	0304387152	PRB-17-4	Camila	Mendoza Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
386	1710768787	PRB-17-5	Sebastián	Cedeño Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
387	0412803793	PRB-17-6	Isabella	Loor Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
388	0111826848	PRB-17-7	Nicolás	Vera Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
389	0838698462	PRB-17-8	Emma	Intriago Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
390	1221581190	PRB-17-9	Benjamín	García Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
391	0609695275	PRB-17-10	Sofía	Macías Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
392	1755166061	PRB-17-11	Martín	Delgado Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
393	1256875087	PRB-17-12	Luciana	Chávez Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
394	0858088156	PRB-17-13	Emiliano	Bravo Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
395	1332591310	PRB-17-14	Renata	Pincay Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
396	1145339881	PRB-17-15	Thiago	Solórzano Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
397	0718766280	PRB-17-16	Antonella	Parrales Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
398	0243109568	PRB-17-17	Dylan	Andrade Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
399	2157171246	PRB-17-18	Mía	Moreira García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
400	1412536029	PRB-17-19	Gael	Rodríguez Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
401	0540451549	PRB-17-20	Julieta	Alcívar Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
402	1745972008	PRB-18-1	Mateo	Ponce Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
403	0845882216	PRB-18-2	Valentina	Zambrano Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
404	2004531881	PRB-18-3	Santiago	Mendoza Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
405	2339219004	PRB-18-4	Camila	Cedeño Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
406	0925728800	PRB-18-5	Sebastián	Loor Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
407	1744139567	PRB-18-6	Isabella	Vera Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
408	1146858012	PRB-18-7	Nicolás	Intriago Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
409	1520408814	PRB-18-8	Emma	García Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
410	1909883009	PRB-18-9	Benjamín	Macías Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
411	0134083559	PRB-18-10	Sofía	Delgado Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
412	2311008417	PRB-18-11	Martín	Chávez Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
413	1651252965	PRB-18-12	Luciana	Bravo Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
414	1859945709	PRB-18-13	Emiliano	Pincay Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
415	0700750045	PRB-18-14	Renata	Solórzano Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
416	0753188622	PRB-18-15	Thiago	Parrales Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
417	0622192797	PRB-18-16	Antonella	Andrade Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
418	2315020756	PRB-18-17	Dylan	Moreira Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
419	1212844185	PRB-18-18	Mía	Rodríguez García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
420	2059412912	PRB-18-19	Gael	Alcívar Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
421	2243566037	PRB-18-20	Julieta	Cabrera Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
422	0329247720	PRB-28-1	Mateo	Chávez Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
423	1814894885	PRB-28-2	Valentina	Bravo Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
424	1221243049	PRB-28-3	Santiago	Pincay Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
425	0938164407	PRB-28-4	Camila	Solórzano Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
426	2219400872	PRB-28-5	Sebastián	Parrales Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
427	1133836559	PRB-28-6	Isabella	Andrade Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
428	1332908134	PRB-28-7	Nicolás	Moreira Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
429	0243255163	PRB-28-8	Emma	Rodríguez Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
430	0415622620	PRB-28-9	Benjamín	Alcívar Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
431	2207717782	PRB-28-10	Sofía	Cabrera Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
432	0822773537	PRB-28-11	Martín	Ponce Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
433	2018843439	PRB-28-12	Luciana	Zambrano Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
434	1031616459	PRB-28-13	Emiliano	Mendoza Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
435	2342328651	PRB-28-14	Renata	Cedeño Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
436	1049250960	PRB-28-15	Thiago	Loor Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
437	2238744029	PRB-28-16	Antonella	Vera Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
438	0105718209	PRB-28-17	Dylan	Intriago Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
439	1205664681	PRB-28-18	Mía	García García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
440	0802294876	PRB-28-19	Gael	Macías Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
441	0105602056	PRB-28-20	Julieta	Delgado Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
442	1545406132	PRB-19-1	Mateo	Zambrano Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
443	0103409884	PRB-19-2	Valentina	Mendoza Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
444	1123841817	PRB-19-3	Santiago	Cedeño Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
445	1620798569	PRB-19-4	Camila	Loor Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
446	2048646430	PRB-19-5	Sebastián	Vera Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
447	2205538420	PRB-19-6	Isabella	Intriago Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
448	1231089440	PRB-19-7	Nicolás	García Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
449	1801602895	PRB-19-8	Emma	Macías Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
450	0805545308	PRB-19-9	Benjamín	Delgado Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
451	1939886279	PRB-19-10	Sofía	Chávez Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
452	1620750180	PRB-19-11	Martín	Bravo Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
453	1329020885	PRB-19-12	Luciana	Pincay Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
454	1953850623	PRB-19-13	Emiliano	Solórzano Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
455	1902008836	PRB-19-14	Renata	Parrales Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
456	1822447361	PRB-19-15	Thiago	Andrade Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
457	1027620655	PRB-19-16	Antonella	Moreira Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
458	1929003075	PRB-19-17	Dylan	Rodríguez García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
459	1611520733	PRB-19-18	Mía	Alcívar Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
460	0451320170	PRB-19-19	Gael	Cabrera Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
461	1529560466	PRB-19-20	Julieta	Ponce Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
462	2126808860	PRB-20-1	Mateo	Mendoza Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
463	2432540090	PRB-20-2	Valentina	Cedeño Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
464	0700089915	PRB-20-3	Santiago	Loor Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
465	0741710479	PRB-20-4	Camila	Vera Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
466	0520870445	PRB-20-5	Sebastián	Intriago Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
467	1422837755	PRB-20-6	Isabella	García Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
468	0124757618	PRB-20-7	Nicolás	Macías Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
469	0102721511	PRB-20-8	Emma	Delgado Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
470	1422677268	PRB-20-9	Benjamín	Chávez Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
471	0951418276	PRB-20-10	Sofía	Bravo Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
472	1544936113	PRB-20-11	Martín	Pincay Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
473	0645450115	PRB-20-12	Luciana	Solórzano Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
474	1926118629	PRB-20-13	Emiliano	Parrales Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
475	0543015648	PRB-20-14	Renata	Andrade Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
476	1052579503	PRB-20-15	Thiago	Moreira Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
477	0638099101	PRB-20-16	Antonella	Rodríguez Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
478	1101917324	PRB-20-17	Dylan	Alcívar García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
479	1058758267	PRB-20-18	Mía	Cabrera Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
480	2414378659	PRB-20-19	Gael	Ponce Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
481	0441443934	PRB-20-20	Julieta	Zambrano Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
482	0337627319	PRB-29-1	Mateo	Bravo Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
483	0800313595	PRB-29-2	Valentina	Pincay Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
484	1511922328	PRB-29-3	Santiago	Solórzano Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
485	1823127665	PRB-29-4	Camila	Parrales Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
486	0704082171	PRB-29-5	Sebastián	Andrade Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
487	1402669921	PRB-29-6	Isabella	Moreira Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
488	1440127288	PRB-29-7	Nicolás	Rodríguez Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
489	2310146507	PRB-29-8	Emma	Alcívar Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
490	0308260843	PRB-29-9	Benjamín	Cabrera Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
491	1646481497	PRB-29-10	Sofía	Ponce Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
492	1414717064	PRB-29-11	Martín	Zambrano Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
493	1711517324	PRB-29-12	Luciana	Mendoza Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
494	2415358783	PRB-29-13	Emiliano	Cedeño Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
495	1231232362	PRB-29-14	Renata	Loor Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
496	1954436828	PRB-29-15	Thiago	Vera Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
497	2113444083	PRB-29-16	Antonella	Intriago Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
498	1302261498	PRB-29-17	Dylan	García García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
499	2020895955	PRB-29-18	Mía	Macías Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
500	1255007807	PRB-29-19	Gael	Delgado Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
501	0456729524	PRB-29-20	Julieta	Chávez Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
502	0715782934	PRB-21-1	Mateo	Cedeño Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
503	1934656552	PRB-21-2	Valentina	Loor Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
504	0640717583	PRB-21-3	Santiago	Vera Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
505	0908974314	PRB-21-4	Camila	Intriago Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
506	0914080098	PRB-21-5	Sebastián	García Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
507	0923426324	PRB-21-6	Isabella	Macías Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
508	0716637004	PRB-21-7	Nicolás	Delgado Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
509	1319331813	PRB-21-8	Emma	Chávez Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
510	0240638908	PRB-21-9	Benjamín	Bravo Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
511	0836670786	PRB-21-10	Sofía	Pincay Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
512	0441989605	PRB-21-11	Martín	Solórzano Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
513	2325402226	PRB-21-12	Luciana	Parrales Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
514	2108418910	PRB-21-13	Emiliano	Andrade Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
515	0844714287	PRB-21-14	Renata	Moreira Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
516	1916567710	PRB-21-15	Thiago	Rodríguez Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
517	1249427319	PRB-21-16	Antonella	Alcívar García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
518	0815044110	PRB-21-17	Dylan	Cabrera Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
519	1658249287	PRB-21-18	Mía	Ponce Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
520	1551404039	PRB-21-19	Gael	Zambrano Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
521	2439092541	PRB-21-20	Julieta	Mendoza Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
522	0700396252	PRB-22-1	Mateo	Loor Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
523	1826338954	PRB-22-2	Valentina	Vera Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
524	0204209183	PRB-22-3	Santiago	Intriago Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
525	0229527379	PRB-22-4	Camila	García Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
526	0808209845	PRB-22-5	Sebastián	Macías Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
527	0920748621	PRB-22-6	Isabella	Delgado Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
528	0720274612	PRB-22-7	Nicolás	Chávez Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
529	2111700114	PRB-22-8	Emma	Bravo Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
530	1616485338	PRB-22-9	Benjamín	Pincay Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
531	1822196653	PRB-22-10	Sofía	Solórzano Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
532	0408228948	PRB-22-11	Martín	Parrales Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
533	1729610780	PRB-22-12	Luciana	Andrade Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
534	0230715773	PRB-22-13	Emiliano	Moreira Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
535	2413328457	PRB-22-14	Renata	Rodríguez Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
536	2441013691	PRB-22-15	Thiago	Alcívar Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
537	2007025576	PRB-22-16	Antonella	Cabrera García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
538	0722593951	PRB-22-17	Dylan	Ponce Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
539	0251058921	PRB-22-18	Mía	Zambrano Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
540	0401041363	PRB-22-19	Gael	Mendoza Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
541	1510799412	PRB-22-20	Julieta	Cedeño Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
542	1138669948	PRB-30-1	Mateo	Pincay Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
543	1751109370	PRB-30-2	Valentina	Solórzano Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
544	0719074312	PRB-30-3	Santiago	Parrales Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
545	0312378524	PRB-30-4	Camila	Andrade Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
546	0224667535	PRB-30-5	Sebastián	Moreira Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
547	1447964493	PRB-30-6	Isabella	Rodríguez Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
548	1523396933	PRB-30-7	Nicolás	Alcívar Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
549	2020771784	PRB-30-8	Emma	Cabrera Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
550	0521029686	PRB-30-9	Benjamín	Ponce Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
551	0440754406	PRB-30-10	Sofía	Zambrano Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
552	1203730419	PRB-30-11	Martín	Mendoza Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
553	0616225900	PRB-30-12	Luciana	Cedeño Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
554	0326329992	PRB-30-13	Emiliano	Loor Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
555	1653537371	PRB-30-14	Renata	Vera Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
556	0649543980	PRB-30-15	Thiago	Intriago Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
557	1456858669	PRB-30-16	Antonella	García García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
558	2108972395	PRB-30-17	Dylan	Macías Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
559	1526037815	PRB-30-18	Mía	Delgado Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
560	1511552562	PRB-30-19	Gael	Chávez Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
561	0932706526	PRB-30-20	Julieta	Bravo Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
562	1034861912	PRB-23-1	Mateo	Vera Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
563	2233655113	PRB-23-2	Valentina	Intriago Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
564	1822601587	PRB-23-3	Santiago	García Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
565	2004990665	PRB-23-4	Camila	Macías Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
566	0333474823	PRB-23-5	Sebastián	Delgado Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
567	0314390584	PRB-23-6	Isabella	Chávez Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
568	1750461285	PRB-23-7	Nicolás	Bravo Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
569	1109072684	PRB-23-8	Emma	Pincay Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
570	0442899886	PRB-23-9	Benjamín	Solórzano Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
571	1054175623	PRB-23-10	Sofía	Parrales Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
572	0325126027	PRB-23-11	Martín	Andrade Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
573	2128778939	PRB-23-12	Luciana	Moreira Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
574	1324918042	PRB-23-13	Emiliano	Rodríguez Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
575	0505490797	PRB-23-14	Renata	Alcívar Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
576	2253965061	PRB-23-15	Thiago	Cabrera García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
577	1047197726	PRB-23-16	Antonella	Ponce Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
578	2455152237	PRB-23-17	Dylan	Zambrano Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
579	0613711985	PRB-23-18	Mía	Mendoza Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
580	1039319429	PRB-23-19	Gael	Cedeño Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
581	1825587668	PRB-23-20	Julieta	Loor Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
582	0551270648	PRB-24-1	Mateo	Intriago Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
583	1111702237	PRB-24-2	Valentina	García Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
584	0322724832	PRB-24-3	Santiago	Macías Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
585	2125645529	PRB-24-4	Camila	Delgado Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
586	0534627765	PRB-24-5	Sebastián	Chávez Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
587	1827313196	PRB-24-6	Isabella	Bravo Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
588	2108112570	PRB-24-7	Nicolás	Pincay Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
589	1746751708	PRB-24-8	Emma	Solórzano Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
590	1139158651	PRB-24-9	Benjamín	Parrales Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
591	1905117352	PRB-24-10	Sofía	Andrade Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
592	2211225202	PRB-24-11	Martín	Moreira Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
593	1333343299	PRB-24-12	Luciana	Rodríguez Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
594	1517662860	PRB-24-13	Emiliano	Alcívar Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
595	1952770277	PRB-24-14	Renata	Cabrera Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
596	1602440701	PRB-24-15	Thiago	Ponce García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
597	0955897129	PRB-24-16	Antonella	Zambrano Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
598	0849109145	PRB-24-17	Dylan	Mendoza Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
599	1835580083	PRB-24-18	Mía	Cedeño Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
600	1032279133	PRB-24-19	Gael	Loor Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
601	0901848101	PRB-24-20	Julieta	Vera Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
602	0352418594	PRB-31-1	Mateo	Solórzano Solórzano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
603	0513239491	PRB-31-2	Valentina	Parrales Parrales	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
604	2122220581	PRB-31-3	Santiago	Andrade Andrade	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
605	0301589842	PRB-31-4	Camila	Moreira Moreira	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
606	1047735632	PRB-31-5	Sebastián	Rodríguez Rodríguez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
607	1003435508	PRB-31-6	Isabella	Alcívar Alcívar	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
608	2450826967	PRB-31-7	Nicolás	Cabrera Cabrera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
609	1050503422	PRB-31-8	Emma	Ponce Ponce	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
610	0201721511	PRB-31-9	Benjamín	Zambrano Zambrano	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
611	0247918436	PRB-31-10	Sofía	Mendoza Mendoza	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
612	1247860222	PRB-31-11	Martín	Cedeño Cedeño	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
613	0134916766	PRB-31-12	Luciana	Loor Loor	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
614	2000233508	PRB-31-13	Emiliano	Vera Vera	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
615	0315428235	PRB-31-14	Renata	Intriago Intriago	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
616	1643457086	PRB-31-15	Thiago	García García	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
617	1537709048	PRB-31-16	Antonella	Macías Macías	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
618	1936947868	PRB-31-17	Dylan	Delgado Delgado	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
619	0407741735	PRB-31-18	Mía	Chávez Chávez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
620	2447507050	PRB-31-19	Gael	Bravo Bravo	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
621	0956417059	PRB-31-20	Julieta	Pincay Pincay	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
622	0618248116	PRB-25-1	Mateo	García Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
623	0700759079	PRB-25-2	Valentina	Macías Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
624	0241128495	PRB-25-3	Santiago	Delgado Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
625	0227113867	PRB-25-4	Camila	Chávez Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
626	1040135129	PRB-25-5	Sebastián	Bravo Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
627	1134403102	PRB-25-6	Isabella	Pincay Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
628	0757851555	PRB-25-7	Nicolás	Solórzano Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
629	2120769530	PRB-25-8	Emma	Parrales Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
630	1134068400	PRB-25-9	Benjamín	Andrade Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
631	2321973469	PRB-25-10	Sofía	Moreira Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
632	0950671131	PRB-25-11	Martín	Rodríguez Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
633	0203640248	PRB-25-12	Luciana	Alcívar Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
634	0638610493	PRB-25-13	Emiliano	Cabrera Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
635	0558214623	PRB-25-14	Renata	Ponce García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
636	1855980775	PRB-25-15	Thiago	Zambrano Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
637	1449491313	PRB-25-16	Antonella	Mendoza Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
638	1157709815	PRB-25-17	Dylan	Cedeño Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
639	2248623379	PRB-25-18	Mía	Loor Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
640	0840028617	PRB-25-19	Gael	Vera Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
641	0259469955	PRB-25-20	Julieta	Intriago Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
642	1619049487	PRB-26-1	Mateo	Macías Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
643	1307217479	PRB-26-2	Valentina	Delgado Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
644	1945182390	PRB-26-3	Santiago	Chávez Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
645	0823449913	PRB-26-4	Camila	Bravo Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
646	0204821110	PRB-26-5	Sebastián	Pincay Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
647	1303343881	PRB-26-6	Isabella	Solórzano Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
648	0205539695	PRB-26-7	Nicolás	Parrales Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
649	1912618186	PRB-26-8	Emma	Andrade Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
650	1959369693	PRB-26-9	Benjamín	Moreira Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
651	0842767410	PRB-26-10	Sofía	Rodríguez Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
652	1315324556	PRB-26-11	Martín	Alcívar Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
653	0619018286	PRB-26-12	Luciana	Cabrera Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
654	2104236209	PRB-26-13	Emiliano	Ponce Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
655	1444277055	PRB-26-14	Renata	Zambrano García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
656	1458468210	PRB-26-15	Thiago	Mendoza Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
657	0455074294	PRB-26-16	Antonella	Cedeño Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
658	0530585439	PRB-26-17	Dylan	Loor Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
659	0504204579	PRB-26-18	Mía	Vera Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
660	1356206878	PRB-26-19	Gael	Intriago Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
661	0331051474	PRB-26-20	Julieta	García Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
662	0248841348	PRB-32-1	Mateo	Parrales Parrales	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
663	1324768066	PRB-32-2	Valentina	Andrade Andrade	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
664	1612509255	PRB-32-3	Santiago	Moreira Moreira	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
665	1150510939	PRB-32-4	Camila	Rodríguez Rodríguez	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
666	0434862405	PRB-32-5	Sebastián	Alcívar Alcívar	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
667	1220734055	PRB-32-6	Isabella	Cabrera Cabrera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
668	1144280961	PRB-32-7	Nicolás	Ponce Ponce	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
669	1649678701	PRB-32-8	Emma	Zambrano Zambrano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
670	0639758242	PRB-32-9	Benjamín	Mendoza Mendoza	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
671	1233138054	PRB-32-10	Sofía	Cedeño Cedeño	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
672	0149757429	PRB-32-11	Martín	Loor Loor	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
673	0301596441	PRB-32-12	Luciana	Vera Vera	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
674	2350791493	PRB-32-13	Emiliano	Intriago Intriago	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
675	0633972559	PRB-32-14	Renata	García García	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
676	0149138174	PRB-32-15	Thiago	Macías Macías	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
677	0754323178	PRB-32-16	Antonella	Delgado Delgado	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
678	1303410896	PRB-32-17	Dylan	Chávez Chávez	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
679	1955068554	PRB-32-18	Mía	Bravo Bravo	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
680	0127475721	PRB-32-19	Gael	Pincay Pincay	\N	F	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
681	1532648795	PRB-32-20	Julieta	Solórzano Solórzano	\N	M	\N	\N	\N	\N	f	\N	\N	\N	PRUEBA	ACTIVO	\N	\N	2026-07-27 01:28:43.196068+00	2026-07-27 01:28:43.196068+00	\N	\N	\N	\N	\N	\N	f
\.


--
-- Data for Name: fichas_estudiante; Type: TABLE DATA; Schema: sga_secretaria; Owner: postgres
--

COPY sga_secretaria.fichas_estudiante (id_ficha, id_estudiante, tipo_sangre, alergias, medicacion_permanente, enfermedad_catastrofica, detalle_enfermedad, contacto_emergencia, telefono_emergencia, direccion_referencia, fecha_actualizacion) FROM stdin;
\.


--
-- Data for Name: historial_promocion; Type: TABLE DATA; Schema: sga_secretaria; Owner: postgres
--

COPY sga_secretaria.historial_promocion (id_historial, id_matricula, id_estudiante, id_grado_origen, id_ano_lectivo, resultado, promedio_anual, observaciones, registrado_por, fecha_registro, lamport_ts) FROM stdin;
\.


--
-- Data for Name: matriculas; Type: TABLE DATA; Schema: sga_secretaria; Owner: postgres
--

COPY sga_secretaria.matriculas (id_matricula, id_estudiante, id_grado, id_paralelo, id_ano_lectivo, numero_orden, fecha_registro, estado, observaciones, registrado_por, fecha_creacion) FROM stdin;
\.


--
-- Data for Name: representantes; Type: TABLE DATA; Schema: sga_secretaria; Owner: postgres
--

COPY sga_secretaria.representantes (id_representante, cedula, nombres, apellidos, parentesco, telefono_principal, telefono_alt, correo, direccion, fecha_creacion, fecha_actualizacion) FROM stdin;
\.


--
-- Name: actividades_id_actividad_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.actividades_id_actividad_seq', 8, true);


--
-- Name: asistencias_id_asistencia_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.asistencias_id_asistencia_seq', 198, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.auth_permission_id_seq', 1, false);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.auth_user_id_seq', 1, false);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: calificaciones_id_calificacion_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.calificaciones_id_calificacion_seq', 12, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.django_content_type_id_seq', 1, false);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.django_migrations_id_seq', 17, true);


--
-- Name: periodos_evaluacion_id_periodo_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.periodos_evaluacion_id_periodo_seq', 2, true);


--
-- Name: promedios_anuales_detalle_id_detalle_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.promedios_anuales_detalle_id_detalle_seq', 1, false);


--
-- Name: promedios_anuales_id_promedio_anual_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.promedios_anuales_id_promedio_anual_seq', 1, false);


--
-- Name: promedios_trimestrales_id_promedio_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.promedios_trimestrales_id_promedio_seq', 1, false);


--
-- Name: resumen_asistencia_id_resumen_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.resumen_asistencia_id_resumen_seq', 197, true);


--
-- Name: seguimiento_academico_id_seguimiento_seq; Type: SEQUENCE SET; Schema: sga_docente; Owner: postgres
--

SELECT pg_catalog.setval('sga_docente.seguimiento_academico_id_seguimiento_seq', 1, false);


--
-- Name: anos_lectivos_id_ano_lectivo_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.anos_lectivos_id_ano_lectivo_seq', 1, true);


--
-- Name: asignaciones_id_asignacion_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.asignaciones_id_asignacion_seq', 41, true);


--
-- Name: asignaturas_id_asignatura_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.asignaturas_id_asignatura_seq', 15, true);


--
-- Name: auditoria_id_auditoria_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.auditoria_id_auditoria_seq', 1, false);


--
-- Name: documentos_matricula_id_documento_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.documentos_matricula_id_documento_seq', 1, false);


--
-- Name: escala_calificaciones_id_escala_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.escala_calificaciones_id_escala_seq', 50, true);


--
-- Name: esquema_calificacion_id_esquema_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.esquema_calificacion_id_esquema_seq', 1, true);


--
-- Name: estudiantes_id_estudiante_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.estudiantes_id_estudiante_seq', 681, true);


--
-- Name: fichas_estudiante_id_ficha_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.fichas_estudiante_id_ficha_seq', 1, false);


--
-- Name: grados_id_grado_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.grados_id_grado_seq', 14, true);


--
-- Name: historial_promocion_id_historial_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.historial_promocion_id_historial_seq', 1, false);


--
-- Name: horarios_id_horario_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.horarios_id_horario_seq', 1, false);


--
-- Name: malla_curricular_id_malla_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.malla_curricular_id_malla_seq', 78, true);


--
-- Name: matriculas_id_matricula_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.matriculas_id_matricula_seq', 680, true);


--
-- Name: niveles_educativos_id_nivel_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.niveles_educativos_id_nivel_seq', 7, true);


--
-- Name: paralelos_ano_lectivo_id_paralelo_al_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.paralelos_ano_lectivo_id_paralelo_al_seq', 1, false);


--
-- Name: paralelos_id_paralelo_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.paralelos_id_paralelo_seq', 32, true);


--
-- Name: periodos_diarios_id_periodo_diario_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.periodos_diarios_id_periodo_diario_seq', 13, true);


--
-- Name: periodos_evaluacion_id_periodo_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.periodos_evaluacion_id_periodo_seq', 3, true);


--
-- Name: personas_id_persona_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.personas_id_persona_seq', 23, true);


--
-- Name: representantes_id_representante_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.representantes_id_representante_seq', 1, false);


--
-- Name: roles_id_rol_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.roles_id_rol_seq', 6, true);


--
-- Name: tipos_aporte_id_tipo_aporte_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.tipos_aporte_id_tipo_aporte_seq', 9, true);


--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: sga_principal; Owner: postgres
--

SELECT pg_catalog.setval('sga_principal.usuarios_id_usuario_seq', 26, true);


--
-- Name: documentos_matricula_id_documento_seq; Type: SEQUENCE SET; Schema: sga_secretaria; Owner: postgres
--

SELECT pg_catalog.setval('sga_secretaria.documentos_matricula_id_documento_seq', 1, false);


--
-- Name: estudiantes_id_estudiante_seq; Type: SEQUENCE SET; Schema: sga_secretaria; Owner: postgres
--

SELECT pg_catalog.setval('sga_secretaria.estudiantes_id_estudiante_seq', 681, true);


--
-- Name: fichas_estudiante_id_ficha_seq; Type: SEQUENCE SET; Schema: sga_secretaria; Owner: postgres
--

SELECT pg_catalog.setval('sga_secretaria.fichas_estudiante_id_ficha_seq', 1, false);


--
-- Name: historial_promocion_id_historial_seq; Type: SEQUENCE SET; Schema: sga_secretaria; Owner: postgres
--

SELECT pg_catalog.setval('sga_secretaria.historial_promocion_id_historial_seq', 1, false);


--
-- Name: matriculas_id_matricula_seq; Type: SEQUENCE SET; Schema: sga_secretaria; Owner: postgres
--

SELECT pg_catalog.setval('sga_secretaria.matriculas_id_matricula_seq', 1, false);


--
-- Name: representantes_id_representante_seq; Type: SEQUENCE SET; Schema: sga_secretaria; Owner: postgres
--

SELECT pg_catalog.setval('sga_secretaria.representantes_id_representante_seq', 1, true);


--
-- Name: actividades actividades_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.actividades
    ADD CONSTRAINT actividades_pkey PRIMARY KEY (id_actividad);


--
-- Name: asistencias asistencias_id_matricula_id_asignacion_fecha_key; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.asistencias
    ADD CONSTRAINT asistencias_id_matricula_id_asignacion_fecha_key UNIQUE (id_matricula, id_asignacion, fecha);


--
-- Name: asistencias asistencias_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.asistencias
    ADD CONSTRAINT asistencias_pkey PRIMARY KEY (id_asistencia);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: calificaciones calificaciones_id_actividad_id_matricula_key; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.calificaciones
    ADD CONSTRAINT calificaciones_id_actividad_id_matricula_key UNIQUE (id_actividad, id_matricula);


--
-- Name: calificaciones calificaciones_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.calificaciones
    ADD CONSTRAINT calificaciones_pkey PRIMARY KEY (id_calificacion);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: periodos_evaluacion periodos_evaluacion_id_ano_lectivo_tipo_key; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.periodos_evaluacion
    ADD CONSTRAINT periodos_evaluacion_id_ano_lectivo_tipo_key UNIQUE (id_ano_lectivo, tipo);


--
-- Name: periodos_evaluacion periodos_evaluacion_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.periodos_evaluacion
    ADD CONSTRAINT periodos_evaluacion_pkey PRIMARY KEY (id_periodo);


--
-- Name: promedios_anuales_detalle promedios_anuales_detalle_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_anuales_detalle
    ADD CONSTRAINT promedios_anuales_detalle_pkey PRIMARY KEY (id_detalle);


--
-- Name: promedios_anuales_detalle promedios_anuales_detalle_unique; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_anuales_detalle
    ADD CONSTRAINT promedios_anuales_detalle_unique UNIQUE (id_promedio_anual, id_promedio_trim);


--
-- Name: promedios_anuales promedios_anuales_id_matricula_id_asignacion_id_ano_lectivo_key; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_anuales
    ADD CONSTRAINT promedios_anuales_id_matricula_id_asignacion_id_ano_lectivo_key UNIQUE (id_matricula, id_asignacion, id_ano_lectivo);


--
-- Name: promedios_anuales promedios_anuales_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_anuales
    ADD CONSTRAINT promedios_anuales_pkey PRIMARY KEY (id_promedio_anual);


--
-- Name: promedios_trimestrales promedios_trimestrales_id_matricula_id_asignacion_id_period_key; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_trimestrales
    ADD CONSTRAINT promedios_trimestrales_id_matricula_id_asignacion_id_period_key UNIQUE (id_matricula, id_asignacion, id_periodo);


--
-- Name: promedios_trimestrales promedios_trimestrales_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_trimestrales
    ADD CONSTRAINT promedios_trimestrales_pkey PRIMARY KEY (id_promedio);


--
-- Name: resumen_asistencia resumen_asistencia_id_matricula_id_asignacion_id_periodo_key; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.resumen_asistencia
    ADD CONSTRAINT resumen_asistencia_id_matricula_id_asignacion_id_periodo_key UNIQUE (id_matricula, id_asignacion, id_periodo);


--
-- Name: resumen_asistencia resumen_asistencia_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.resumen_asistencia
    ADD CONSTRAINT resumen_asistencia_pkey PRIMARY KEY (id_resumen);


--
-- Name: seguimiento_academico seguimiento_academico_pkey; Type: CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.seguimiento_academico
    ADD CONSTRAINT seguimiento_academico_pkey PRIMARY KEY (id_seguimiento);


--
-- Name: anos_lectivos anos_lectivos_nombre_key; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.anos_lectivos
    ADD CONSTRAINT anos_lectivos_nombre_key UNIQUE (nombre);


--
-- Name: anos_lectivos anos_lectivos_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.anos_lectivos
    ADD CONSTRAINT anos_lectivos_pkey PRIMARY KEY (id_ano_lectivo);


--
-- Name: asignaciones asignaciones_asignatura_paralelo_ano_key; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.asignaciones
    ADD CONSTRAINT asignaciones_asignatura_paralelo_ano_key UNIQUE (id_asignatura, id_paralelo, id_ano_lectivo);


--
-- Name: asignaciones asignaciones_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.asignaciones
    ADD CONSTRAINT asignaciones_pkey PRIMARY KEY (id_asignacion);


--
-- Name: asignaturas asignaturas_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.asignaturas
    ADD CONSTRAINT asignaturas_pkey PRIMARY KEY (id_asignatura);


--
-- Name: asignaturas_por_nivel asignaturas_por_nivel_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.asignaturas_por_nivel
    ADD CONSTRAINT asignaturas_por_nivel_pkey PRIMARY KEY (id_asignatura, id_nivel);


--
-- Name: auditoria auditoria_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.auditoria
    ADD CONSTRAINT auditoria_pkey PRIMARY KEY (id_auditoria);


--
-- Name: documentos_matricula documentos_matricula_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.documentos_matricula
    ADD CONSTRAINT documentos_matricula_pkey PRIMARY KEY (id_documento);


--
-- Name: escala_calificaciones escala_ano_nivel_rango_unique; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.escala_calificaciones
    ADD CONSTRAINT escala_ano_nivel_rango_unique UNIQUE (id_ano_lectivo, id_nivel, nota_minima);


--
-- Name: escala_calificaciones escala_calificaciones_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.escala_calificaciones
    ADD CONSTRAINT escala_calificaciones_pkey PRIMARY KEY (id_escala);


--
-- Name: esquema_calificacion esquema_calificacion_id_ano_lectivo_key; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.esquema_calificacion
    ADD CONSTRAINT esquema_calificacion_id_ano_lectivo_key UNIQUE (id_ano_lectivo);


--
-- Name: esquema_calificacion esquema_calificacion_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.esquema_calificacion
    ADD CONSTRAINT esquema_calificacion_pkey PRIMARY KEY (id_esquema);


--
-- Name: estudiantes estudiantes_cedula_key; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.estudiantes
    ADD CONSTRAINT estudiantes_cedula_key UNIQUE (cedula);


--
-- Name: estudiantes estudiantes_codigo_estudiante_key; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.estudiantes
    ADD CONSTRAINT estudiantes_codigo_estudiante_key UNIQUE (codigo_estudiante);


--
-- Name: estudiantes estudiantes_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.estudiantes
    ADD CONSTRAINT estudiantes_pkey PRIMARY KEY (id_estudiante);


--
-- Name: fichas_estudiante fichas_estudiante_id_estudiante_key; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.fichas_estudiante
    ADD CONSTRAINT fichas_estudiante_id_estudiante_key UNIQUE (id_estudiante);


--
-- Name: fichas_estudiante fichas_estudiante_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.fichas_estudiante
    ADD CONSTRAINT fichas_estudiante_pkey PRIMARY KEY (id_ficha);


--
-- Name: grados grados_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.grados
    ADD CONSTRAINT grados_pkey PRIMARY KEY (id_grado);


--
-- Name: historial_promocion historial_matricula_unique; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.historial_promocion
    ADD CONSTRAINT historial_matricula_unique UNIQUE (id_matricula);


--
-- Name: historial_promocion historial_promocion_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.historial_promocion
    ADD CONSTRAINT historial_promocion_pkey PRIMARY KEY (id_historial);


--
-- Name: horarios horarios_id_asignacion_id_periodo_diario_dia_semana_key; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.horarios
    ADD CONSTRAINT horarios_id_asignacion_id_periodo_diario_dia_semana_key UNIQUE (id_asignacion, id_periodo_diario, dia_semana);


--
-- Name: horarios horarios_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.horarios
    ADD CONSTRAINT horarios_pkey PRIMARY KEY (id_horario);


--
-- Name: malla_curricular malla_curricular_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.malla_curricular
    ADD CONSTRAINT malla_curricular_pkey PRIMARY KEY (id_malla);


--
-- Name: matriculas matriculas_id_estudiante_id_ano_lectivo_key; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.matriculas
    ADD CONSTRAINT matriculas_id_estudiante_id_ano_lectivo_key UNIQUE (id_estudiante, id_ano_lectivo);


--
-- Name: matriculas matriculas_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.matriculas
    ADD CONSTRAINT matriculas_pkey PRIMARY KEY (id_matricula);


--
-- Name: niveles_educativos niveles_educativos_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.niveles_educativos
    ADD CONSTRAINT niveles_educativos_pkey PRIMARY KEY (id_nivel);


--
-- Name: paralelos_ano_lectivo paralelos_ano_lectivo_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.paralelos_ano_lectivo
    ADD CONSTRAINT paralelos_ano_lectivo_pkey PRIMARY KEY (id_paralelo_al);


--
-- Name: paralelos_ano_lectivo paralelos_ano_lectivo_unique; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.paralelos_ano_lectivo
    ADD CONSTRAINT paralelos_ano_lectivo_unique UNIQUE (id_paralelo, id_ano_lectivo);


--
-- Name: paralelos paralelos_id_grado_letra_key; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.paralelos
    ADD CONSTRAINT paralelos_id_grado_letra_key UNIQUE (id_grado, letra);


--
-- Name: paralelos paralelos_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.paralelos
    ADD CONSTRAINT paralelos_pkey PRIMARY KEY (id_paralelo);


--
-- Name: periodos_diarios periodos_diarios_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.periodos_diarios
    ADD CONSTRAINT periodos_diarios_pkey PRIMARY KEY (id_periodo_diario);


--
-- Name: periodos_evaluacion periodos_evaluacion_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.periodos_evaluacion
    ADD CONSTRAINT periodos_evaluacion_pkey PRIMARY KEY (id_periodo);


--
-- Name: personas personas_cedula_key; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.personas
    ADD CONSTRAINT personas_cedula_key UNIQUE (cedula);


--
-- Name: personas personas_id_usuario_key; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.personas
    ADD CONSTRAINT personas_id_usuario_key UNIQUE (id_usuario);


--
-- Name: personas personas_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.personas
    ADD CONSTRAINT personas_pkey PRIMARY KEY (id_persona);


--
-- Name: representantes representantes_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.representantes
    ADD CONSTRAINT representantes_pkey PRIMARY KEY (id_representante);


--
-- Name: roles roles_nombre_key; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.roles
    ADD CONSTRAINT roles_nombre_key UNIQUE (nombre);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id_rol);


--
-- Name: tipos_aporte tipos_aporte_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.tipos_aporte
    ADD CONSTRAINT tipos_aporte_pkey PRIMARY KEY (id_tipo_aporte);


--
-- Name: tipos_aporte uk_aporte_ano_nombre; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.tipos_aporte
    ADD CONSTRAINT uk_aporte_ano_nombre UNIQUE (id_ano_lectivo, nombre);


--
-- Name: periodos_evaluacion uk_periodo_ano_tipo; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.periodos_evaluacion
    ADD CONSTRAINT uk_periodo_ano_tipo UNIQUE (id_ano_lectivo, tipo);


--
-- Name: usuario_roles usuario_roles_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.usuario_roles
    ADD CONSTRAINT usuario_roles_pkey PRIMARY KEY (id_usuario, id_rol);


--
-- Name: usuarios usuarios_correo_key; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.usuarios
    ADD CONSTRAINT usuarios_correo_key UNIQUE (correo);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- Name: usuarios usuarios_username_key; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.usuarios
    ADD CONSTRAINT usuarios_username_key UNIQUE (username);


--
-- Name: usuarios usuarios_uuid_key; Type: CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.usuarios
    ADD CONSTRAINT usuarios_uuid_key UNIQUE (uuid);


--
-- Name: documentos_matricula documentos_matricula_pkey; Type: CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.documentos_matricula
    ADD CONSTRAINT documentos_matricula_pkey PRIMARY KEY (id_documento);


--
-- Name: estudiantes estudiantes_cedula_key; Type: CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.estudiantes
    ADD CONSTRAINT estudiantes_cedula_key UNIQUE (cedula);


--
-- Name: estudiantes estudiantes_codigo_estudiante_key; Type: CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.estudiantes
    ADD CONSTRAINT estudiantes_codigo_estudiante_key UNIQUE (codigo_estudiante);


--
-- Name: estudiantes estudiantes_pkey; Type: CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.estudiantes
    ADD CONSTRAINT estudiantes_pkey PRIMARY KEY (id_estudiante);


--
-- Name: fichas_estudiante fichas_estudiante_id_estudiante_key; Type: CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.fichas_estudiante
    ADD CONSTRAINT fichas_estudiante_id_estudiante_key UNIQUE (id_estudiante);


--
-- Name: fichas_estudiante fichas_estudiante_pkey; Type: CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.fichas_estudiante
    ADD CONSTRAINT fichas_estudiante_pkey PRIMARY KEY (id_ficha);


--
-- Name: historial_promocion historial_matricula_unique; Type: CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.historial_promocion
    ADD CONSTRAINT historial_matricula_unique UNIQUE (id_matricula);


--
-- Name: historial_promocion historial_promocion_pkey; Type: CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.historial_promocion
    ADD CONSTRAINT historial_promocion_pkey PRIMARY KEY (id_historial);


--
-- Name: matriculas matriculas_id_estudiante_id_ano_lectivo_key; Type: CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.matriculas
    ADD CONSTRAINT matriculas_id_estudiante_id_ano_lectivo_key UNIQUE (id_estudiante, id_ano_lectivo);


--
-- Name: matriculas matriculas_pkey; Type: CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.matriculas
    ADD CONSTRAINT matriculas_pkey PRIMARY KEY (id_matricula);


--
-- Name: representantes representantes_pkey; Type: CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.representantes
    ADD CONSTRAINT representantes_pkey PRIMARY KEY (id_representante);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON sga_docente.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON sga_docente.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON sga_docente.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON sga_docente.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON sga_docente.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON sga_docente.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON sga_docente.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON sga_docente.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON sga_docente.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON sga_docente.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON sga_docente.django_admin_log USING btree (user_id);


--
-- Name: idx_actividades_asignacion; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX idx_actividades_asignacion ON sga_docente.actividades USING btree (id_asignacion, id_periodo);


--
-- Name: idx_asistencias_asignacion; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX idx_asistencias_asignacion ON sga_docente.asistencias USING btree (id_asignacion, id_periodo);


--
-- Name: idx_asistencias_matricula; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX idx_asistencias_matricula ON sga_docente.asistencias USING btree (id_matricula, fecha);


--
-- Name: idx_calificaciones_actividad; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX idx_calificaciones_actividad ON sga_docente.calificaciones USING btree (id_actividad);


--
-- Name: idx_calificaciones_matricula; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX idx_calificaciones_matricula ON sga_docente.calificaciones USING btree (id_matricula);


--
-- Name: idx_promedios_anuales_detalle; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX idx_promedios_anuales_detalle ON sga_docente.promedios_anuales_detalle USING btree (id_promedio_anual);


--
-- Name: idx_promedios_trim_matricula; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX idx_promedios_trim_matricula ON sga_docente.promedios_trimestrales USING btree (id_matricula, id_asignacion);


--
-- Name: idx_seguimiento_categoria; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX idx_seguimiento_categoria ON sga_docente.seguimiento_academico USING btree (categoria, fecha_evento);


--
-- Name: idx_seguimiento_matricula; Type: INDEX; Schema: sga_docente; Owner: postgres
--

CREATE INDEX idx_seguimiento_matricula ON sga_docente.seguimiento_academico USING btree (id_matricula, id_periodo);


--
-- Name: idx_asignaciones_docente; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE INDEX idx_asignaciones_docente ON sga_principal.asignaciones USING btree (id_docente, id_ano_lectivo);


--
-- Name: idx_asignaciones_grado; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE INDEX idx_asignaciones_grado ON sga_principal.asignaciones USING btree (id_grado, id_ano_lectivo);


--
-- Name: idx_asignaciones_paralelo; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE INDEX idx_asignaciones_paralelo ON sga_principal.asignaciones USING btree (id_paralelo, id_ano_lectivo);


--
-- Name: idx_auditoria_schema_origen; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE INDEX idx_auditoria_schema_origen ON sga_principal.auditoria USING btree (schema_origen, fecha);


--
-- Name: idx_estudiantes_apellidos; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE INDEX idx_estudiantes_apellidos ON sga_principal.estudiantes USING btree (apellidos, nombres);


--
-- Name: idx_estudiantes_cedula; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE INDEX idx_estudiantes_cedula ON sga_principal.estudiantes USING btree (cedula);


--
-- Name: idx_historial_estudiante; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE INDEX idx_historial_estudiante ON sga_principal.historial_promocion USING btree (id_estudiante, id_ano_lectivo);


--
-- Name: idx_historial_promocion_lamport_ts; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE INDEX idx_historial_promocion_lamport_ts ON sga_principal.historial_promocion USING btree (lamport_ts);


--
-- Name: idx_horarios_asignacion; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE INDEX idx_horarios_asignacion ON sga_principal.horarios USING btree (id_asignacion);


--
-- Name: idx_matriculas_ano_lectivo; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE INDEX idx_matriculas_ano_lectivo ON sga_principal.matriculas USING btree (id_ano_lectivo);


--
-- Name: idx_matriculas_estudiante; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE INDEX idx_matriculas_estudiante ON sga_principal.matriculas USING btree (id_estudiante);


--
-- Name: idx_matriculas_grado; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE INDEX idx_matriculas_grado ON sga_principal.matriculas USING btree (id_grado);


--
-- Name: idx_matriculas_paralelo; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE INDEX idx_matriculas_paralelo ON sga_principal.matriculas USING btree (id_paralelo, id_ano_lectivo);


--
-- Name: idx_paralelos_al_ano; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE INDEX idx_paralelos_al_ano ON sga_principal.paralelos_ano_lectivo USING btree (id_ano_lectivo);


--
-- Name: idx_personas_cedula; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE INDEX idx_personas_cedula ON sga_principal.personas USING btree (cedula);


--
-- Name: idx_usuario_roles_usuario; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE INDEX idx_usuario_roles_usuario ON sga_principal.usuario_roles USING btree (id_usuario);


--
-- Name: idx_usuarios_username; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE INDEX idx_usuarios_username ON sga_principal.usuarios USING btree (username);


--
-- Name: uq_ano_lectivo_actual; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE UNIQUE INDEX uq_ano_lectivo_actual ON sga_principal.anos_lectivos USING btree (es_actual) WHERE (es_actual = true);


--
-- Name: uq_asignacion_docente_un_tutor_por_ano; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE UNIQUE INDEX uq_asignacion_docente_un_tutor_por_ano ON sga_principal.asignaciones USING btree (id_docente, id_ano_lectivo) WHERE (es_tutor = true);


--
-- Name: uq_asignacion_un_tutor_por_curso; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE UNIQUE INDEX uq_asignacion_un_tutor_por_curso ON sga_principal.asignaciones USING btree (id_grado, id_paralelo, id_ano_lectivo) WHERE (es_tutor = true);


--
-- Name: uq_malla_grado_asig_ano; Type: INDEX; Schema: sga_principal; Owner: postgres
--

CREATE UNIQUE INDEX uq_malla_grado_asig_ano ON sga_principal.malla_curricular USING btree (id_grado, id_asignatura, id_ano_lectivo);


--
-- Name: idx_estudiantes_apellidos; Type: INDEX; Schema: sga_secretaria; Owner: postgres
--

CREATE INDEX idx_estudiantes_apellidos ON sga_secretaria.estudiantes USING btree (apellidos, nombres);


--
-- Name: idx_estudiantes_cedula; Type: INDEX; Schema: sga_secretaria; Owner: postgres
--

CREATE INDEX idx_estudiantes_cedula ON sga_secretaria.estudiantes USING btree (cedula);


--
-- Name: idx_historial_estudiante; Type: INDEX; Schema: sga_secretaria; Owner: postgres
--

CREATE INDEX idx_historial_estudiante ON sga_secretaria.historial_promocion USING btree (id_estudiante, id_ano_lectivo);


--
-- Name: idx_historial_promocion_lamport_ts; Type: INDEX; Schema: sga_secretaria; Owner: postgres
--

CREATE INDEX idx_historial_promocion_lamport_ts ON sga_secretaria.historial_promocion USING btree (lamport_ts);


--
-- Name: idx_matriculas_ano_lectivo; Type: INDEX; Schema: sga_secretaria; Owner: postgres
--

CREATE INDEX idx_matriculas_ano_lectivo ON sga_secretaria.matriculas USING btree (id_ano_lectivo);


--
-- Name: idx_matriculas_estudiante; Type: INDEX; Schema: sga_secretaria; Owner: postgres
--

CREATE INDEX idx_matriculas_estudiante ON sga_secretaria.matriculas USING btree (id_estudiante);


--
-- Name: idx_matriculas_grado; Type: INDEX; Schema: sga_secretaria; Owner: postgres
--

CREATE INDEX idx_matriculas_grado ON sga_secretaria.matriculas USING btree (id_grado);


--
-- Name: idx_matriculas_paralelo; Type: INDEX; Schema: sga_secretaria; Owner: postgres
--

CREATE INDEX idx_matriculas_paralelo ON sga_secretaria.matriculas USING btree (id_paralelo, id_ano_lectivo);


--
-- Name: actividades actividades_id_asignacion_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.actividades
    ADD CONSTRAINT actividades_id_asignacion_fkey FOREIGN KEY (id_asignacion) REFERENCES sga_principal.asignaciones(id_asignacion);


--
-- Name: actividades actividades_id_periodo_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.actividades
    ADD CONSTRAINT actividades_id_periodo_fkey FOREIGN KEY (id_periodo) REFERENCES sga_docente.periodos_evaluacion(id_periodo);


--
-- Name: asistencias asistencias_id_asignacion_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.asistencias
    ADD CONSTRAINT asistencias_id_asignacion_fkey FOREIGN KEY (id_asignacion) REFERENCES sga_principal.asignaciones(id_asignacion);


--
-- Name: asistencias asistencias_id_matricula_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.asistencias
    ADD CONSTRAINT asistencias_id_matricula_fkey FOREIGN KEY (id_matricula) REFERENCES sga_principal.matriculas(id_matricula);


--
-- Name: asistencias asistencias_id_periodo_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.asistencias
    ADD CONSTRAINT asistencias_id_periodo_fkey FOREIGN KEY (id_periodo) REFERENCES sga_docente.periodos_evaluacion(id_periodo);


--
-- Name: asistencias asistencias_registrado_por_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.asistencias
    ADD CONSTRAINT asistencias_registrado_por_fkey FOREIGN KEY (registrado_por) REFERENCES sga_principal.usuarios(id_usuario);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES sga_docente.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES sga_docente.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES sga_docente.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES sga_docente.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES sga_docente.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES sga_docente.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES sga_docente.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: calificaciones calificaciones_id_actividad_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.calificaciones
    ADD CONSTRAINT calificaciones_id_actividad_fkey FOREIGN KEY (id_actividad) REFERENCES sga_docente.actividades(id_actividad);


--
-- Name: calificaciones calificaciones_id_matricula_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.calificaciones
    ADD CONSTRAINT calificaciones_id_matricula_fkey FOREIGN KEY (id_matricula) REFERENCES sga_principal.matriculas(id_matricula);


--
-- Name: calificaciones calificaciones_registrado_por_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.calificaciones
    ADD CONSTRAINT calificaciones_registrado_por_fkey FOREIGN KEY (registrado_por) REFERENCES sga_principal.usuarios(id_usuario);


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES sga_docente.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES sga_docente.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: promedios_anuales_detalle pad_id_promedio_anual_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_anuales_detalle
    ADD CONSTRAINT pad_id_promedio_anual_fkey FOREIGN KEY (id_promedio_anual) REFERENCES sga_docente.promedios_anuales(id_promedio_anual) ON DELETE CASCADE;


--
-- Name: promedios_anuales_detalle pad_id_promedio_trim_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_anuales_detalle
    ADD CONSTRAINT pad_id_promedio_trim_fkey FOREIGN KEY (id_promedio_trim) REFERENCES sga_docente.promedios_trimestrales(id_promedio);


--
-- Name: periodos_evaluacion periodos_evaluacion_id_ano_lectivo_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.periodos_evaluacion
    ADD CONSTRAINT periodos_evaluacion_id_ano_lectivo_fkey FOREIGN KEY (id_ano_lectivo) REFERENCES sga_principal.anos_lectivos(id_ano_lectivo);


--
-- Name: promedios_anuales promedios_anuales_id_ano_lectivo_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_anuales
    ADD CONSTRAINT promedios_anuales_id_ano_lectivo_fkey FOREIGN KEY (id_ano_lectivo) REFERENCES sga_principal.anos_lectivos(id_ano_lectivo);


--
-- Name: promedios_anuales promedios_anuales_id_asignacion_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_anuales
    ADD CONSTRAINT promedios_anuales_id_asignacion_fkey FOREIGN KEY (id_asignacion) REFERENCES sga_principal.asignaciones(id_asignacion);


--
-- Name: promedios_anuales promedios_anuales_id_matricula_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_anuales
    ADD CONSTRAINT promedios_anuales_id_matricula_fkey FOREIGN KEY (id_matricula) REFERENCES sga_principal.matriculas(id_matricula);


--
-- Name: promedios_anuales promedios_anuales_registrado_por_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_anuales
    ADD CONSTRAINT promedios_anuales_registrado_por_fkey FOREIGN KEY (registrado_por) REFERENCES sga_principal.usuarios(id_usuario);


--
-- Name: promedios_trimestrales promedios_trimestrales_id_asignacion_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_trimestrales
    ADD CONSTRAINT promedios_trimestrales_id_asignacion_fkey FOREIGN KEY (id_asignacion) REFERENCES sga_principal.asignaciones(id_asignacion);


--
-- Name: promedios_trimestrales promedios_trimestrales_id_matricula_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_trimestrales
    ADD CONSTRAINT promedios_trimestrales_id_matricula_fkey FOREIGN KEY (id_matricula) REFERENCES sga_principal.matriculas(id_matricula);


--
-- Name: promedios_trimestrales promedios_trimestrales_id_periodo_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.promedios_trimestrales
    ADD CONSTRAINT promedios_trimestrales_id_periodo_fkey FOREIGN KEY (id_periodo) REFERENCES sga_docente.periodos_evaluacion(id_periodo);


--
-- Name: resumen_asistencia resumen_asistencia_id_asignacion_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.resumen_asistencia
    ADD CONSTRAINT resumen_asistencia_id_asignacion_fkey FOREIGN KEY (id_asignacion) REFERENCES sga_principal.asignaciones(id_asignacion);


--
-- Name: resumen_asistencia resumen_asistencia_id_matricula_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.resumen_asistencia
    ADD CONSTRAINT resumen_asistencia_id_matricula_fkey FOREIGN KEY (id_matricula) REFERENCES sga_principal.matriculas(id_matricula);


--
-- Name: resumen_asistencia resumen_asistencia_id_periodo_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.resumen_asistencia
    ADD CONSTRAINT resumen_asistencia_id_periodo_fkey FOREIGN KEY (id_periodo) REFERENCES sga_docente.periodos_evaluacion(id_periodo);


--
-- Name: seguimiento_academico seguimiento_id_matricula_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.seguimiento_academico
    ADD CONSTRAINT seguimiento_id_matricula_fkey FOREIGN KEY (id_matricula) REFERENCES sga_principal.matriculas(id_matricula);


--
-- Name: seguimiento_academico seguimiento_id_periodo_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.seguimiento_academico
    ADD CONSTRAINT seguimiento_id_periodo_fkey FOREIGN KEY (id_periodo) REFERENCES sga_docente.periodos_evaluacion(id_periodo);


--
-- Name: seguimiento_academico seguimiento_registrado_por_fkey; Type: FK CONSTRAINT; Schema: sga_docente; Owner: postgres
--

ALTER TABLE ONLY sga_docente.seguimiento_academico
    ADD CONSTRAINT seguimiento_registrado_por_fkey FOREIGN KEY (registrado_por) REFERENCES sga_principal.usuarios(id_usuario);


--
-- Name: anos_lectivos anos_lectivos_creado_por_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.anos_lectivos
    ADD CONSTRAINT anos_lectivos_creado_por_fkey FOREIGN KEY (creado_por) REFERENCES sga_principal.usuarios(id_usuario);


--
-- Name: asignaciones asignaciones_asignado_por_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.asignaciones
    ADD CONSTRAINT asignaciones_asignado_por_fkey FOREIGN KEY (asignado_por) REFERENCES sga_principal.usuarios(id_usuario);


--
-- Name: asignaciones asignaciones_id_ano_lectivo_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.asignaciones
    ADD CONSTRAINT asignaciones_id_ano_lectivo_fkey FOREIGN KEY (id_ano_lectivo) REFERENCES sga_principal.anos_lectivos(id_ano_lectivo);


--
-- Name: asignaciones asignaciones_id_asignatura_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.asignaciones
    ADD CONSTRAINT asignaciones_id_asignatura_fkey FOREIGN KEY (id_asignatura) REFERENCES sga_principal.asignaturas(id_asignatura);


--
-- Name: asignaciones asignaciones_id_docente_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.asignaciones
    ADD CONSTRAINT asignaciones_id_docente_fkey FOREIGN KEY (id_docente) REFERENCES sga_principal.personas(id_persona);


--
-- Name: asignaciones asignaciones_id_grado_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.asignaciones
    ADD CONSTRAINT asignaciones_id_grado_fkey FOREIGN KEY (id_grado) REFERENCES sga_principal.grados(id_grado);


--
-- Name: asignaciones asignaciones_id_paralelo_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.asignaciones
    ADD CONSTRAINT asignaciones_id_paralelo_fkey FOREIGN KEY (id_paralelo) REFERENCES sga_principal.paralelos(id_paralelo);


--
-- Name: asignaturas_por_nivel asignaturas_por_nivel_id_asignatura_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.asignaturas_por_nivel
    ADD CONSTRAINT asignaturas_por_nivel_id_asignatura_fkey FOREIGN KEY (id_asignatura) REFERENCES sga_principal.asignaturas(id_asignatura);


--
-- Name: asignaturas_por_nivel asignaturas_por_nivel_id_nivel_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.asignaturas_por_nivel
    ADD CONSTRAINT asignaturas_por_nivel_id_nivel_fkey FOREIGN KEY (id_nivel) REFERENCES sga_principal.niveles_educativos(id_nivel);


--
-- Name: auditoria auditoria_id_usuario_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.auditoria
    ADD CONSTRAINT auditoria_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES sga_principal.usuarios(id_usuario);


--
-- Name: documentos_matricula documentos_matricula_id_matricula_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.documentos_matricula
    ADD CONSTRAINT documentos_matricula_id_matricula_fkey FOREIGN KEY (id_matricula) REFERENCES sga_principal.matriculas(id_matricula) ON DELETE CASCADE;


--
-- Name: documentos_matricula documentos_matricula_subido_por_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.documentos_matricula
    ADD CONSTRAINT documentos_matricula_subido_por_fkey FOREIGN KEY (subido_por) REFERENCES sga_principal.usuarios(id_usuario);


--
-- Name: escala_calificaciones escala_calificaciones_id_ano_lectivo_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.escala_calificaciones
    ADD CONSTRAINT escala_calificaciones_id_ano_lectivo_fkey FOREIGN KEY (id_ano_lectivo) REFERENCES sga_principal.anos_lectivos(id_ano_lectivo);


--
-- Name: escala_calificaciones escala_calificaciones_id_nivel_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.escala_calificaciones
    ADD CONSTRAINT escala_calificaciones_id_nivel_fkey FOREIGN KEY (id_nivel) REFERENCES sga_principal.niveles_educativos(id_nivel);


--
-- Name: esquema_calificacion esquema_calificacion_id_ano_lectivo_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.esquema_calificacion
    ADD CONSTRAINT esquema_calificacion_id_ano_lectivo_fkey FOREIGN KEY (id_ano_lectivo) REFERENCES sga_principal.anos_lectivos(id_ano_lectivo);


--
-- Name: estudiantes estudiantes_creado_por_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.estudiantes
    ADD CONSTRAINT estudiantes_creado_por_fkey FOREIGN KEY (creado_por) REFERENCES sga_principal.usuarios(id_usuario);


--
-- Name: fichas_estudiante fichas_estudiante_id_estudiante_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.fichas_estudiante
    ADD CONSTRAINT fichas_estudiante_id_estudiante_fkey FOREIGN KEY (id_estudiante) REFERENCES sga_secretaria.estudiantes(id_estudiante) ON DELETE CASCADE;


--
-- Name: estudiantes fk_estudiante_representante; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.estudiantes
    ADD CONSTRAINT fk_estudiante_representante FOREIGN KEY (id_representante) REFERENCES sga_principal.representantes(id_representante);


--
-- Name: matriculas fk_matricula_paralelo; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.matriculas
    ADD CONSTRAINT fk_matricula_paralelo FOREIGN KEY (id_paralelo) REFERENCES sga_principal.paralelos(id_paralelo);


--
-- Name: grados grados_id_nivel_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.grados
    ADD CONSTRAINT grados_id_nivel_fkey FOREIGN KEY (id_nivel) REFERENCES sga_principal.niveles_educativos(id_nivel);


--
-- Name: historial_promocion historial_id_ano_lectivo_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.historial_promocion
    ADD CONSTRAINT historial_id_ano_lectivo_fkey FOREIGN KEY (id_ano_lectivo) REFERENCES sga_principal.anos_lectivos(id_ano_lectivo);


--
-- Name: historial_promocion historial_id_estudiante_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.historial_promocion
    ADD CONSTRAINT historial_id_estudiante_fkey FOREIGN KEY (id_estudiante) REFERENCES sga_secretaria.estudiantes(id_estudiante);


--
-- Name: historial_promocion historial_id_grado_origen_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.historial_promocion
    ADD CONSTRAINT historial_id_grado_origen_fkey FOREIGN KEY (id_grado_origen) REFERENCES sga_principal.grados(id_grado);


--
-- Name: historial_promocion historial_id_matricula_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.historial_promocion
    ADD CONSTRAINT historial_id_matricula_fkey FOREIGN KEY (id_matricula) REFERENCES sga_principal.matriculas(id_matricula);


--
-- Name: historial_promocion historial_registrado_por_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.historial_promocion
    ADD CONSTRAINT historial_registrado_por_fkey FOREIGN KEY (registrado_por) REFERENCES sga_principal.usuarios(id_usuario);


--
-- Name: horarios horarios_id_asignacion_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.horarios
    ADD CONSTRAINT horarios_id_asignacion_fkey FOREIGN KEY (id_asignacion) REFERENCES sga_principal.asignaciones(id_asignacion);


--
-- Name: horarios horarios_id_periodo_diario_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.horarios
    ADD CONSTRAINT horarios_id_periodo_diario_fkey FOREIGN KEY (id_periodo_diario) REFERENCES sga_principal.periodos_diarios(id_periodo_diario);


--
-- Name: malla_curricular malla_curricular_id_ano_lectivo_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.malla_curricular
    ADD CONSTRAINT malla_curricular_id_ano_lectivo_fkey FOREIGN KEY (id_ano_lectivo) REFERENCES sga_principal.anos_lectivos(id_ano_lectivo);


--
-- Name: malla_curricular malla_curricular_id_asignatura_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.malla_curricular
    ADD CONSTRAINT malla_curricular_id_asignatura_fkey FOREIGN KEY (id_asignatura) REFERENCES sga_principal.asignaturas(id_asignatura);


--
-- Name: malla_curricular malla_curricular_id_grado_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.malla_curricular
    ADD CONSTRAINT malla_curricular_id_grado_fkey FOREIGN KEY (id_grado) REFERENCES sga_principal.grados(id_grado);


--
-- Name: matriculas matriculas_id_ano_lectivo_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.matriculas
    ADD CONSTRAINT matriculas_id_ano_lectivo_fkey FOREIGN KEY (id_ano_lectivo) REFERENCES sga_principal.anos_lectivos(id_ano_lectivo);


--
-- Name: matriculas matriculas_id_estudiante_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.matriculas
    ADD CONSTRAINT matriculas_id_estudiante_fkey FOREIGN KEY (id_estudiante) REFERENCES sga_secretaria.estudiantes(id_estudiante);


--
-- Name: matriculas matriculas_id_grado_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.matriculas
    ADD CONSTRAINT matriculas_id_grado_fkey FOREIGN KEY (id_grado) REFERENCES sga_principal.grados(id_grado);


--
-- Name: matriculas matriculas_id_paralelo_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.matriculas
    ADD CONSTRAINT matriculas_id_paralelo_fkey FOREIGN KEY (id_paralelo) REFERENCES sga_principal.paralelos(id_paralelo);


--
-- Name: matriculas matriculas_registrado_por_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.matriculas
    ADD CONSTRAINT matriculas_registrado_por_fkey FOREIGN KEY (registrado_por) REFERENCES sga_principal.usuarios(id_usuario);


--
-- Name: paralelos_ano_lectivo paralelos_al_id_ano_lectivo_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.paralelos_ano_lectivo
    ADD CONSTRAINT paralelos_al_id_ano_lectivo_fkey FOREIGN KEY (id_ano_lectivo) REFERENCES sga_principal.anos_lectivos(id_ano_lectivo);


--
-- Name: paralelos_ano_lectivo paralelos_al_id_paralelo_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.paralelos_ano_lectivo
    ADD CONSTRAINT paralelos_al_id_paralelo_fkey FOREIGN KEY (id_paralelo) REFERENCES sga_principal.paralelos(id_paralelo);


--
-- Name: paralelos paralelos_id_grado_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.paralelos
    ADD CONSTRAINT paralelos_id_grado_fkey FOREIGN KEY (id_grado) REFERENCES sga_principal.grados(id_grado);


--
-- Name: periodos_evaluacion periodos_evaluacion_id_ano_lectivo_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.periodos_evaluacion
    ADD CONSTRAINT periodos_evaluacion_id_ano_lectivo_fkey FOREIGN KEY (id_ano_lectivo) REFERENCES sga_principal.anos_lectivos(id_ano_lectivo);


--
-- Name: personas personas_id_usuario_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.personas
    ADD CONSTRAINT personas_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES sga_principal.usuarios(id_usuario) ON DELETE CASCADE;


--
-- Name: tipos_aporte tipos_aporte_id_ano_lectivo_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.tipos_aporte
    ADD CONSTRAINT tipos_aporte_id_ano_lectivo_fkey FOREIGN KEY (id_ano_lectivo) REFERENCES sga_principal.anos_lectivos(id_ano_lectivo);


--
-- Name: usuario_roles usuario_roles_asignado_por_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.usuario_roles
    ADD CONSTRAINT usuario_roles_asignado_por_fkey FOREIGN KEY (asignado_por) REFERENCES sga_principal.usuarios(id_usuario);


--
-- Name: usuario_roles usuario_roles_id_rol_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.usuario_roles
    ADD CONSTRAINT usuario_roles_id_rol_fkey FOREIGN KEY (id_rol) REFERENCES sga_principal.roles(id_rol);


--
-- Name: usuario_roles usuario_roles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.usuario_roles
    ADD CONSTRAINT usuario_roles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES sga_principal.usuarios(id_usuario) ON DELETE CASCADE;


--
-- Name: usuarios usuarios_creado_por_fkey; Type: FK CONSTRAINT; Schema: sga_principal; Owner: postgres
--

ALTER TABLE ONLY sga_principal.usuarios
    ADD CONSTRAINT usuarios_creado_por_fkey FOREIGN KEY (creado_por) REFERENCES sga_principal.usuarios(id_usuario);


--
-- Name: documentos_matricula documentos_matricula_id_matricula_fkey; Type: FK CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.documentos_matricula
    ADD CONSTRAINT documentos_matricula_id_matricula_fkey FOREIGN KEY (id_matricula) REFERENCES sga_secretaria.matriculas(id_matricula) ON DELETE CASCADE;


--
-- Name: documentos_matricula documentos_matricula_subido_por_fkey; Type: FK CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.documentos_matricula
    ADD CONSTRAINT documentos_matricula_subido_por_fkey FOREIGN KEY (subido_por) REFERENCES sga_principal.usuarios(id_usuario);


--
-- Name: estudiantes estudiantes_creado_por_fkey; Type: FK CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.estudiantes
    ADD CONSTRAINT estudiantes_creado_por_fkey FOREIGN KEY (creado_por) REFERENCES sga_principal.usuarios(id_usuario);


--
-- Name: fichas_estudiante fichas_estudiante_id_estudiante_fkey; Type: FK CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.fichas_estudiante
    ADD CONSTRAINT fichas_estudiante_id_estudiante_fkey FOREIGN KEY (id_estudiante) REFERENCES sga_secretaria.estudiantes(id_estudiante) ON DELETE CASCADE;


--
-- Name: estudiantes fk_estudiante_representante; Type: FK CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.estudiantes
    ADD CONSTRAINT fk_estudiante_representante FOREIGN KEY (id_representante) REFERENCES sga_secretaria.representantes(id_representante);


--
-- Name: historial_promocion historial_id_ano_lectivo_fkey; Type: FK CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.historial_promocion
    ADD CONSTRAINT historial_id_ano_lectivo_fkey FOREIGN KEY (id_ano_lectivo) REFERENCES sga_principal.anos_lectivos(id_ano_lectivo);


--
-- Name: historial_promocion historial_id_estudiante_fkey; Type: FK CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.historial_promocion
    ADD CONSTRAINT historial_id_estudiante_fkey FOREIGN KEY (id_estudiante) REFERENCES sga_secretaria.estudiantes(id_estudiante);


--
-- Name: historial_promocion historial_id_grado_origen_fkey; Type: FK CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.historial_promocion
    ADD CONSTRAINT historial_id_grado_origen_fkey FOREIGN KEY (id_grado_origen) REFERENCES sga_principal.grados(id_grado);


--
-- Name: historial_promocion historial_id_matricula_fkey; Type: FK CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.historial_promocion
    ADD CONSTRAINT historial_id_matricula_fkey FOREIGN KEY (id_matricula) REFERENCES sga_secretaria.matriculas(id_matricula);


--
-- Name: historial_promocion historial_registrado_por_fkey; Type: FK CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.historial_promocion
    ADD CONSTRAINT historial_registrado_por_fkey FOREIGN KEY (registrado_por) REFERENCES sga_principal.usuarios(id_usuario);


--
-- Name: matriculas matriculas_id_ano_lectivo_fkey; Type: FK CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.matriculas
    ADD CONSTRAINT matriculas_id_ano_lectivo_fkey FOREIGN KEY (id_ano_lectivo) REFERENCES sga_principal.anos_lectivos(id_ano_lectivo);


--
-- Name: matriculas matriculas_id_estudiante_fkey; Type: FK CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.matriculas
    ADD CONSTRAINT matriculas_id_estudiante_fkey FOREIGN KEY (id_estudiante) REFERENCES sga_secretaria.estudiantes(id_estudiante);


--
-- Name: matriculas matriculas_id_grado_fkey; Type: FK CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.matriculas
    ADD CONSTRAINT matriculas_id_grado_fkey FOREIGN KEY (id_grado) REFERENCES sga_principal.grados(id_grado);


--
-- Name: matriculas matriculas_id_paralelo_fkey; Type: FK CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.matriculas
    ADD CONSTRAINT matriculas_id_paralelo_fkey FOREIGN KEY (id_paralelo) REFERENCES sga_principal.paralelos(id_paralelo);


--
-- Name: matriculas matriculas_registrado_por_fkey; Type: FK CONSTRAINT; Schema: sga_secretaria; Owner: postgres
--

ALTER TABLE ONLY sga_secretaria.matriculas
    ADD CONSTRAINT matriculas_registrado_por_fkey FOREIGN KEY (registrado_por) REFERENCES sga_principal.usuarios(id_usuario);


--
-- PostgreSQL database dump complete
--

\unrestrict qWZqyd2LgLxbgpMSdjA8hz0BPdK5kMavoue1DWVRY3yEEyTX3lMta33Spidyq6M

