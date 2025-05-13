import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:donut_app/services/create_user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:donut_app/services/upload_photo.dart';
import 'package:donut_app/pages/login_page.dart';
import 'package:donut_app/pages/email_verification_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});


/// Esta clase implementa una interfaz gráfica para registrar nuevos usuarios en la aplicación.
/// Permite capturar información como el nombre completo, nombre de usuario, correo electrónico y contraseña.
/// Además, ofrece opciones para subir una foto de perfil desde la galería y validar el correo electrónico posteriormente.
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  XFile? _pickerFile;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE0E0E0),
        elevation: 0,
        title: const Text(
          "Register Acount",
          style: TextStyle(color: Color(0xFFEC6666), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFEC6666)),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEC6666),
      body: Stack(
        children: [
          Positioned(
            top: 700,
            right: -20,
            height: 250,
            width: 250,
            child: Image.asset('lib/images/pizza_register.png'),
          ),
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
                const Text(
                  "Let's Get Started!",
                  style: TextStyle(
                    color: Color(0xFFEC6666),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Create an account to get all features",
                  style: TextStyle(color: Color(0xFFEC6666), fontSize: 17),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                    top: 35.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                XFile? picked = await getImageFromGallery();
                                if (picked != null) {
                                  setState(() {
                                    _pickerFile = picked;
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFEC6666),
                                      image:
                                          _pickerFile != null
                                              ? DecorationImage(
                                                image: FileImage(
                                                  File(_pickerFile!.path),
                                                ),
                                                fit: BoxFit.cover,
                                              )
                                              : null,
                                    ),
                                    child:
                                        _pickerFile == null
                                            ? Icon(Icons.add_a_photo_outlined)
                                            : null,
                                  ),
                                ],
                              ),
                            ),
                            // TextField para el nombre de la persona
                            const SizedBox(height: 5),
                            const Text(
                              "Full Name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: 'Input your name',
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E0E0),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E0E0),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.grey[300],
                              ),
                            ),

                            // Text Field para el nombre de usuario
                            const SizedBox(height: 20),
                            const Text(
                              "User Name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: userController,
                              decoration: InputDecoration(
                                hintText: 'Input your user name',
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E0E0),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E0E0),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.grey[300],
                              ),
                            ),

                            //TextField para el correo del usuario
                            const SizedBox(height: 20),
                            const Text(
                              "E-mail",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Input your e-mail',
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E0E0),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E0E0),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.grey[300],
                              ),
                            ),

                            // TextField para la contraseña
                            const SizedBox(height: 20),
                            const Text(
                              "Password",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              obscureText: _obscureText,
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText: 'Input your password',
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E0E0),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E0E0),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.grey[300],
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text.trim();
                    String name = nameController.text.trim();
                    String username = userController.text.trim();
                    String password = passwordController.text.trim();

                    final CreateUser newUser = CreateUser();

                    User? user = await newUser.createUser(
                      email,
                      password,
                      name,
                      username,
                      _pickerFile,
                    );

                    if (user != null && context.mounted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => EmailVerificationPage(email: email),
                        ),
                      );
                    } else {
                      debugPrint('Error al crear usuario');
                    }
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(color: Color(0xFFEC6666)),
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
