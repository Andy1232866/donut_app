import 'package:flutter/material.dart';
import 'package:donut_app/pages/login_page.dart';
import 'package:donut_app/services/resend_email.dart';

/// Página de verificación de correo electrónico.
///
/// Esta página muestra un mensaje de confirmación al usuario indicando que se ha enviado
/// un correo electrónico para verificar su dirección. También incluye opciones para reenviar
/// el correo o cambiar la dirección de correo electrónico.
class EmailVerificationPage extends StatelessWidget {
  final String email; // Dirección de correo electrónico a verificar

/// Constructor que recibe:
  const EmailVerificationPage({super.key, required this.email});

  /// Función principal que construye la interfaz de verificación de email
  @override
  Widget build(BuildContext context) {
    return Scaffold(

  /// Construye la AppBar con:
  /// - Título centrado
  /// - Botón de retroceso que redirige al Login
      appBar: AppBar(
        backgroundColor: const Color(0xFFE0E0E0),
        elevation: 0,
        title: const Text(
          'Email Verification',
          style: TextStyle(
            color: Color(0xFFEC6666),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Centra el título
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFEC6666)),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ),
      ),
      backgroundColor: const Color(0xFFEC6666),
      body: Stack(
        children: [
          Positioned(
            left: -69,
            top: -95,
            child: Container(
              width: 550,
              height: 550,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.email_outlined,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Verify your email address',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                   /// Descripción detallada con instrucciones para el usuario.
                  child: Text(
                    'We have sent a verification link to $email. \n\n'
                    'Clic on the link to complete the verification process. \n'
                    'You might need to check your spam folder.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFEC6666),
                    minimumSize: const Size(150, 40),
                  ),
                  onPressed: () => resendVerificationEmail(context),
                  child: const Text(
                    'Resend Email',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                /// Botón para cambiar la dirección de correo electrónico.
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Change Email Address',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
