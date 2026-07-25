import { useState, useEffect } from "react";
import Layout from "../../components/Layout";
import {
  getMisAsignaciones,
  getActividades,
  getEstudiantesPorAsignacion,
  registrarCalificacion,
  getPromedioFormativo,
  getPromedioFinal,
} from "../../services/api";

const PRIMARY = "#243A76";

const menuCalificaciones = [
  {
    id: "registrar",
    label: "Registrar Notas",
    icon: (
      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
      </svg>
    ),
  },
  {
    id: "consolidado",
    label: "Consolidado",
    icon: (
      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 17v-2m3 2v-4m3 4v-6m2 10H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
      </svg>
    ),
  },
];

export default function Calificaciones() {
  const [seccion, setSeccion] = useState("registrar");
  const [asignaciones, setAsignaciones] = useState([]);
  const [asignacionSel, setAsignacionSel] = useState("");
  const [trimestre, setTrimestre] = useState(1);
  const [actividades, setActividades] = useState([]);
  const [actividadSel, setActividadSel] = useState("");
  const [estudiantes, setEstudiantes] = useState([]);
  const [notas, setNotas] = useState({});
  const [consolidado, setConsolidado] = useState([]);
  const [loading, setLoading] = useState(false);
  const [guardando, setGuardando] = useState(false);
  const [mensaje, setMensaje] = useState(null);

  useEffect(() => {
    cargarInicial();
  }, []);

  useEffect(() => {
    if (asignacionSel) {
      cargarActividades(asignacionSel);
      cargarEstudiantes(asignacionSel);
    }
  }, [asignacionSel]);

  const cargarInicial = async () => {
    try {
      const res = await getMisAsignaciones();
      setAsignaciones(res.data || []);
      if (res.data?.length > 0) setAsignacionSel(String(res.data[0].idAsignacion));
    } catch (error) {
      console.error("Error cargando asignaciones:", error);
    }
  };

  const cargarActividades = async (idAsignacion) => {
    try {
      const res = await getActividades(idAsignacion);
      const data = Array.isArray(res.data) ? res.data : (res.data?.actividades || []);
      setActividades(data);
      if (data.length > 0) setActividadSel(String(data[0].idActividad));
    } catch (error) {
      console.error("Error cargando actividades:", error);
      setActividades([]);
    }
  };

  const cargarEstudiantes = async (idAsignacion) => {
    try {
      setLoading(true);
      const res = await getEstudiantesPorAsignacion(idAsignacion);
      setEstudiantes(res.data || []);
    } catch (error) {
      console.error("Error cargando estudiantes:", error);
      setEstudiantes([]);
    } finally {
      setLoading(false);
    }
  };

  const handleNota = (idMatricula, valor) => {
    setNotas({ ...notas, [idMatricula]: valor });
  };

  const handleGuardar = async () => {
    if (!actividadSel) {
      setMensaje({ tipo: "error", texto: "Seleccione una actividad." });
      return;
    }
    setGuardando(true);
    setMensaje(null);
    try {
      const pendientes = estudiantes.filter((e) => notas[e.idMatricula] !== undefined && notas[e.idMatricula] !== "");
      for (const est of pendientes) {
        await registrarCalificacion({
          idMatricula: est.idMatricula,
          idActividad: parseInt(actividadSel),
          nota: parseFloat(notas[est.idMatricula]),
          trimestre: parseInt(trimestre),
        });
      }
      setMensaje({ tipo: "ok", texto: `Se registraron ${pendientes.length} calificaciones.` });
      setNotas({});
    } catch (error) {
      console.error("Error registrando calificaciones:", error);
      setMensaje({ tipo: "error", texto: "No se pudieron guardar las calificaciones." });
    } finally {
      setGuardando(false);
    }
  };

  const cargarConsolidado = async () => {
    setLoading(true);
    try {
      const filas = [];
      for (const est of estudiantes) {
        let formativo = 0, final = 0;
        try {
          const [f, fn] = await Promise.all([
            getPromedioFormativo(est.idMatricula, trimestre),
            getPromedioFinal(est.idMatricula, trimestre),
          ]);
          formativo = f.data ?? 0;
          final = fn.data ?? 0;
        } catch (e) {
          // sin notas aún
        }
        filas.push({ ...est, formativo, final });
      }
      setConsolidado(filas);
    } catch (error) {
      console.error("Error cargando consolidado:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (seccion === "consolidado" && estudiantes.length > 0) cargarConsolidado();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [seccion, trimestre, estudiantes]);

  const nombreAsignacion = (a) =>
    `${a.asignatura?.nombre || "Asignatura"} — ${a.grado?.nombre || ""}`;

  const nombreEstudiante = (e) =>
    `${e.estudiante?.apellidos || ""} ${e.estudiante?.nombres || ""}`.trim();

  return (
    <Layout
      breadcrumb={["Inicio", "Calificaciones"]}
      sidebarTitle="CALIFICACIONES"
      menuItems={menuCalificaciones}
      seccion={seccion}
      onSeccionChange={setSeccion}
    >
      <h1 className="text-2xl font-bold text-slate-800 mb-1">Calificaciones</h1>
      <p className="text-slate-500 mb-6">Registre y consulte las calificaciones de sus estudiantes.</p>

      {mensaje && (
        <div className={`mb-4 px-4 py-2 rounded-lg text-sm ${
          mensaje.tipo === "ok" ? "bg-green-50 text-green-700 border border-green-200" : "bg-red-50 text-red-700 border border-red-200"
        }`}>
          {mensaje.texto}
        </div>
      )}

      {/* Filtros comunes */}
      <div className="bg-white p-4 rounded-xl border border-slate-200 mb-4 grid grid-cols-1 md:grid-cols-3 gap-4">
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
        <div>
          <label className="block text-xs font-semibold text-slate-500 mb-1 uppercase tracking-wide">Trimestre</label>
          <select
            value={trimestre}
            onChange={(e) => setTrimestre(parseInt(e.target.value))}
            className="w-full border border-slate-200 rounded-lg px-3 py-2 text-sm bg-slate-50 focus:outline-none"
          >
            <option value={1}>Primer Trimestre</option>
            <option value={2}>Segundo Trimestre</option>
            <option value={3}>Tercer Trimestre</option>
          </select>
        </div>
        {seccion === "registrar" && (
          <div>
            <label className="block text-xs font-semibold text-slate-500 mb-1 uppercase tracking-wide">Actividad</label>
            <select
              value={actividadSel}
              onChange={(e) => setActividadSel(e.target.value)}
              className="w-full border border-slate-200 rounded-lg px-3 py-2 text-sm bg-slate-50 focus:outline-none"
            >
              {actividades.length === 0 && <option value="">Sin actividades</option>}
              {actividades.map((act) => (
                <option key={act.idActividad} value={act.idActividad}>{act.nombre}</option>
              ))}
            </select>
          </div>
        )}
      </div>

      {/* SECCIÓN: REGISTRAR NOTAS */}
      {seccion === "registrar" && (
        <div className="bg-white rounded-xl border border-slate-200 overflow-hidden">
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
                    <th className="text-left px-4 py-3">Cédula</th>
                    <th className="text-center px-4 py-3">Nota</th>
                  </tr>
                </thead>
                <tbody>
                  {estudiantes.map((est) => (
                    <tr key={est.idMatricula} className="border-t border-slate-100 hover:bg-slate-50">
                      <td className="px-4 py-3 font-medium text-slate-700">{nombreEstudiante(est)}</td>
                      <td className="px-4 py-3 text-slate-500">{est.estudiante?.cedula}</td>
                      <td className="px-4 py-3 text-center">
                        <input
                          type="number"
                          step="0.01"
                          min="0"
                          max="10"
                          value={notas[est.idMatricula] ?? ""}
                          onChange={(e) => handleNota(est.idMatricula, e.target.value)}
                          className="w-20 border border-slate-200 rounded-lg px-2 py-1 text-sm text-center bg-slate-50"
                          placeholder="0.00"
                        />
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
                  {guardando ? "Guardando..." : "Guardar Notas"}
                </button>
              </div>
            </>
          )}
        </div>
      )}

      {/* SECCIÓN: CONSOLIDADO */}
      {seccion === "consolidado" && (
        <div className="bg-white rounded-xl border border-slate-200 overflow-hidden">
          {loading ? (
            <p className="text-center text-slate-400 py-10">Calculando promedios...</p>
          ) : consolidado.length === 0 ? (
            <p className="text-center text-slate-400 py-10">No hay estudiantes en este curso.</p>
          ) : (
            <table className="w-full text-sm">
              <thead>
                <tr className="bg-slate-50 text-slate-500 text-xs uppercase tracking-wide">
                  <th className="text-left px-4 py-3">Estudiante</th>
                  <th className="text-center px-4 py-3">Prom. Formativo (70%)</th>
                  <th className="text-center px-4 py-3">Prom. Final</th>
                </tr>
              </thead>
              <tbody>
                {consolidado.map((est) => (
                  <tr key={est.idMatricula} className="border-t border-slate-100 hover:bg-slate-50">
                    <td className="px-4 py-3 font-medium text-slate-700">{nombreEstudiante(est)}</td>
                    <td className="px-4 py-3 text-center text-slate-600">{Number(est.formativo).toFixed(2)}</td>
                    <td className="px-4 py-3 text-center font-semibold" style={{ color: PRIMARY }}>{Number(est.final).toFixed(2)}</td>
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
