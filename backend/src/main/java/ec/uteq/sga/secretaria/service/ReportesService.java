package ec.uteq.sga.secretaria.service;

import ec.uteq.sga.secretaria.common.jdbc.GenericRowMapper;
import ec.uteq.sga.secretaria.pdf.CertificadoMatriculaPdfBuilder;
import ec.uteq.sga.secretaria.pdf.FichaEstudiantePdfBuilder;
import ec.uteq.sga.secretaria.pdf.NominaMatriculasPdfBuilder;
import ec.uteq.sga.secretaria.pdf.PdfTheme;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReportesService {

    private final NamedParameterJdbcTemplate jdbc;
    private final EstudianteService estudianteService;
    private final MatriculaService matriculaService;
    private final PdfTheme theme;

    public ReportesService(NamedParameterJdbcTemplate jdbc, EstudianteService estudianteService,
                            MatriculaService matriculaService, PdfTheme theme) {
        this.jdbc = jdbc;
        this.estudianteService = estudianteService;
        this.matriculaService = matriculaService;
        this.theme = theme;
    }

    public byte[] certificadoMatricula(long idMatricula) throws IOException {
        Map<String, Object> matricula = matriculaService.obtenerPorId(idMatricula);
        return CertificadoMatriculaPdfBuilder.build(matricula, theme);
    }

    public byte[] fichaEstudiante(long idEstudiante) throws IOException {
        Map<String, Object> estudiante = estudianteService.obtenerPorId(idEstudiante);
        return FichaEstudiantePdfBuilder.build(estudiante, theme);
    }

    public byte[] nominaMatriculas(long idAno, Long idGrado, Long idParalelo) throws IOException {
        MapSqlParameterSource params = new MapSqlParameterSource().addValue("idAno", idAno);
        String where = "WHERE m.id_ano_lectivo = :idAno";
        if (idGrado != null) {
            params.addValue("idGrado", idGrado);
            where += " AND m.id_grado = :idGrado";
        }
        if (idParalelo != null) {
            params.addValue("idParalelo", idParalelo);
            where += " AND m.id_paralelo = :idParalelo";
        }

        String sql = """
                SELECT m.numero_orden, m.fecha_registro, m.estado,
                       e.cedula, e.nombres || ' ' || e.apellidos AS estudiante,
                       g.nombre AS grado, p.letra AS paralelo
                FROM sga_principal.matriculas m
                JOIN sga_principal.estudiantes e ON e.id_estudiante = m.id_estudiante
                JOIN sga_principal.grados g ON g.id_grado = m.id_grado
                JOIN sga_principal.paralelos p ON p.id_paralelo = m.id_paralelo
                %s
                ORDER BY g.orden, p.letra, e.apellidos
                """.formatted(where);
        List<Map<String, Object>> matriculas = jdbc.query(sql, params, GenericRowMapper.INSTANCE);

        List<String> anoNombre = jdbc.query(
                "SELECT nombre FROM sga_principal.anos_lectivos WHERE id_ano_lectivo = :idAno",
                new MapSqlParameterSource("idAno", idAno), (rs, n) -> rs.getString("nombre"));

        String gradoNombre = "";
        if (idGrado != null) {
            List<String> rows = jdbc.query("SELECT nombre FROM sga_principal.grados WHERE id_grado = :id",
                    new MapSqlParameterSource("id", idGrado), (rs, n) -> rs.getString("nombre"));
            gradoNombre = rows.isEmpty() ? "" : rows.get(0);
        }
        String paraleloLetra = "";
        if (idParalelo != null) {
            List<String> rows = jdbc.query("SELECT letra FROM sga_principal.paralelos WHERE id_paralelo = :id",
                    new MapSqlParameterSource("id", idParalelo), (rs, n) -> rs.getString("letra"));
            paraleloLetra = rows.isEmpty() ? "" : rows.get(0);
        }

        return NominaMatriculasPdfBuilder.build(matriculas, anoNombre.isEmpty() ? "" : anoNombre.get(0),
                gradoNombre, paraleloLetra, theme);
    }

    public Map<String, Object> estadisticas(long idAno) {
        MapSqlParameterSource params = new MapSqlParameterSource("idAno", idAno);

        Map<String, Object> totales = jdbc.query("""
                SELECT COUNT(*) AS total,
                       COUNT(*) FILTER (WHERE m.estado = 'ACTIVA') AS activas,
                       COUNT(*) FILTER (WHERE m.estado = 'RETIRADA') AS retiradas,
                       COUNT(*) FILTER (WHERE e.discapacidad = true) AS con_discapacidad,
                       COUNT(*) FILTER (WHERE e.genero = 'MASCULINO') AS masculino,
                       COUNT(*) FILTER (WHERE e.genero = 'FEMENINO') AS femenino
                FROM sga_principal.matriculas m
                JOIN sga_principal.estudiantes e ON e.id_estudiante = m.id_estudiante
                WHERE m.id_ano_lectivo = :idAno
                """, params, GenericRowMapper.INSTANCE).get(0);

        List<Map<String, Object>> porGrado = jdbc.query("""
                SELECT g.nombre AS grado, g.orden,
                       COUNT(m.id_matricula) AS total
                FROM sga_principal.grados g
                LEFT JOIN sga_principal.matriculas m
                  ON m.id_grado = g.id_grado AND m.id_ano_lectivo = :idAno
                WHERE g.activo = true
                GROUP BY g.nombre, g.orden
                ORDER BY g.orden
                """, params, GenericRowMapper.INSTANCE);

        List<Map<String, Object>> porEstado = jdbc.query("""
                SELECT estado, COUNT(*) AS cantidad
                FROM sga_principal.matriculas WHERE id_ano_lectivo = :idAno
                GROUP BY estado
                """, params, GenericRowMapper.INSTANCE);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("totales", totales);
        result.put("por_grado", porGrado);
        result.put("por_estado", porEstado);
        return result;
    }
}
