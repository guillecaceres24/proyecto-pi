// lib/main.dart
import 'package:flutter/material.dart';
// ¡IMPORTANTE! Reemplaza 'nombre_de_tu_proyecto' por el nombre real de tu proyecto
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Alumnos', 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey), 
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false, 
      
      // 🎯 CAMBIO CLAVE: Empezar en la página de Login
      home: const LoginPage(), 
    );
  }
}