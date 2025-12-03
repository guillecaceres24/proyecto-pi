// lib/widgets/student_list_tile.dart
import 'package:flutter/material.dart';
import '../model/alumno.dart';
import '../pages/student_detail_page.dart';

class StudentListTile extends StatelessWidget {
  final Alumno alumno; 

  const StudentListTile({super.key, required this.alumno});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Card(
        elevation: 2,
        child: ListTile(
          leading: CircleAvatar(
            child: Text(alumno.nombreCompleto[0]),
          ),
          title: Text(alumno.nombreCompleto, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(alumno.grupo),
          trailing: ElevatedButton.icon(
            onPressed: () {
              // 🎯 Navegación a la página de detalles, pasando los datos del alumno
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentDetailPage(
                    studentId: alumno.id, 
                    studentName: alumno.nombreCompleto,
                    studentGroup: alumno.grupo,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.description, size: 18),
            label: const Text('Informe'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 33, 150, 243),
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}