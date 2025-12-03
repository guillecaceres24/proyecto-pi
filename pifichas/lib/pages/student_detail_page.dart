// lib/pages/student_detail_page.dart
import 'package:flutter/material.dart';

class StudentDetailPage extends StatelessWidget {
  // Argumentos que llegan de la página anterior
  final int studentId; 
  final String studentName;
  final String studentGroup;

  const StudentDetailPage({
    super.key,
    required this.studentId,
    required this.studentName,
    required this.studentGroup,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Tabs: Datos Básicos, Ficha, Observaciones
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: _buildTopAppBar(context),
        ),
        body: Column(
          children: [
            _buildDetailHeader(context),
            _buildTabsAndContent(context),
          ],
        ),
      ),
    );
  }

  // --- Widgets de la Estructura ---

  Widget _buildTopAppBar(BuildContext context) {
    const Color activeColor = Color.fromARGB(255, 33, 150, 243);
    
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: Row(
        children: [
          const Text('Logo de la Plataforma', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(width: 50),
          _buildAppBarButton('Gestión de Alumnos', true, activeColor, 18, context), 
          const SizedBox(width: 35),
          _buildAppBarButton('Generar Informes', false, activeColor, 18, context),
          const Spacer(),
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: 20,
            child: const Text('WA', style: TextStyle(color: Colors.black87, fontSize: 18)),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
  
  Widget _buildAppBarButton(String text, bool isActive, Color activeColor, double fontSize, BuildContext context) {
    return TextButton(
      onPressed: () {
        if (text == 'Gestión de Alumnos') {
          // Navega de vuelta a la página anterior
          Navigator.pop(context); 
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style: TextStyle(color: isActive ? activeColor : Colors.black54, fontWeight: isActive ? FontWeight.bold : FontWeight.normal, fontSize: fontSize)),
          if (isActive) Container(margin: const EdgeInsets.only(top: 4), height: 3, width: text.length * 8.5, color: activeColor),
        ],
      ),
    );
  }

  Widget _buildDetailHeader(BuildContext context) {
    return Container(
      color: Colors.grey.shade800,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      child: Row(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade600,
                radius: 25,
                child: Text(
                  studentName.substring(0, 1), 
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    studentName,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    studentGroup,
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                  ),
                  // Línea de VERIFICACIÓN: Muestra el ID pasado como argumento
                  Text('ID Alumno: $studentId', style: TextStyle(color: Colors.yellow.shade300, fontSize: 12, fontWeight: FontWeight.bold)), 
                ],
              ),
            ],
          ),
          const SizedBox(width: 50),
          const Expanded(
            child: Center(
              child: Text(
                'Gestión Individual de Alumno',
                style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              textStyle: const TextStyle(fontSize: 16),
            ),
            child: const Text('Generar Informe Rápido'),
          ),
        ],
      ),
    );
  }

  Widget _buildTabsAndContent(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade200,
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: const TabBar(
              indicatorColor: Colors.black, 
              labelColor: Colors.black, 
              unselectedLabelColor: Colors.grey, 
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              tabs: [
                Tab(child: Text('Datos Básicos')),
                Tab(child: Text('Ficha')),
                Tab(child: Text('Observaciones')),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildDatosBasicosTab(),
                _buildFichaTab(),
                _buildObservacionesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Widgets de Contenido de Pestañas (Simulados) ---

  Widget _buildDatosBasicosTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Datos Básicos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildDetailRow(label: 'ID del Alumno', value: studentId.toString()), 
          _buildDetailRow(label: 'DNI', value: 'Cargando...'),
          _buildDetailRow(label: 'Fecha de Nacimiento', value: 'Cargando...'),
          _buildDetailRow(label: 'Contacto Tutor', value: 'Cargando...'),
          const SizedBox(height: 30),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildFichaTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Ficha (Datos Médicos y Curriculares)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildLargeTextField(label: 'Datos Médicos'),
          const SizedBox(height: 20),
          _buildLargeTextField(label: 'Adaptaciones Curriculares'),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Fecha de Creación: XX/XX/XXXX'),
              const SizedBox(width: 20),
              const Text('Última modificación: XX/XX/XXXX'),
              const SizedBox(width: 40),
              _buildSaveButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildObservacionesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Añadir nueva observación', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                _buildLargeTextField(label: 'Contenido de la Observación'),
                const SizedBox(height: 20),
                _buildDropdownField(label: 'Tipo: Conducta, Académico, Social...'),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Checkbox(value: false, onChanged: null),
                    Text('Visible al Tutor'),
                  ],
                ),
                const SizedBox(height: 30),
                _buildAddObservationButton(),
              ],
            ),
          ),
          
          const SizedBox(width: 40),
          
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Historial de Observaciones', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                _buildObservationHistoryTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Widgets Auxiliares ---
  
  Widget _buildDetailRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(label, style: const TextStyle(fontSize: 16)),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(value, style: const TextStyle(fontSize: 16, color: Colors.black87)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeTextField({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        const TextField(
          maxLines: 5,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(10),
            isDense: true,
          ),
        ),
      ],
    );
  }
  
  Widget _buildDropdownField({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        const TextField(
          decoration: InputDecoration(
            hintText: 'Seleccionar tipo...',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            isDense: true,
          ),
        ),
      ],
    );
  }
  
  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade800,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      child: const Text('Guardar Cambios'),
    );
  }
  
  Widget _buildAddObservationButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade800,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      child: const Text('Añadir Observación'),
    );
  }

  Widget _buildObservationHistoryTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(1.5),
      },
      children: [
        // Encabezado
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade200),
          children: [ 
            _buildHistoryCell('Fecha', isHeader: true),
            _buildHistoryCell('Tipo', isHeader: true),
            _buildHistoryCell('Contenido', isHeader: true),
            _buildHistoryCell('', isHeader: true),
          ],
        ),
        // Datos de ejemplo
        _buildHistoryRow('12/05/2025', 'Conducta', 'Comentario de ejemplo de 120 caracteres para simular contenido.', 'Abrir'),
        _buildHistoryRow('28/04/2025', 'Académico', 'El alumno ha mostrado una gran mejoría en la asignatura de PI.', 'Abrir'),
        _buildHistoryRow('15/03/2025', 'Social', 'Requiere apoyo adicional en el trabajo en grupo con sus compañeros.', 'Abrir'),
      ],
    );
  }
  
  TableRow _buildHistoryRow(String date, String type, String content, String buttonText) {
    return TableRow(
      children: [
        _buildHistoryCell(date),
        _buildHistoryCell(type),
        _buildHistoryCell(content),
        _buildHistoryCellButton(buttonText),
      ],
    );
  }
  
  Widget _buildHistoryCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
  
  Widget _buildHistoryCellButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade300,
          foregroundColor: Colors.black87,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          textStyle: const TextStyle(fontSize: 14),
        ),
        child: Text(text),
      ),
    );
  }
}