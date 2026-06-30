import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import Login from './pages/Login';
import Dashboard from './pages/Dashboard';
import Estudiantes from './pages/Estudiantes';
import Matriculas from './pages/Matriculas';
import Usuarios from './pages/Usuarios';
import { Reportes, Historial, CambiarPassword } from './pages/Extras';

function PrivateRoute({ children }) {
  const token = localStorage.getItem('token');
  return token ? children : <Navigate to="/login" replace />;
}

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Navigate to="/login" replace />} />
        <Route path="/login" element={<Login />} />
        <Route path="/dashboard" element={<PrivateRoute><Dashboard /></PrivateRoute>} />
        <Route path="/estudiantes" element={<PrivateRoute><Estudiantes /></PrivateRoute>} />
        <Route path="/matriculas" element={<PrivateRoute><Matriculas /></PrivateRoute>} />
        <Route path="/usuarios" element={<PrivateRoute><Usuarios /></PrivateRoute>} />
        <Route path="/historial" element={<PrivateRoute><Historial /></PrivateRoute>} />
        <Route path="/reportes" element={<PrivateRoute><Reportes /></PrivateRoute>} />
        <Route path="/cambiar-password" element={<PrivateRoute><CambiarPassword /></PrivateRoute>} />
        <Route path="*" element={<Navigate to="/dashboard" replace />} />
      </Routes>
    </BrowserRouter>
  );
}
