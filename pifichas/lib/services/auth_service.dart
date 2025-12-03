// lib/services/auth_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // ⚠️ IMPORTANTE: Ajusta esta URL según tu plataforma
  // iOS Simulator / Web:  http://localhost:3000/login
  // Android Emulator:      http://10.0.2.2:3000/login
  static const String _loginUrl = "http://localhost:3000/login";

  // Función de LOGIN (email + contraseña)
  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          // Usa las claves EXACTAS que espera tu backend Node.js:
          'correo': email,
          'contrasenia': password,
        }),
      );

      // Caso OK
      if (response.statusCode == 200 || response.statusCode == 202) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data.containsKey('profesor')) {
          print("Login exitoso para: $email");
          return data['profesor']; // Retorna datos del profesor
        } else {
          print("Respuesta exitosa, pero no trae 'profesor'.");
          return null;
        }
      }

      // Credenciales incorrectas
      if (response.statusCode == 401) {
        print("Credenciales inválidas (401)");
        return null;
      }

      // Otros errores del servidor
      print("Error en login: Código ${response.statusCode}");
      return null;

    } catch (e) {
      print("Error de conexión o inesperado: $e");
      return null;
    }
  }
}
