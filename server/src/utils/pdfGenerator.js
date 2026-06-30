'use strict';

const PDFDocument = require('pdfkit');

const INST = {
  nombre: process.env.INST_NOMBRE || 'Unidad Educativa',
  ciudad: process.env.INST_CIUDAD || 'Ecuador',
};

// Colores institucionales
const COLOR = {
  primary: '#1a3a5c',
  secondary: '#2e86ab',
  accent: '#f5a623',
  light: '#f4f6f8',
  dark: '#2c3e50',
  text: '#333333',
  muted: '#6c757d',
  white: '#ffffff',
  border: '#dee2e6',
};

/**
 * Cabecera institucional común a todos los documentos.
 */
function drawHeader(doc, titulo, subtitulo = '') {
  // Fondo azul oscuro
  doc.rect(0, 0, doc.page.width, 90).fill(COLOR.primary);

  // Nombre institución
  doc.fillColor(COLOR.white)
    .fontSize(16)
    .font('Helvetica-Bold')
    .text(INST.nombre, 40, 22, { align: 'center', width: doc.page.width - 80 });

  // Título documento
  doc.fontSize(11)
    .font('Helvetica')
    .fillColor('#b8d4f0')
    .text(titulo.toUpperCase(), 40, 48, { align: 'center', width: doc.page.width - 80 });

  if (subtitulo) {
    doc.fontSize(9).fillColor('#90b8d8')
      .text(subtitulo, 40, 66, { align: 'center', width: doc.page.width - 80 });
  }

  // Línea acento
  doc.rect(0, 90, doc.page.width, 4).fill(COLOR.accent);

  doc.fillColor(COLOR.text);
  return 110; // y de inicio de contenido
}

/**
 * Pie de página con número de página y fecha.
 */
function drawFooter(doc) {
  const y = doc.page.height - 40;
  doc.rect(0, y - 8, doc.page.width, 1).fill(COLOR.border);
  doc.fontSize(8).fillColor(COLOR.muted)
    .text(
      `${INST.ciudad} — Generado el ${new Date().toLocaleDateString('es-EC', { dateStyle: 'long' })}`,
      40, y, { align: 'left' }
    )
    .text('Documento generado por SGA', 40, y, { align: 'right', width: doc.page.width - 80 });
}

/**
 * Dibuja una sección con título y fondo gris.
 */
function drawSectionTitle(doc, title, y) {
  doc.rect(40, y, doc.page.width - 80, 20).fill(COLOR.light);
  doc.rect(40, y, 4, 20).fill(COLOR.secondary);
  doc.fillColor(COLOR.primary).fontSize(10).font('Helvetica-Bold')
    .text(title, 50, y + 5);
  doc.font('Helvetica').fillColor(COLOR.text);
  return y + 28;
}

/**
 * Par clave-valor en dos columnas.
 */
function drawField(doc, label, value, x, y, labelWidth = 130) {
  doc.fontSize(9).font('Helvetica-Bold').fillColor(COLOR.muted)
    .text(label + ':', x, y, { width: labelWidth });
  doc.font('Helvetica').fillColor(COLOR.dark)
    .text(value || '—', x + labelWidth, y, { width: 180 });
}

// ══════════════════════════════════════════════
// CERTIFICADO DE MATRÍCULA
// ══════════════════════════════════════════════
function generarCertificadoMatricula(matricula) {
  const doc = new PDFDocument({ size: 'A4', margin: 0 });
  const y0 = drawHeader(doc, 'Certificado de Matrícula', `Año Lectivo ${matricula.ano_lectivo}`);

  let y = y0 + 10;

  // Intro
  doc.fontSize(10).fillColor(COLOR.text)
    .text(
      `La secretaría de ${INST.nombre} certifica que el/la estudiante cuyos datos se detallan a continuación se encuentra legalmente matriculado/a en esta institución educativa:`,
      40, y, { width: doc.page.width - 80, align: 'justify' }
    );
  y += 50;

  // Datos del estudiante
  y = drawSectionTitle(doc, 'DATOS DEL ESTUDIANTE', y);
  drawField(doc, 'Nombres completos', `${matricula.nombres_estudiante || matricula.estudiante}`, 40, y);
  drawField(doc, 'Cédula / Pasaporte', matricula.cedula, 320, y);
  y += 20;
  drawField(doc, 'Código estudiantil', matricula.codigo_estudiante, 40, y);
  y += 30;

  // Datos matrícula
  y = drawSectionTitle(doc, 'DATOS DE MATRÍCULA', y);
  drawField(doc, 'Año lectivo', matricula.ano_lectivo, 40, y);
  drawField(doc, 'Estado', matricula.estado, 320, y);
  y += 20;
  drawField(doc, 'Grado / Curso', `${matricula.grado} "${matricula.paralelo}"`, 40, y);
  drawField(doc, 'N° de matrícula', String(matricula.numero_orden || ''), 320, y);
  y += 20;
  drawField(doc, 'Fecha de matrícula',
    matricula.fecha_registro
      ? new Date(matricula.fecha_registro).toLocaleDateString('es-EC')
      : '', 40, y);
  y += 40;

  // Texto legal
  doc.rect(40, y, doc.page.width - 80, 1).fill(COLOR.border);
  y += 10;
  doc.fontSize(9).fillColor(COLOR.muted)
    .text(
      'El presente certificado se expide a petición del interesado/a para los fines legales que estime conveniente.',
      40, y, { width: doc.page.width - 80, align: 'center' }
    );
  y += 40;

  // Firma
  const firmaX = doc.page.width / 2 - 75;
  doc.rect(firmaX, y, 150, 1).fill(COLOR.dark);
  y += 6;
  doc.fontSize(9).fillColor(COLOR.dark).font('Helvetica-Bold')
    .text('Secretaría', firmaX, y, { width: 150, align: 'center' });
  doc.font('Helvetica').fillColor(COLOR.muted)
    .text(INST.nombre, firmaX, y + 12, { width: 150, align: 'center' });

  drawFooter(doc);
  doc.end();
  return doc;
}

// ══════════════════════════════════════════════
// REPORTE DE MATRÍCULA POR GRADO
// ══════════════════════════════════════════════
function generarReporteMatriculas(datos, { anoLectivo, grado, paralelo } = {}) {
  const doc = new PDFDocument({ size: 'A4', margin: 0, layout: 'landscape' });
  const titulo = 'Nómina de Estudiantes Matriculados';
  const subtitulo = [anoLectivo, grado, paralelo ? `Paralelo ${paralelo}` : ''].filter(Boolean).join(' · ');
  const y0 = drawHeader(doc, titulo, subtitulo);

  let y = y0 + 8;

  // Encabezado tabla
  const cols = [
    { label: 'N°', x: 40, w: 30 },
    { label: 'Cédula', x: 70, w: 80 },
    { label: 'Apellidos y Nombres', x: 150, w: 200 },
    { label: 'Grado', x: 350, w: 80 },
    { label: 'Paralelo', x: 430, w: 60 },
    { label: 'Estado', x: 490, w: 70 },
    { label: 'F. Matrícula', x: 560, w: 80 },
  ];

  // Header row
  doc.rect(40, y, doc.page.width - 80, 18).fill(COLOR.secondary);
  cols.forEach((c) => {
    doc.fontSize(8).font('Helvetica-Bold').fillColor(COLOR.white)
      .text(c.label, c.x, y + 5, { width: c.w });
  });
  y += 20;

  // Rows
  datos.forEach((row, i) => {
    if (y > doc.page.height - 60) {
      drawFooter(doc);
      doc.addPage({ layout: 'landscape' });
      y = 30;
    }
    const bg = i % 2 === 0 ? COLOR.white : COLOR.light;
    doc.rect(40, y, doc.page.width - 80, 16).fill(bg);

    const fecha = row.fecha_registro
      ? new Date(row.fecha_registro).toLocaleDateString('es-EC')
      : '';

    doc.fontSize(8).font('Helvetica').fillColor(COLOR.dark)
      .text(String(i + 1), cols[0].x, y + 4, { width: cols[0].w })
      .text(row.cedula || '', cols[1].x, y + 4, { width: cols[1].w })
      .text(row.estudiante || '', cols[2].x, y + 4, { width: cols[2].w })
      .text(row.grado || '', cols[3].x, y + 4, { width: cols[3].w })
      .text(row.paralelo || '', cols[4].x, y + 4, { width: cols[4].w })
      .text(row.estado || '', cols[5].x, y + 4, { width: cols[5].w })
      .text(fecha, cols[6].x, y + 4, { width: cols[6].w });
    y += 16;
  });

  // Total
  doc.rect(40, y + 4, doc.page.width - 80, 1).fill(COLOR.border);
  doc.fontSize(9).font('Helvetica-Bold').fillColor(COLOR.primary)
    .text(`Total de estudiantes: ${datos.length}`, 40, y + 8);

  drawFooter(doc);
  doc.end();
  return doc;
}

// ══════════════════════════════════════════════
// FICHA DE ESTUDIANTE (datos completos)
// ══════════════════════════════════════════════
function generarFichaEstudiante(estudiante) {
  const doc = new PDFDocument({ size: 'A4', margin: 0 });
  const y0 = drawHeader(doc, 'Ficha del Estudiante');

  let y = y0 + 10;

  // Datos personales
  y = drawSectionTitle(doc, 'DATOS PERSONALES', y);
  drawField(doc, 'Nombres', estudiante.nombres, 40, y);
  drawField(doc, 'Apellidos', estudiante.apellidos, 320, y); y += 18;
  drawField(doc, 'Cédula', estudiante.cedula, 40, y);
  drawField(doc, 'Código', estudiante.codigo_estudiante, 320, y); y += 18;
  drawField(doc, 'Fecha nacimiento',
    estudiante.fecha_nacimiento
      ? new Date(estudiante.fecha_nacimiento).toLocaleDateString('es-EC')
      : '', 40, y);
  drawField(doc, 'Género', estudiante.genero, 320, y); y += 18;
  drawField(doc, 'Teléfono', estudiante.telefono, 40, y);
  drawField(doc, 'Correo', estudiante.correo, 320, y); y += 18;
  drawField(doc, 'Dirección', estudiante.direccion, 40, y, 100); y += 30;

  // Representante
  if (estudiante.rep_nombres) {
    y = drawSectionTitle(doc, 'REPRESENTANTE LEGAL', y);
    drawField(doc, 'Nombres', `${estudiante.rep_nombres} ${estudiante.rep_apellidos}`, 40, y);
    drawField(doc, 'Parentesco', estudiante.parentesco, 320, y); y += 18;
    drawField(doc, 'Cédula', estudiante.rep_cedula, 40, y);
    drawField(doc, 'Teléfono', estudiante.rep_telefono, 320, y); y += 18;
    drawField(doc, 'Correo', estudiante.rep_correo, 40, y); y += 30;
  }

  // Ficha médica
  if (estudiante.tipo_sangre || estudiante.alergias) {
    y = drawSectionTitle(doc, 'INFORMACIÓN MÉDICA', y);
    drawField(doc, 'Tipo de sangre', estudiante.tipo_sangre, 40, y);
    drawField(doc, 'Alergias', estudiante.alergias, 320, y); y += 18;
    drawField(doc, 'Medicación', estudiante.medicacion_permanente, 40, y, 100); y += 18;
    drawField(doc, 'Contacto emergencia', estudiante.contacto_emergencia, 40, y);
    drawField(doc, 'Tel. emergencia', estudiante.telefono_emergencia, 320, y); y += 30;
  }

  // Discapacidad
  if (estudiante.discapacidad) {
    y = drawSectionTitle(doc, 'DISCAPACIDAD', y);
    drawField(doc, 'Tipo', estudiante.tipo_discapacidad, 40, y);
    drawField(doc, 'Porcentaje', `${estudiante.porcentaje_disc || 0}%`, 320, y); y += 30;
  }

  drawFooter(doc);
  doc.end();
  return doc;
}

module.exports = {
  generarCertificadoMatricula,
  generarReporteMatriculas,
  generarFichaEstudiante,
};
