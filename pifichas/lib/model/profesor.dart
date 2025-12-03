// lib/model/profesor.dart

class Profesor {
  final String email;
  final String password; // Contraseña plana que se enviará para hashear en el backend
  final String nombre;
  final String rol; // Podría ser 'profesor' o 'administrador'

  Profesor({
    required this.email,
    required this.password,
    required this.nombre,
    // Asumiremos un valor predeterminado si no se especifica, pero lo haremos requerido
    required this.rol, 
  });

  // Método para convertir el objeto Profesor en un mapa JSON para la API
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password, 
      'nombre': nombre,
      'rol': rol,
      // Los campos 'password_hash', 'id', 'fecha_alta' y 'activo' 
      // serán generados o gestionados por el backend
    };
  }
}