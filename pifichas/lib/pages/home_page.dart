// lib/pages/home_page.dart

import 'package:flutter/material.dart';
// Importamos la página de destino para el botón "Informe"
import 'student_detail_page.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controladores para los TextField (búsqueda y filtro)
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _filterController = TextEditingController();

  // Datos de ejemplo para la tabla (IMPORTANTE: se añade un 'id' para la navegación)
  final List<Map<String, dynamic>> students = [
    {'id': 101, 'name': 'Juan Martínez Guerrero', 'group': 'DAW 2', 'last_modified': '10/11/2025'},
    {'id': 102, 'name': 'Andrés González Pérez', 'group': 'DAM 1', 'last_modified': '24/10/2025'},
    {'id': 103, 'name': 'Lucia Guerra León', 'group': 'DAW 2', 'last_modified': '13/10/2025'},
    {'id': 104, 'name': 'Antonio Martínez López', 'group': 'DAM 2', 'last_modified': '08/10/2025'},
    {'id': 105, 'name': 'Andrea Dorado González', 'group': 'DAW 1', 'last_modified': '30/09/2025'},
    // Puedes añadir más alumnos aquí
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Barra de navegación superior
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: _buildAppBar(),
      ),
      
      // 2. Cuerpo de la página: Ocupando todo el ancho
      body: Padding(
        padding: const EdgeInsets.all(40.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            const Text(
              'Gestión de Alumnos',
              style: TextStyle(
                fontSize: 40, 
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30), 
            
            // Búsqueda y Filtro
            _buildSearchAndFilter(),
            const SizedBox(height: 40), 
            
            // Tabla de Alumnos
            _buildStudentsTable(),
          ],
        ),
      ),
    );
  }

  // --- Widgets de Componentes ---

  // La AppBar superior
  Widget _buildAppBar() {
    // Usamos el color blanco para la AppBar como en la imagen
    const Color activeColor = Color.fromARGB(255, 33, 150, 243); // Azul estándar para la línea activa
    
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: Row(
        children: [
          // Logo/Nombre de la Plataforma
          const Text(
            'Logo de la Plataforma',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20, 
            ),
          ),
          const SizedBox(width: 50), 
          
          // Botones de navegación
          _buildAppBarButton('Gestión de Alumnos', true, activeColor, 18), 
          const SizedBox(width: 35),
          _buildAppBarButton('Generar Informes', false, activeColor, 18), 
          
          const Spacer(), // Empuja el avatar a la derecha
          
          // Avatar del usuario
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: 20, 
            child: const Text(
              'WA',
              style: TextStyle(color: Colors.black87, fontSize: 18), 
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }

  Widget _buildAppBarButton(String text, bool isActive, Color activeColor, double fontSize) {
    return TextButton(
      onPressed: () {
        // Lógica de navegación
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: isActive ? activeColor : Colors.black54,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 3, 
              width: text.length * 8.5, 
              color: activeColor,
            ),
        ],
      ),
    );
  }

  // Campos de búsqueda y filtro
  Widget _buildSearchAndFilter() {
    return Row(
      children: [
        // Campo de Búsqueda
        SizedBox(
          width: 300, 
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar alumno por nombre/ID',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), 
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey.shade100, 
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), 
            ),
            style: const TextStyle(fontSize: 16), 
          ),
        ),
        const SizedBox(width: 30), 
        
        // Campo de Filtrado
        SizedBox(
          width: 250, 
          child: TextField(
            controller: _filterController,
            decoration: InputDecoration(
              hintText: 'Filtrar por Clase/Grupo',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), 
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), 
            ),
            style: const TextStyle(fontSize: 16), 
          ),
        ),
      ],
    );
  }

  // Tabla de alumnos
  Widget _buildStudentsTable() {
    return Expanded(
      child: SingleChildScrollView(
        child: DataTable(
          // Estilo del encabezado
          headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade100),
          dataRowHeight: 70, 
          
          columns: const [
            DataColumn(label: Text('Nombre', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))), 
            DataColumn(label: Text('Grupo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))), 
            DataColumn(label: Text('Última Modificación', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))), 
            DataColumn(label: Text('')), 
          ],
          
          // Usa `students.map` para construir las filas
          rows: students.map((student) {
            return DataRow(
              cells: [
                DataCell(Text(student['name'] as String, style: const TextStyle(fontSize: 16))), 
                DataCell(Text(student['group'] as String, style: const TextStyle(fontSize: 16))), 
                DataCell(Text(student['last_modified'] as String, style: const TextStyle(fontSize: 16))), 
                DataCell(
                  ElevatedButton(
                    onPressed: () {
                      // ** CORRECCIÓN: Implementación de la navegación **
                      // Se utiliza el operador '!' para forzar la aserción de no nulo,
                      // asumiendo que el 'id' siempre estará presente y será un entero.
                      // Opcionalmente, se puede usar `(student['id'] as int?) ?? 0`
                      // para proporcionar un valor predeterminado si es nulo.
                      final int studentId = student['id'] as int;
                      final String studentName = student['name'] as String;
                      final String studentGroup = student['group'] as String;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentDetailPage(
                            // Pasamos los datos del alumno a la página de detalles
                            studentId: studentId,
                            studentName: studentName,
                            studentGroup: studentGroup,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), 
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), 
                      textStyle: const TextStyle(fontSize: 16), 
                    ),
                    child: const Text('Informe'),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}