// lib/pages/login_page.dart

import 'package:flutter/material.dart';
import '/pages/home_page.dart'; // Para navegar
import '/services/auth_service.dart'; // Para el login
// Si usaste la página de registro antes, asegúrate de quitarla si ya no existe, o déjala si la vas a reintroducir.

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  // --- Lógica de Inicio de Sesión (Email y Contraseña) ---
  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor, introduce tu email y contraseña.';
      });
      return;
    }
    
    setState(() {
      _errorMessage = '';
      _isLoading = true;
    });

    // Llamar al servicio con ambos datos
    final profesorData = await _authService.login(email, password);

    setState(() {
      _isLoading = false;
    });

    if (profesorData != null) {
      // Login exitoso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('¡Bienvenido, ${profesorData['nombre']}!')),
      );
      
      // Navegar al HomePage y remover la página de login del stack
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => const HomePage()),
      );

    } else {
      // Credenciales inválidas o error del servidor
      setState(() {
        _errorMessage = 'Credenciales no válidas. Inténtalo de nuevo.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Logo de la Plataforma',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 50),
              _buildLoginForm(context),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widgets de Componentes ---

  Widget _buildLoginForm(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Iniciar Sesión',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),

              // Campo de Email
              _buildTextField('Email', _emailController, false),
              const SizedBox(height: 20),
              
              // Campo de Contraseña
              _buildTextField('Contraseña', _passwordController, true),
              const SizedBox(height: 30),

              // Mensaje de Error
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              
              // Botón "Iniciar sesión"
              _buildLoginButton(context),
              const SizedBox(height: 15),

              // Enlace "¿has olvidado la contraseña?"
              TextButton(
                onPressed: () {
                  // Lógica para recuperar contraseña o ayuda
                },
                child: const Text(
                  '¿has olvidado la contraseña?',
                  style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      // ✅ CORRECCIÓN APLICADA: Usando 'labelText' en lugar de 'labelType'
      keyboardType: labelText.toLowerCase().contains('email') ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade800,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          elevation: 5,
        ),
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
              )
            : const Text('Iniciar sesión'),
      ),
    );
  }
}