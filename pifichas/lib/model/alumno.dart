// lib/models/alumno_model.dart

class Alumno {
  final int id;
  final String nombreCompleto; 
  final String grupo; 
  final String dni;
  final String fechaNacimiento;
  final String contactoTutor;

  Alumno({
    required this.id,
    required this.nombreCompleto,
    required this.grupo,
    required this.dni,
    required this.fechaNacimiento,
    required this.contactoTutor,
  });
}