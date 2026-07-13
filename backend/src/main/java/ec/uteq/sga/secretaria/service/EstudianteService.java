package ec.uteq.sga.secretaria.service;

import ec.uteq.sga.secretaria.common.ApiException;
import ec.uteq.sga.secretaria.common.PageResult;
import ec.uteq.sga.secretaria.common.jdbc.GenericRowMapper;
import ec.uteq.sga.secretaria.dto.EstudianteRequest;
import ec.uteq.sga.secretaria.security.CryptoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Service
public class EstudianteService {

    private static final Logger log = LoggerFactory.getLogger(EstudianteService.class);

    /**
     * Columnas cifradas con AES-256-GCM (CryptoService). Secretaria es la unica
     * escritora de estos campos en sga_principal.estudiantes; cedula y correo
     * quedan en claro porque se usan en busquedas/uniqueness (ILIKE, WHERE =).
     * No incluye campos de sga_principal.representantes: esa tabla la escribe
     * otro servicio y aqui solo se lee por JOIN.
     */
    private static final List<String> CAMPOS_CIFRADOS = List.of("direccion", "telefono", "tipo_discapacidad");

    private final NamedParameterJdbcTemplate jdbc;
    private final CryptoService crypto;

    public EstudianteService(NamedParameterJdbcTemplate jdbc, CryptoService crypto) {
        this.jdbc = jdbc;
        this.crypto = crypto;
    }

    /**
     * Descifra los campos sensibles de una fila. Tolera valores en texto plano
     * (estudiantes existentes de antes de activar el cifrado, o filas
     * escritas por sga-principal, que hoy no cifra) devolviendolos tal cual en
     * vez de fallar, para no romper la lectura de datos historicos.
     */
    private Map<String, Object> descifrarFila(Map<String, Object> row) {
        for (String campo : CAMPOS_CIFRADOS) {
            if (row.containsKey(campo)) {
                String valor = (String) row.get(campo);
                if (valor != null) {
                    try {
                        row.put(campo, crypto.decrypt(valor));
                    } catch (RuntimeException e) {
                        log.warn("No se pudo descifrar '{}' (probable dato en texto plano previo al cifrado); " +
                                "se devuelve sin cambios", campo);
                    }
                }
            }
        }
        return row;
    }

    /**
     * estudiantes.estado es varchar en la base ('ACTIVO'/'ACTIVA', con datos
     * legados inconsistentes en genero), no boolean como asumia el codigo
     * original. Se normaliza a boolean en la respuesta para no romper el
     * contrato con el frontend (Usuarios.jsx y Estudiantes.jsx ya esperan
     * estado true/false).
     */
    private Map<String, Object> normalizarEstado(Map<String, Object> row) {
        if (row.containsKey("estado")) {
            row.put("estado", esActivo(row.get("estado")));
        }
        return row;
    }

    private static boolean esActivo(Object estado) {
        if (estado instanceof Boolean b) return b;
        if (estado == null) return false;
        String texto = estado.toString().trim().toUpperCase();
        return texto.equals("ACTIVO") || texto.equals("ACTIVA");
    }

    private Map<String, Object> posprocesar(Map<String, Object> row) {
        return descifrarFila(normalizarEstado(row));
    }

    public PageResult<Map<String, Object>> listarTodos(String search, int page, int limit) {
        int offset = (page - 1) * limit;
        MapSqlParameterSource params = new MapSqlParameterSource();
        String whereExtra = "";
        if (search != null && !search.isBlank()) {
            params.addValue("like", "%" + search + "%");
            whereExtra = " AND (e.nombres ILIKE :like OR e.apellidos ILIKE :like " +
                    "OR e.cedula ILIKE :like OR e.codigo_estudiante ILIKE :like)";
        }

        String countSql = "SELECT COUNT(*) FROM sga_principal.estudiantes e " +
                "WHERE UPPER(e.estado) IN ('ACTIVO','ACTIVA')" + whereExtra;
        Long total = jdbc.queryForObject(countSql, params, Long.class);

        params.addValue("limit", limit);
        params.addValue("offset", offset);
        String sql = """
                SELECT e.id_estudiante, e.cedula, e.codigo_estudiante,
                       e.nombres, e.apellidos, e.fecha_nacimiento, e.genero,
                       e.correo, e.telefono, e.discapacidad, e.estado,
                       r.nombres  AS rep_nombres,
                       r.apellidos AS rep_apellidos,
                       r.telefono_principal AS rep_telefono,
                       r.parentesco
                FROM sga_principal.estudiantes e
                LEFT JOIN sga_principal.representantes r ON r.id_representante = e.id_representante
                WHERE UPPER(e.estado) IN ('ACTIVO','ACTIVA')%s
                ORDER BY e.apellidos, e.nombres
                LIMIT :limit OFFSET :offset
                """.formatted(whereExtra);
        List<Map<String, Object>> data = jdbc.query(sql, params, GenericRowMapper.INSTANCE);
        data.forEach(this::posprocesar);

        return PageResult.of(data, total == null ? 0 : total, page, limit);
    }

    public Map<String, Object> obtenerPorId(long id) {
        String sql = """
                SELECT e.*,
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
                WHERE e.id_estudiante = :id
                """;
        List<Map<String, Object>> rows = jdbc.query(sql, new MapSqlParameterSource("id", id), GenericRowMapper.INSTANCE);
        if (rows.isEmpty()) throw ApiException.notFound("Estudiante no encontrado");
        return posprocesar(rows.get(0));
    }

    public Map<String, Object> crear(EstudianteRequest dto, String username) {
        String cedula = blankToNull(dto.cedula());
        if (cedula != null) {
            List<Map<String, Object>> dup = jdbc.query(
                    "SELECT id_estudiante FROM sga_principal.estudiantes WHERE cedula = :cedula",
                    new MapSqlParameterSource("cedula", cedula), GenericRowMapper.INSTANCE);
            if (!dup.isEmpty()) throw ApiException.conflict("Ya existe un estudiante con esa cédula");
        }

        List<Long> creadorIds = jdbc.query(
                "SELECT id_usuario FROM sga_principal.usuarios WHERE username = :username",
                new MapSqlParameterSource("username", username),
                (rs, n) -> rs.getLong("id_usuario"));
        Long creadoPor = creadorIds.isEmpty() ? null : creadorIds.get(0);

        List<String> ultimoCodigo = jdbc.query(
                "SELECT codigo_estudiante FROM sga_principal.estudiantes " +
                        "WHERE codigo_estudiante IS NOT NULL ORDER BY id_estudiante DESC LIMIT 1",
                (rs, n) -> rs.getString("codigo_estudiante"));
        String codigo = "EST-0001";
        if (!ultimoCodigo.isEmpty() && ultimoCodigo.get(0) != null) {
            String[] parts = ultimoCodigo.get(0).split("-");
            int num = 0;
            if (parts.length > 1) {
                try {
                    num = Integer.parseInt(parts[1]);
                } catch (NumberFormatException ignored) {
                    // deja num en 0, igual que parseInt(NaN) || 0 en Node
                }
            }
            codigo = "EST-%04d".formatted(num + 1);
        }

        MapSqlParameterSource params = new MapSqlParameterSource()
                .addValue("cedula", cedula)
                .addValue("codigo", codigo)
                .addValue("nombres", dto.nombres())
                .addValue("apellidos", dto.apellidos())
                .addValue("fecha_nacimiento", parseDate(dto.fecha_nacimiento()))
                .addValue("genero", blankToNull(dto.genero()))
                .addValue("direccion", crypto.encrypt(blankToNull(dto.direccion())))
                .addValue("telefono", crypto.encrypt(blankToNull(dto.telefono())))
                .addValue("correo", blankToNull(dto.correo()))
                .addValue("discapacidad", dto.discapacidad() != null && dto.discapacidad())
                .addValue("tipo_discapacidad", crypto.encrypt(blankToNull(dto.tipo_discapacidad())))
                .addValue("porcentaje_disc", dto.porcentaje_disc())
                .addValue("id_representante", dto.id_representante())
                .addValue("creado_por", creadoPor);

        // Nota: se agrega ::sga_principal.genero_t (ausente en el SQL Node original) porque
        // PgJDBC es mas estricto que el driver pg de Node con tipos custom en INSERT.
        String insertSql = """
                INSERT INTO sga_principal.estudiantes
                  (cedula, codigo_estudiante, nombres, apellidos, fecha_nacimiento,
                   genero, direccion, telefono, correo, discapacidad,
                   tipo_discapacidad, porcentaje_disc, id_representante, creado_por, estado)
                VALUES (:cedula, :codigo, :nombres, :apellidos, :fecha_nacimiento,
                        :genero::sga_principal.genero_t, :direccion, :telefono, :correo, :discapacidad,
                        :tipo_discapacidad, :porcentaje_disc, :id_representante, :creado_por, 'ACTIVO')
                RETURNING *
                """;
        return posprocesar(jdbc.query(insertSql, params, GenericRowMapper.INSTANCE).get(0));
    }

    public Map<String, Object> actualizar(long id, EstudianteRequest dto) {
        obtenerPorId(id);

        MapSqlParameterSource params = new MapSqlParameterSource()
                .addValue("cedula", blankToNull(dto.cedula()))
                .addValue("nombres", blankToNull(dto.nombres()))
                .addValue("apellidos", blankToNull(dto.apellidos()))
                .addValue("fecha_nacimiento", parseDate(dto.fecha_nacimiento()))
                .addValue("genero", blankToNull(dto.genero()))
                .addValue("direccion", crypto.encrypt(blankToNull(dto.direccion())))
                .addValue("telefono", crypto.encrypt(blankToNull(dto.telefono())))
                .addValue("correo", blankToNull(dto.correo()))
                .addValue("discapacidad", dto.discapacidad())
                .addValue("tipo_discapacidad", crypto.encrypt(blankToNull(dto.tipo_discapacidad())))
                .addValue("porcentaje_disc", dto.porcentaje_disc())
                .addValue("id_representante", dto.id_representante())
                .addValue("id", id);

        String sql = """
                UPDATE sga_principal.estudiantes SET
                  cedula             = COALESCE(:cedula, cedula),
                  nombres            = COALESCE(:nombres, nombres),
                  apellidos          = COALESCE(:apellidos, apellidos),
                  fecha_nacimiento   = COALESCE(:fecha_nacimiento, fecha_nacimiento),
                  genero             = COALESCE(:genero::sga_principal.genero_t, genero),
                  direccion          = COALESCE(:direccion, direccion),
                  telefono           = COALESCE(:telefono, telefono),
                  correo             = COALESCE(:correo, correo),
                  discapacidad       = COALESCE(:discapacidad, discapacidad),
                  tipo_discapacidad  = COALESCE(:tipo_discapacidad, tipo_discapacidad),
                  porcentaje_disc    = COALESCE(:porcentaje_disc, porcentaje_disc),
                  id_representante   = COALESCE(:id_representante, id_representante),
                  fecha_actualizacion = NOW()
                WHERE id_estudiante = :id
                RETURNING *
                """;
        return posprocesar(jdbc.query(sql, params, GenericRowMapper.INSTANCE).get(0));
    }

    public void cambiarEstado(long id, boolean estado) {
        obtenerPorId(id);
        jdbc.update(
                "UPDATE sga_principal.estudiantes SET estado = :estado, fecha_actualizacion = NOW() " +
                        "WHERE id_estudiante = :id",
                new MapSqlParameterSource().addValue("estado", estado ? "ACTIVO" : "INACTIVO").addValue("id", id));
    }

    private static String blankToNull(String value) {
        return (value == null || value.isBlank()) ? null : value;
    }

    private static LocalDate parseDate(String value) {
        return (value == null || value.isBlank()) ? null : LocalDate.parse(value);
    }
}
