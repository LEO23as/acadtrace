package ec.uteq.sga.secretaria.service;

import ec.uteq.sga.secretaria.common.ApiException;
import ec.uteq.sga.secretaria.common.PageResult;
import ec.uteq.sga.secretaria.common.jdbc.GenericRowMapper;
import ec.uteq.sga.secretaria.dto.MatriculaRequest;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class MatriculaService {

    private final NamedParameterJdbcTemplate jdbc;

    public MatriculaService(NamedParameterJdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public List<Map<String, Object>> paralelosPorGrado(long idGrado) {
        return jdbc.query(
                "SELECT id_paralelo, letra FROM sga_principal.paralelos WHERE id_grado = :idGrado AND activo = true ORDER BY letra",
                new MapSqlParameterSource("idGrado", idGrado), GenericRowMapper.INSTANCE);
    }

    public PageResult<Map<String, Object>> listarPorAnoLectivo(long idAnoLectivo, int page, int limit, String search) {
        int offset = (page - 1) * limit;
        MapSqlParameterSource params = new MapSqlParameterSource().addValue("idAno", idAnoLectivo);
        String where = "WHERE m.id_ano_lectivo = :idAno";
        if (search != null && !search.isBlank()) {
            params.addValue("like", "%" + search + "%");
            where += " AND (e.nombres ILIKE :like OR e.apellidos ILIKE :like OR e.cedula ILIKE :like)";
        }

        Long total = jdbc.queryForObject(
                "SELECT COUNT(*) FROM sga_principal.matriculas m " +
                        "JOIN sga_principal.estudiantes e ON e.id_estudiante = m.id_estudiante " + where,
                params, Long.class);

        params.addValue("limit", limit).addValue("offset", offset);
        String sql = """
                SELECT m.id_matricula, m.numero_orden, m.fecha_registro, m.estado, m.observaciones,
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
                %s
                ORDER BY g.orden, p.letra, e.apellidos
                LIMIT :limit OFFSET :offset
                """.formatted(where);
        List<Map<String, Object>> data = jdbc.query(sql, params, GenericRowMapper.INSTANCE);

        return PageResult.of(data, total == null ? 0 : total, page, limit);
    }

    public List<Map<String, Object>> estadisticasPorGrado(long idAnoLectivo) {
        String sql = """
                SELECT g.nombre AS grado, p.letra AS paralelo,
                       COUNT(m.id_matricula) AS total,
                       COUNT(m.id_matricula) FILTER (WHERE m.estado = 'ACTIVA') AS activas,
                       COUNT(m.id_matricula) FILTER (WHERE m.estado = 'RETIRADA') AS retiradas
                FROM sga_principal.grados g
                JOIN sga_principal.paralelos p ON p.id_grado = g.id_grado
                LEFT JOIN sga_principal.matriculas m
                  ON m.id_grado = g.id_grado AND m.id_paralelo = p.id_paralelo
                  AND m.id_ano_lectivo = :idAno
                WHERE g.activo = true AND p.activo = true
                GROUP BY g.nombre, g.orden, p.letra
                ORDER BY g.orden, p.letra
                """;
        return jdbc.query(sql, new MapSqlParameterSource("idAno", idAnoLectivo), GenericRowMapper.INSTANCE);
    }

    public List<Map<String, Object>> listarPorEstudiante(long idEstudiante) {
        String sql = """
                SELECT m.id_matricula, m.numero_orden, m.fecha_registro, m.estado,
                       g.nombre AS grado, p.letra AS paralelo,
                       al.nombre AS ano_lectivo, al.fecha_inicio, al.fecha_fin,
                       hp.resultado AS resultado_promocion, hp.promedio_anual
                FROM sga_principal.matriculas m
                JOIN sga_principal.grados g ON g.id_grado = m.id_grado
                JOIN sga_principal.paralelos p ON p.id_paralelo = m.id_paralelo
                JOIN sga_principal.anos_lectivos al ON al.id_ano_lectivo = m.id_ano_lectivo
                LEFT JOIN sga_principal.historial_promocion hp ON hp.id_matricula = m.id_matricula
                WHERE m.id_estudiante = :id
                ORDER BY al.fecha_inicio DESC
                """;
        return jdbc.query(sql, new MapSqlParameterSource("id", idEstudiante), GenericRowMapper.INSTANCE);
    }

    public Map<String, Object> obtenerPorId(long id) {
        String sql = """
                SELECT m.*,
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
                WHERE m.id_matricula = :id
                """;
        List<Map<String, Object>> rows = jdbc.query(sql, new MapSqlParameterSource("id", id), GenericRowMapper.INSTANCE);
        if (rows.isEmpty()) throw ApiException.notFound("Matrícula no encontrada");
        return rows.get(0);
    }

    public Map<String, Object> crear(MatriculaRequest dto, String username) {
        MapSqlParameterSource dupParams = new MapSqlParameterSource()
                .addValue("idEstudiante", dto.id_estudiante())
                .addValue("idAno", dto.id_ano_lectivo());
        List<Long> dup = jdbc.query(
                "SELECT id_matricula FROM sga_principal.matriculas WHERE id_estudiante = :idEstudiante AND id_ano_lectivo = :idAno",
                dupParams, (rs, n) -> rs.getLong("id_matricula"));
        if (!dup.isEmpty()) throw ApiException.conflict("El estudiante ya tiene matrícula en ese año lectivo");

        List<Long> userIds = jdbc.query(
                "SELECT id_usuario FROM sga_principal.usuarios WHERE username = :username",
                new MapSqlParameterSource("username", username), (rs, n) -> rs.getLong("id_usuario"));
        Long registradoPor = userIds.isEmpty() ? null : userIds.get(0);

        Integer maxOrden = jdbc.queryForObject(
                "SELECT COALESCE(MAX(numero_orden), 0) FROM sga_principal.matriculas WHERE id_ano_lectivo = :idAno",
                new MapSqlParameterSource("idAno", dto.id_ano_lectivo()), Integer.class);
        int numeroOrden = (maxOrden == null ? 0 : maxOrden) + 1;

        String estado = (dto.estado() == null || dto.estado().isBlank()) ? "ACTIVA" : dto.estado();
        String observaciones = (dto.observaciones() == null || dto.observaciones().isBlank()) ? null : dto.observaciones();

        MapSqlParameterSource insertParams = new MapSqlParameterSource()
                .addValue("idEstudiante", dto.id_estudiante())
                .addValue("idGrado", dto.id_grado())
                .addValue("idParalelo", dto.id_paralelo())
                .addValue("idAno", dto.id_ano_lectivo())
                .addValue("numeroOrden", numeroOrden)
                .addValue("estado", estado)
                .addValue("observaciones", observaciones)
                .addValue("registradoPor", registradoPor);

        // ::sga_principal.estado_matricula_t agregado por estrictez de PgJDBC (ver nota en EstudianteService)
        String insertSql = """
                INSERT INTO sga_principal.matriculas
                  (id_estudiante, id_grado, id_paralelo, id_ano_lectivo,
                   numero_orden, fecha_registro, estado, observaciones, registrado_por)
                VALUES (:idEstudiante, :idGrado, :idParalelo, :idAno, :numeroOrden, CURRENT_DATE,
                        :estado::sga_principal.estado_matricula_t, :observaciones, :registradoPor)
                RETURNING id_matricula
                """;
        Long newId = jdbc.queryForObject(insertSql, insertParams, Long.class);
        return obtenerPorId(newId);
    }

    public void cambiarEstado(long id, String estado) {
        obtenerPorId(id);
        jdbc.update(
                "UPDATE sga_principal.matriculas SET estado = :estado::sga_principal.estado_matricula_t WHERE id_matricula = :id",
                new MapSqlParameterSource().addValue("estado", estado).addValue("id", id));
    }
}
