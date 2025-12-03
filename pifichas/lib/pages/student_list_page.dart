// lib/pages/student_list_page.dart
import 'package:flutter/material.dart';
import '../model/alumno.dart';
import '../widgets/student_list_tile.dart';

class StudentListPage extends StatelessWidget {
  StudentListPage({super.key});

  // Datos de prueba (Mock Data) para simular la lista
  final List<Alumno> mockAlumnos = [
    Alumno(
      id: 101, // ID para verificar
      nombreCompleto: 'Juan Pérez García',
      grupo: '4ºESO-A',
      dni: '12345678A',
      fechaNacimiento: '10/01/2008',
      contactoTutor: '600111222',
    ),
    Alumno(
      id: 102, // ID para verificar
      nombreCompleto: 'María López Jiménez',
      grupo: '4ºESO-A',
      dni: '87654321B',
      fechaNacimiento: '05/05/2008',
      contactoTutor: '600333444',
    ),
    Alumno(
      id: 205, // ID para verificar
      nombreCompleto: 'Carlos Ruiz Soto',
      grupo: '3ºESO-C',
      dni: '99988877C',
      fechaNacimiento: '15/12/2009',
      contactoTutor: '600555666',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Alumnos (Simulación)', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 33, 150, 243),
      ),
      body: ListView.builder(
        itemCount: mockAlumnos.length,
        itemBuilder: (context, index) {
          final alumno = mockAlumnos[index];
          return StudentListTile(alumno: alumno);
        },
      ),
    );
  }
}