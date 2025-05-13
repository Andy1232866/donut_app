import 'package:donut_app/pages/user_info.dart';
import 'package:donut_app/services/update_password.dart';
import 'package:flutter/material.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}
class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  // Clave global para manejar el estado del formulario
  // - Permite validar/guardar el formulario con _formKey.currentState
  final _formKey = GlobalKey<FormState>();

  // Controlador para el campo de nueva contraseña
  // - Accede al valor con newPassword.text
  // - Gestiona cambios/validaciones del input
  final TextEditingController newPassword = TextEditingController();

  // Controlador para el campo de confirmación de contraseña
  // - Comparar con newPassword.text para verificar coincidencia
  final TextEditingController confirmPassword = TextEditingController();

  bool _obscureText = true;
  bool _confirmText = true;
@override
Widget build(BuildContext context) {
  return Scaffold(
    // Evita que el Scaffold se redimensione cuando aparece el teclado virtual
    resizeToAvoidBottomInset: false,
    
    appBar: AppBar(
      // Elimina la sombra/elevación de la AppBar para un diseño plano
      elevation: 0,
      
      title: const Text(
        "Forgot Password",  // Título de la página
        // Estilo personalizado con color hexadecimal #EC6666 (rojo/rosado)
        style: TextStyle(color: Color(0xFFEC6666)),
      ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFEC6666)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),body: Padding(
  padding: const EdgeInsets.only(bottom: 60.0),  // Margen inferior de 60px
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,  // Centra verticalmente
      children: [
        Text(
          "Choose New Password",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),  // Texto en negrita 25px
        ),
        SizedBox(height: 10),  // Espaciador vertical de 10px
        Text("Almost done. Enter your new password and youre all set."),  // Subtítulo
        Form(
          key: _formKey,  // Usa la GlobalKey definida anteriormente
          child: Padding(
            padding: const EdgeInsets.all(20.0),  // Margen interno de 20px
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,  // Alinea hijos a la izquierda
              children: [
                const Text(
                  "New Password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,  // Texto en negrita
                    fontSize: 15,                // Tamaño 15px
                  ),
                ),const SizedBox(height: 5), // Espacio pequeño entre label y campo
TextField(
  obscureText: _obscureText, // Si es true oculta el texto (modo contraseña)
  controller: newPassword, // Controlador para manejar el valor del input
  decoration: InputDecoration(
    hintText: 'Input your new password', // Texto de placeholder
    hintStyle: TextStyle(color: Colors.grey[500]), // Color gris para hint
    border: OutlineInputBorder( // Borde estándar
      borderRadius: BorderRadius.circular(10), // Esquinas redondeadas 10px
    ),
    enabledBorder: OutlineInputBorder( // Borde cuando no está enfocado
      borderSide: const BorderSide(
        color: Color(0xFFE0E0E0), // Color gris claro
        width: 1, // Grosor del borde
      ),
      borderRadius: BorderRadius.circular(10), // Mismo radio que el borde normal
    ),
    focusedBorder: OutlineInputBorder( // Borde cuando está seleccionado
      borderSide: const BorderSide(
        color: Color(0xFFE0E0E0), // Mismo color pero más grueso
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    filled: true, // Activa el relleno de fondo
    fillColor: Colors.grey[300], // Color de fondo gris claro
    suffixIcon: IconButton( // Botón para mostrar/ocultar contraseña
      icon: Icon(
        _obscureText
            ? Icons.visibility_off // Icono cuando está oculto
            : Icons.visibility, // Icono cuando es visible
      ),
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText; // Cambia el estado de visibilidad
        });
      },
    ),
  ),
),SizedBox(height: 30), // Espaciado grande antes de la sección de confirmación
const Text(
  "Confirm New Password", // Título del campo de confirmación
  style: TextStyle(
    fontWeight: FontWeight.bold, // Texto en negrita
    fontSize: 15, // Tamaño de fuente mediano
  ),
),
SizedBox(height: 5), // Pequeño espacio entre label y campo
TextField(
  obscureText: _confirmText, // Controla si se muestra el texto (true = oculto)
  controller: confirmPassword, // Controlador para el campo de confirmación
  decoration: InputDecoration(
    hintText: 'Confirm your new password', // Texto guía
    hintStyle: TextStyle(color: Colors.grey[500]), // Color gris para el hint
    border: OutlineInputBorder( // Configuración del borde normal
      borderRadius: BorderRadius.circular(10), // Esquinas redondeadas 10px
    ),
    enabledBorder: OutlineInputBorder( // Borde cuando no está enfocado
      borderSide: const BorderSide(
        color: Color(0xFFE0E0E0), // Color gris claro
        width: 1, // Grosor del borde
      ),
      borderRadius: BorderRadius.circular(10), // Mismo radio de esquinas
    ),
    focusedBorder: OutlineInputBorder( // Borde cuando está seleccionado
      borderSide: const BorderSide(
        color: Color(0xFFE0E0E0), // Mismo color que enabledBorder
        width: 2, // Grosor aumentado para feedback visual
      ),
      borderRadius: BorderRadius.circular(10), // Radio consistente
    ),
    filled: true, // Activa el relleno de fondo
    fillColor: Colors.grey[300], // Color de fondo gris claro
    suffixIcon: IconButton( // Botón para alternar visibilidad
      icon: Icon(
        _confirmText // Icono dinámico según estado
          ? Icons.visibility_off // Ojo tachado cuando está oculto
          : Icons.visibility, // Ojo normal cuando es visible
      ),
      onPressed: () { // Acción al presionar el icono
        setState(() {
          _confirmText = !_confirmText; // Invierte el estado de visibilidad
        });
      },
    ),
  ),
),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(150, 40),
                              backgroundColor: Color(0xFFEC6666),
                            ),
                            onPressed: () async {
                              final update = await UpdatePassword()
                                  .updatePassword(
                                    newPassword.text,
                                    confirmPassword.text,
                                  );

                              if (update != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red[300],
                                    content: Text(
                                      update,
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green[300],
                                    content: Text(
                                      "Password has been updated",
                                    ),
                                  ),
                                );
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const UserInformation(),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              "RESTORE PASSWORD",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
