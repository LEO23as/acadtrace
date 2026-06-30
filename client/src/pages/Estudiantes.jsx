import { useState, useEffect, useCallback } from 'react';
import Layout from '../components/Layout';
import api from '../utils/api';

const PRIMARY = '#243A76';

const EMPTY = {
  cedula: '', nombres: '', apellidos: '', fecha_nacimiento: '',
  genero: '', correo: '', telefono: '', direccion: '',
  discapacidad: false, tipo_discapacidad: '', porcentaje_disc: '',
};

export default function Estudiantes() {
  const [estudiantes, setEstudiantes] = useState([]);
  const [meta, setMeta] = useState({});
  const [search, setSearch] = useState('');
  const [page, setPage] = useState(1);
  const [loading, setLoading] = useState(false);
  const [modal, setModal] = useState(null);
  const [selected, setSelected] = useState(null);
  const [form, setForm] = useState(EMPTY);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');

  const cargar = useCallback(async () => {
    setLoading(true);
    try {
      const res = await api.get('/estudiantes', {
        params: { q: search || undefined, page, limit: 15 },
      });
      setEstudiantes(res.data.data || []);
      setMeta(res.data.meta || {});
    } catch (e) {
      console.error('Error cargando estudiantes:', e);
    } finally {
      setLoading(false);
    }
  }, [search, page]);

  useEffect(() => { cargar(); }, [cargar]);

  const abrirCrear = () => { setForm(EMPTY); setError(''); setModal('crear'); };

  const abrirEditar = (e) => {
    setSelected(e);
    setForm({
      cedula: e.cedula || '',
      nombres: e.nombres || '',
      apellidos: e.apellidos || '',
      fecha_nacimiento: e.fecha_nacimiento ? e.fecha_nacimiento.split('T')[0] : '',
      genero: e.genero || '',
      correo: e.correo || '',
      telefono: e.telefono || '',
      direccion: e.direccion || '',
      discapacidad: e.discapacidad || false,
      tipo_discapacidad: e.tipo_discapacidad || '',
      porcentaje_disc: e.porcentaje_disc || '',
    });
    setError('');
    setModal('editar');
  };

  const abrirVer = async (id) => {
    try {
      const res = await api.get(`/estudiantes/${id}`);
      setSelected(res.data);
      setModal('ver');
    } catch (e) {
      console.error('Error cargando detalle:', e);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setSaving(true);
    setError('');
    try {
      if (modal === 'crear') {
        await api.post('/estudiantes', form);
      } else {
        await api.put(`/estudiantes/${selected.id_estudiante}`, form);
      }
      setModal(null);
      cargar();
    } catch (err) {
      setError(err.response?.data?.error || err.response?.data?.detalles?.[0]?.mensaje || 'Error al guardar');
    } finally {
      setSaving(false);
    }
  };

  const cambiarEstado = async (id, estadoActual) => {
    // En la BD: estado es boolean (true/false)
    try {
      await api.patch(`/estudiantes/${id}/estado`, { estado: !estadoActual });
      cargar();
    } catch (e) {
      console.error('Error cambiando estado:', e);
    }
  };

  // estado en la BD es boolean
  const esActivo = (e) => e.estado === true || e.estado === 'true';

  return (
    <Layout breadcrumb={['Inicio', 'Estudiantes']}>
      <div className="flex items-center justify-between mb-4">
        <div>
          <h1 className="text-base font-bold text-slate-700">Estudiantes</h1>
          <p className="text-xs text-slate-400">Registro y gestión de estudiantes</p>
        </div>
        <button onClick={abrirCrear} style={{ backgroundColor: PRIMARY }}
          className="flex items-center gap-2 text-white text-sm px-4 py-2 rounded-lg hover:opacity-90 transition shadow-sm">
          <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
          </svg>
          Nuevo estudiante
        </button>
      </div>

      {/* Buscador */}
      <div className="bg-white border border-slate-200 rounded-xl p-3 mb-4">
        <div className="relative">
          <svg className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
          </svg>
          <input value={search} onChange={e => { setSearch(e.target.value); setPage(1); }}
            placeholder="Buscar por nombre, apellido o cédula..."
            className="w-full pl-9 pr-4 py-2 text-sm border border-slate-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 bg-slate-50" />
        </div>
      </div>

      {/* Tabla */}
      <div className="bg-white border border-slate-200 rounded-xl overflow-hidden">
        <table className="w-full text-sm">
          <thead>
            <tr style={{ backgroundColor: PRIMARY }} className="text-white text-xs">
              <th className="px-4 py-3 text-left">Código</th>
              <th className="px-4 py-3 text-left">Apellidos y Nombres</th>
              <th className="px-4 py-3 text-left">Cédula</th>
              <th className="px-4 py-3 text-left">Teléfono</th>
              <th className="px-4 py-3 text-center">Estado</th>
              <th className="px-4 py-3 text-center">Acciones</th>
            </tr>
          </thead>
          <tbody>
            {loading ? (
              <tr><td colSpan={6} className="text-center py-12">
                <div className="flex items-center justify-center gap-2 text-slate-400">
                  <svg className="w-5 h-5 animate-spin" fill="none" viewBox="0 0 24 24">
                    <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"/>
                    <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"/>
                  </svg>
                  <span className="text-sm">Cargando...</span>
                </div>
              </td></tr>
            ) : estudiantes.length === 0 ? (
              <tr><td colSpan={6} className="text-center py-12 text-slate-400 text-sm">
                {search ? `No se encontraron resultados para "${search}"` : 'No hay estudiantes registrados'}
              </td></tr>
            ) : estudiantes.map((e, i) => (
              <tr key={e.id_estudiante}
                className={`border-t border-slate-100 ${i % 2 === 1 ? 'bg-slate-50/40' : ''} hover:bg-blue-50/30 transition`}>
                <td className="px-4 py-2.5 text-xs text-slate-400 font-mono">{e.codigo_estudiante || '—'}</td>
                <td className="px-4 py-2.5 font-medium text-slate-700">{e.apellidos}, {e.nombres}</td>
                <td className="px-4 py-2.5 text-slate-500">{e.cedula || '—'}</td>
                <td className="px-4 py-2.5 text-slate-500">{e.telefono || '—'}</td>
                <td className="px-4 py-2.5 text-center">
                  <span className={`inline-flex px-2 py-0.5 rounded-full text-xs font-medium ${esActivo(e) ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-600'}`}>
                    {esActivo(e) ? 'Activo' : 'Inactivo'}
                  </span>
                </td>
                <td className="px-4 py-2.5 text-center">
                  <div className="flex items-center justify-center gap-1">
                    <button onClick={() => abrirVer(e.id_estudiante)} title="Ver detalle"
                      className="p-1.5 rounded-lg text-slate-400 hover:text-blue-600 hover:bg-blue-50 transition">
                      <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                      </svg>
                    </button>
                    <button onClick={() => abrirEditar(e)} title="Editar"
                      className="p-1.5 rounded-lg text-slate-400 hover:text-amber-600 hover:bg-amber-50 transition">
                      <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                      </svg>
                    </button>
                    <button onClick={() => cambiarEstado(e.id_estudiante, esActivo(e))}
                      title={esActivo(e) ? 'Desactivar' : 'Activar'}
                      className={`p-1.5 rounded-lg transition ${esActivo(e) ? 'text-slate-400 hover:text-red-500 hover:bg-red-50' : 'text-slate-400 hover:text-green-600 hover:bg-green-50'}`}>
                      {esActivo(e)
                        ? <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                        : <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                      }
                    </button>
                  </div>
                </td>
              </tr>
            ))}
          </tbody>
        </table>

        {/* Paginación */}
        {meta.pages > 1 && (
          <div className="border-t border-slate-100 px-4 py-3 flex items-center justify-between text-xs text-slate-500">
            <span>{estudiantes.length} de {meta.total} estudiantes</span>
            <div className="flex gap-1">
              {Array.from({ length: meta.pages }, (_, i) => i + 1).map(p => (
                <button key={p} onClick={() => setPage(p)}
                  style={p === page ? { backgroundColor: PRIMARY, color: 'white' } : {}}
                  className={`w-7 h-7 rounded-lg text-xs font-medium transition ${p !== page ? 'hover:bg-slate-100' : ''}`}>
                  {p}
                </button>
              ))}
            </div>
          </div>
        )}
      </div>

      {/* MODAL CREAR/EDITAR */}
      {(modal === 'crear' || modal === 'editar') && (
        <div className="fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg max-h-[90vh] overflow-y-auto">
            <div style={{ backgroundColor: PRIMARY }} className="px-6 py-4 flex items-center justify-between rounded-t-2xl sticky top-0">
              <h2 className="text-white font-semibold text-sm">
                {modal === 'crear' ? 'Nuevo Estudiante' : `Editar: ${selected?.nombres} ${selected?.apellidos}`}
              </h2>
              <button onClick={() => setModal(null)} className="text-white/70 hover:text-white transition">
                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" /></svg>
              </button>
            </div>
            <form onSubmit={handleSubmit} className="p-6 space-y-4">
              <div className="grid grid-cols-2 gap-3">
                {[
                  { label: 'Nombres *', name: 'nombres', required: true },
                  { label: 'Apellidos *', name: 'apellidos', required: true },
                  { label: 'Cédula', name: 'cedula' },
                  { label: 'Teléfono', name: 'telefono' },
                  { label: 'Correo electrónico', name: 'correo', type: 'email' },
                  { label: 'Fecha de nacimiento', name: 'fecha_nacimiento', type: 'date' },
                ].map(f => (
                  <div key={f.name}>
                    <label className="block text-xs font-semibold text-slate-500 mb-1">{f.label}</label>
                    <input type={f.type || 'text'} required={f.required}
                      value={form[f.name]} onChange={e => setForm({ ...form, [f.name]: e.target.value })}
                      className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 bg-slate-50" />
                  </div>
                ))}
              </div>
              <div>
                <label className="block text-xs font-semibold text-slate-500 mb-1">Género</label>
                <select value={form.genero} onChange={e => setForm({ ...form, genero: e.target.value })}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 bg-slate-50">
                  <option value="">— Seleccionar —</option>
                  <option value="MASCULINO">Masculino</option>
                  <option value="FEMENINO">Femenino</option>
                  <option value="OTRO">Otro</option>
                </select>
              </div>
              <div>
                <label className="block text-xs font-semibold text-slate-500 mb-1">Dirección</label>
                <input value={form.direccion} onChange={e => setForm({ ...form, direccion: e.target.value })}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 bg-slate-50" />
              </div>
              <label className="flex items-center gap-2 cursor-pointer select-none">
                <input type="checkbox" checked={form.discapacidad}
                  onChange={e => setForm({ ...form, discapacidad: e.target.checked })} className="rounded" />
                <span className="text-sm text-slate-600">Tiene discapacidad</span>
              </label>
              {form.discapacidad && (
                <div className="grid grid-cols-2 gap-3">
                  <div>
                    <label className="block text-xs font-semibold text-slate-500 mb-1">Tipo de discapacidad</label>
                    <input value={form.tipo_discapacidad} onChange={e => setForm({ ...form, tipo_discapacidad: e.target.value })}
                      className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 bg-slate-50" />
                  </div>
                  <div>
                    <label className="block text-xs font-semibold text-slate-500 mb-1">Porcentaje (%)</label>
                    <input type="number" min="0" max="100" value={form.porcentaje_disc}
                      onChange={e => setForm({ ...form, porcentaje_disc: e.target.value })}
                      className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 bg-slate-50" />
                  </div>
                </div>
              )}
              {error && <div className="bg-red-50 border border-red-200 text-red-600 text-xs px-3 py-2 rounded-lg">{error}</div>}
              <div className="flex gap-3 pt-2">
                <button type="button" onClick={() => setModal(null)}
                  className="flex-1 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-600 hover:bg-slate-50 transition">Cancelar</button>
                <button type="submit" disabled={saving} style={{ backgroundColor: PRIMARY }}
                  className="flex-1 py-2.5 rounded-lg text-sm text-white font-semibold hover:opacity-90 transition disabled:opacity-60">
                  {saving ? 'Guardando...' : 'Guardar'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* MODAL VER */}
      {modal === 'ver' && selected && (
        <div className="fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg max-h-[90vh] overflow-y-auto">
            <div style={{ backgroundColor: PRIMARY }} className="px-6 py-4 flex items-center justify-between rounded-t-2xl">
              <h2 className="text-white font-semibold text-sm">Ficha del Estudiante</h2>
              <button onClick={() => setModal(null)} className="text-white/70 hover:text-white">
                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" /></svg>
              </button>
            </div>
            <div className="p-6 space-y-3">
              <div className="text-center mb-5">
                <div className="w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-2" style={{ backgroundColor: '#e8edf7' }}>
                  <span style={{ color: PRIMARY }} className="text-2xl font-bold">{selected.nombres?.charAt(0)}</span>
                </div>
                <p className="font-bold text-slate-700 text-base">{selected.nombres} {selected.apellidos}</p>
                <p className="text-xs text-slate-400 font-mono mt-0.5">{selected.codigo_estudiante || 'Sin código'}</p>
              </div>
              {[
                ['Cédula', selected.cedula],
                ['Fecha de nacimiento', selected.fecha_nacimiento ? new Date(selected.fecha_nacimiento).toLocaleDateString('es-EC') : null],
                ['Género', selected.genero],
                ['Teléfono', selected.telefono],
                ['Correo', selected.correo],
                ['Dirección', selected.direccion],
              ].filter(([, v]) => v).map(([k, v]) => (
                <div key={k} className="flex justify-between text-sm py-1.5 border-b border-slate-100 last:border-0">
                  <span className="text-slate-400 text-xs">{k}</span>
                  <span className="text-slate-700 font-medium text-xs text-right max-w-48">{v}</span>
                </div>
              ))}
              {selected.rep_nombres && (
                <div className="bg-slate-50 rounded-xl p-4 mt-3">
                  <p className="text-xs font-bold text-slate-400 mb-2 uppercase tracking-wide">Representante</p>
                  <p className="text-sm font-medium text-slate-700">{selected.rep_nombres} {selected.rep_apellidos}</p>
                  <p className="text-xs text-slate-500 mt-0.5">{selected.parentesco} · {selected.rep_telefono}</p>
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </Layout>
  );
}
