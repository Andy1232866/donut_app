import 'package:donut_app/services/restore_password.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class ChangePasswordPage extends StatefulWidget { //La página es un widget con estado porque requiere gestionar el texto ingresado por el usuario.
  /// Página para recuperación de contraseña.
  /// 
  /// Es un widget con estado porque necesita:
  /// 1. Gestionar el texto ingresado en el campo de email
  /// 2. Validar el formulario
  /// 3. Manejar el estado durante la solicitud de recuperación
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>(); //Clave para validar el formulario.
  final TextEditingController emailController = TextEditingController(); //Controlador para manejar el texto ingresado en el campo de correo electrónico.

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Estructura básica de la pantalla con AppBar, fondo y cuerpo principal.
      resizeToAvoidBottomInset: false, //Evita que el teclado desplace los widgets cuando se muestra.
      appBar: AppBar( //Estilos de la appBar
        backgroundColor: const Color(0xFFE0E0E0), // Color rojo donut
        elevation: 0, //Elimina la sombra hace que la AppBar parezca estar al mismo nivel que el contenido
        title: const Text(
          "Forgot Password",
          style: TextStyle(color: Color(0xFFEC6666), fontWeight: FontWeight.bold),
        ),
        centerTitle: true, //Centra el titulo
        leading: IconButton( //se muestra al principio (lado izquierdo en LTR - izquierda a derecha) 
          icon: const Icon(Icons.arrow_back, color: Color(0xFFEC6666)),
          onPressed: () {
            Navigator.of(context).pushReplacement( //Es el widget que gestiona la pila de rutas
              MaterialPageRoute(builder: (context) => const LoginPage()), //Regresa a la pantalla de inicio de sesión.
            );
          },
        ),
      ),
      backgroundColor: const Color(0xFFEC6666),
      body: Stack(
        children: [
          Positioned( //la pocision del contenedor en forma de circulo
            left: -69, // Posición fuera del margen izquierdo
            top: -95,  // Posición fuera del margen superior
            child: Container(
              width: 550,
              height: 550,
              decoration: BoxDecoration( 
                shape: BoxShape.circle,
                color: Colors.grey[300], //// Color gris claro
              ),
            ),
          ),
          // Contenido principal centrado
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0), // Es un constructor que permite aplicar espacios
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, //oloca todos los widgets hijos pegados al inicio del eje principal
                children: [
                  const Icon(
                    Icons.lock_open_outlined, // Ícono de candado abierto
                    size: 100,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 20), // Espaciador
                  const Text( // Título de la página
                    'Change your Password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Contenedor del formulario
                  Padding(
                    padding: const EdgeInsets.only( //Agrega espacio en las siguientes direcciones
                      left: 30.0,
                      right: 30.0,
                      top: 35.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15), // Bordes redondeados
                      ),
                      child: Form(
                        key: _formKey, // Clave para validación
                        child: Padding(
                          padding: const EdgeInsets.all(20.0), //esoaciado en todas las direcciones
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, //// Alinea hijos al inicio (izquierda)
                            children: [
                              // Etiqueta del campo de email
                              const Text(
                                "E-mail",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 5), ///Espaciador
                              TextField(
                                controller: emailController, //Controlador para manejar el texto
                                decoration: InputDecoration(
                                  hintText: 'Input your e-mail', ///Texto del placeholder
                                  hintStyle: TextStyle(color: Colors.grey[500]), // Estilo del placeholder
                                  border: OutlineInputBorder( /// Borde normal (sin interacción)
                                    borderRadius: BorderRadius.circular(10), //redondeado del borde
                                  ),
                                      /// Borde cuando el campo está habilitado pero no enfocado
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFE0E0E0),
                                      width: 1, // Grosor del borde
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                      /// Borde cuando el campo tiene foco (seleccionado)
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFE0E0E0),
                                      width: 2, // Grosor aumentado para indicar foco
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true, // Activa el relleno de fondo
                                  fillColor: Colors.grey[300] // Color de fondo gris claro
                                ),
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center, // alinear sus hijos a lo largo del eje principal (main axis) en el centro.
                                children: [
                                  ElevatedButton(
                                      /// Personalización del estilo del botón
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(150, 40), // Tamaño mínimo (ancho x alto)
                                      backgroundColor: Color(0xFFEC6666),
                                    ),
                                      /// Acción al presionar el botón
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {  // Valida el formulario primero
                                        try {
                                          final authRestore = RestorePassword();
                                          await authRestore.sendPasswordResetEmail(emailController.text);

                                          /// Muestra notificación de éxito
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password Reset Email Sent")),);
                                          /// Navega a LoginPage (reemplazando la ruta actual)
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(builder: (context) => const LoginPage()),
                                          );
                                        } catch (e) {
                                          /// Muestra notificación de error
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error ${e.toString()}")),);
                                        }
                                      }
                                    },
                                      /// Contenido del botón
                                    child: const Text(
                                      "SEND MAIL",
                                      style: TextStyle(
                                        color: Colors.white, //Texto blanco
                                        fontWeight: FontWeight.bold, //Negrita
                                        fontSize: 17, //tamaño de fuente
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
