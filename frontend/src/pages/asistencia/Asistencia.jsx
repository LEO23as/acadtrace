import { useState, useEffect } from "react";
import Layout from "../../components/Layout";
import {
  getMisAsignaciones,
  getEstudiantesPorAsignacion,
  getAsistenciaPorAsignacion,
  getResumenAsistencia,
  registrarAsistenciaGrupal,
} from "../../services/api";

const PRIMARY = "#243A76";

const ESTADOS = [
  { valor: "PRESENTE", label: "P", clase: "bg-green-100 text-green-700 border-green-300" },
  { valor: "AUSENTE", label: "A", clase: "bg-red-100 text-red-700 border-red-300" },
  { valor: "JUSTIFICADO", label: "J", clase: "bg-blue-100 text-blue-700 border-blue-300" },
  { valor: "ATRASO", label: "T", clase: "bg-amber-100 text-amber-700 border-amber-300" },
];

const menuAsistencia = [
  {
    id: "registrar",
    label: "Registrar Asistencia",
    icon: (
      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
      </svg>
    ),
  },
  {
    id: "resumen",
    label: "Resumen",
    icon: (
      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
      </svg>
    ),
  },
];

const hoy = () => new Date().toISOString().slice(0, 10);

export default function Asistencia() {
  const [seccion, setSeccion] = useState("registrar");
  const [asignaciones, setAsignaciones] = useState([]);
  const [asignacionSel, setAsignacionSel] = useState("");
  const [fecha, setFecha] = useState(hoy());
  const [estudiantes, setEstudiantes] = useState([]);
  const [estados, setEstados] = useState({});
  const [resumen, setResumen] = useState([]);
  const [loading, setLoading] = useState(false);
  const [guardando, setGuardando] = useState(false);
  const [mensaje, setMensaje] = useState(null);

  useEffect(() => {
    cargarInicial();
  }, []);

  useEffect(() => {
    if (asignacionSel) cargarEstudiantes(asignacionSel);
  }, [asignacionSel]);

  useEffect(() => {
    if (asignacionSel && estudiantes.length > 0) cargarAsistenciaDia();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [fecha, estudiantes]);

  useEffect(() => {
    if (seccion === "resumen" && asignacionSel) cargarResumen();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [seccion, asignacionSel]);

  const cargarInicial = async () => {
    try {
      const res = await getMisAsignaciones();
      setAsignaciones(res.data || []);
      if (res.data?.length > 0) setAsignacionSel(String(res.data[0].idAsignacion));
    } catch (error) {
      console.error("Error cargando asignaciones:", error);
    }
  };

  const cargarEstudiantes = async (idAsignacion) => {
    try {
      setLoading(true);
      const res = await getEstudiantesPorAsignacion(idAsignacion);
      setEstudiantes(res.data || []);
      // por defecto todos presentes
      const base = {};
      (res.data || []).forEach((e) => { base[e.idMatricula] = "PRESENTE"; });
      setEstados(base);
    } catch (error) {
      console.error("Error cargando estudiantes:", error);
      setEstudiantes([]);
    } finally {
      setLoading(false);
    }
  };

  const cargarAsistenciaDia = async () => {
    try {
      const res = await getAsistenciaPorAsignacion(asignacionSel, fecha);
      const registros = res.data?.asistencias || [];
      if (registros.length > 0) {
        const map = { ...estados };
        registros.forEach((a) => { map[a.id_matricula] = a.estado; });
        setEstados(map);
      }
    } catch (error) {
      console.error("Error cargando asistencia del día:", error);
    }
  };

  const cargarResumen = async () => {
    try {
      setLoading(true);
      const res = await getResumenAsistencia(asignacionSel);
      setResumen(res.data?.resumenes || []);
    } catch (error) {
      console.error("Error cargando resumen:", error);
      setResumen([]);
    } finally {
      setLoading(false);
    }
  };

  const setEstado = (idMatricula, valor) => {
    setEstados({ ...estados, [idMatricula]: valor });
  };

  const handleGuardar = async () => {
    setGuardando(true);
    setMensaje(null);
    try {
      const asistencias = estudiantes.map((e) => ({
        id_matricula: e.idMatricula,
        estado: estados[e.idMatricula] || "PRESENTE",
        justificacion: "",
      }));
      await registrarAsistenciaGrupal({
        id_asignacion: parseInt(asignacionSel),
        id_periodo: 0,
        fecha,
        asistencias,
      });
      setMensaje({ tipo: "ok", texto: "Asistencia registrada correctamente." });
    } catch (error) {
      console.error("Error registrando asistencia:", error);
      setMensaje({ tipo: "error", texto: "No se pudo registrar la asistencia." });
    } finally {
      setGuardando(false);
    }
  };

  const nombreAsignacion = (a) =>
    `${a.asignatura?.nombre || "Asignatura"} — ${a.grado?.nombre || ""}`;

  const nombreEstudiante = (e) =>
    `${e.estudiante?.apellidos || ""} ${e.estudiante?.nombres || ""}`.trim();

  return (
    <Layout
      breadcrumb={["Inicio", "Asistencia"]}
      sidebarTitle="ASISTENCIA"
      menuItems={menuAsistencia}
      seccion={seccion}
      onSeccionChange={setSeccion}
    >
      <h1 className="text-2xl font-bold text-slate-800 mb-1">Asistencia</h1>
      <p className="text-slate-500 mb-6">Registre y consulte la asistencia de sus estudiantes.</p>

      {mensaje && (
        <div className={`mb-4 px-4 py-2 rounded-lg text-sm ${
          mensaje.tipo === "ok" ? "bg-green-50 text-green-700 border border-green-200" : "bg-red-50 text-red-700 border border-red-200"
        }`}>
          {mensaje.texto}
        </div>
      )}

      {/* Filtros */}
      <div className="bg-white p-4 rounded-xl border border-slate-200 mb-4 grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <label className="block text-xs font-semibold text-slate-500 mb-1 uppercase tracking-wide">Curso</label>
          <select
            value={asignacionSel}
            onChange={(e) => setAsignacionSel(e.target.value)}
            className="w-full border border-slate-200 rounded-lg px-3 py-2 text-sm bg-slate-50 focus:outline-none"
          >
            {asignaciones.length === 0 && <option value="">Sin asignaciones</option>}
            {asignaciones.map((a) => (
              <option key={a.idAsignacion} value={a.idAsignacion}>{nombreAsignacion(a)}</option>
            ))}
          </select>
        </div>
        {seccion === "registrar" && (
          <div>
            <label className="block text-xs font-semibold text-slate-500 mb-1 uppercase tracking-wide">Fecha</label>
            <input
              type="date"
              value={fecha}
              onChange={(e) => setFecha(e.target.value)}
              className="w-full border border-slate-200 rounded-lg px-3 py-2 text-sm bg-slate-50 focus:outline-none"
            />
          </div>
        )}
      </div>

      {/* SECCIÓN: REGISTRAR */}
      {seccion === "registrar" && (
        <div className="bg-white rounded-xl border border-slate-200 overflow-hidden">
          <div className="px-4 py-2 bg-slate-50 border-b border-slate-100 text-xs text-slate-500">
            P = Presente &nbsp;·&nbsp; A = Ausente &nbsp;·&nbsp; J = Justificado &nbsp;·&nbsp; T = Atraso
          </div>
          {loading ? (
            <p className="text-center text-slate-400 py-10">Cargando estudiantes...</p>
          ) : estudiantes.length === 0 ? (
            <p className="text-center text-slate-400 py-10">No hay estudiantes en este curso.</p>
          ) : (
            <>
              <table className="w-full text-sm">
                <thead>
                  <tr className="bg-slate-50 text-slate-500 text-xs uppercase tracking-wide">
                    <th className="text-left px-4 py-3">Estudiante</th>
                    <th className="text-center px-4 py-3">Estado</th>
                  </tr>
                </thead>
                <tbody>
                  {estudiantes.map((est) => (
                    <tr key={est.idMatricula} className="border-t border-slate-100 hover:bg-slate-50">
                      <td className="px-4 py-3 font-medium text-slate-700">{nombreEstudiante(est)}</td>
                      <td className="px-4 py-3">
                        <div className="flex justify-center gap-1">
                          {ESTADOS.map((op) => (
                            <button
                              key={op.valor}
                              onClick={() => setEstado(est.idMatricula, op.valor)}
                              className={`w-8 h-8 rounded-lg border text-xs font-bold transition ${
                                estados[est.idMatricula] === op.valor
                                  ? op.clase
                                  : "bg-white text-slate-300 border-slate-200 hover:bg-slate-50"
                              }`}
                            >
                              {op.label}
                            </button>
                          ))}
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
              <div className="p-4 flex justify-end border-t border-slate-100">
                <button
                  onClick={handleGuardar}
                  disabled={guardando}
                  style={{ backgroundColor: PRIMARY }}
                  className="text-white px-5 py-2 rounded-lg text-sm font-medium hover:opacity-90 disabled:opacity-60"
                >
                  {guardando ? "Guardando..." : "Guardar Asistencia"}
                </button>
              </div>
            </>
          )}
        </div>
      )}

      {/* SECCIÓN: RESUMEN */}
      {seccion === "resumen" && (
        <div className="bg-white rounded-xl border border-slate-200 overflow-hidden">
          {loading ? (
            <p className="text-center text-slate-400 py-10">Cargando resumen...</p>
          ) : resumen.length === 0 ? (
            <p className="text-center text-slate-400 py-10">No hay datos de asistencia para este curso.</p>
          ) : (
            <table className="w-full text-sm">
              <thead>
                <tr className="bg-slate-50 text-slate-500 text-xs uppercase tracking-wide">
                  <th className="text-left px-4 py-3">Matrícula</th>
                  <th className="text-center px-4 py-3">Presentes</th>
                  <th className="text-center px-4 py-3">Ausentes</th>
                  <th className="text-center px-4 py-3">Justificados</th>
                  <th className="text-center px-4 py-3">Atrasos</th>
                  <th className="text-center px-4 py-3">% Asistencia</th>
                </tr>
              </thead>
              <tbody>
                {resumen.map((r) => (
                  <tr key={r.id_resumen || r.id_matricula} className="border-t border-slate-100 hover:bg-slate-50">
                    <td className="px-4 py-3 font-medium text-slate-700">#{r.id_matricula}</td>
                    <td className="px-4 py-3 text-center text-green-600">{r.total_presentes}</td>
                    <td className="px-4 py-3 text-center text-red-600">{r.total_ausentes}</td>
                    <td className="px-4 py-3 text-center text-blue-600">{r.total_justificados}</td>
                    <td className="px-4 py-3 text-center text-amber-600">{r.total_atrasos}</td>
                    <td className="px-4 py-3 text-center font-semibold" style={{ color: PRIMARY }}>
                      {Number(r.porcentaje_asistencia).toFixed(1)}%
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>
      )}
    </Layout>
  );
}
