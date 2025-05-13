import 'package:donut_app/pages/change_password_page.dart';
import 'package:donut_app/services/google_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:donut_app/pages/home_page.dart';
import 'package:donut_app/pages/register_page.dart';
import 'package:donut_app/services/email_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

//Funcion principal que contiene la interfaz de login
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFEC6666),
      body: Stack(
        children: [
          Positioned(
            top: 700,
            right: -300,
            height: 250,
            width: 250,
            child: Transform(
              transform: Matrix4.identity()..scale(-1.0, 1.0),
              child: Image.asset('lib/images/donut_login.png'),
            ),
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
                  "Welcome!",
                  style: TextStyle(
                    color: Color(0xFFEC6666),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Please log in to your account",
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
                      key: _formKey, //Para validar los campos nulos
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            const SizedBox(height: 20),
                            const Text(
                              "Password",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                            //Gestiona la entrada de las contraseñas
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
                                    //oscurece el testo
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                              ),
                            ),
                            GestureDetector( //Te redirige a la pagina para cambiar contraseñas
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 190.0,
                                  top: 10.0,
                                ),
                                child: Text("Forgot Password?"),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ChangePasswordPage(),
                                  ),
                                );
                              },
                            ),

                            /// - Construye un botón que permite al usuario iniciar sesión con correo electrónico y contraseña.
                            /// - Usa el servicio `AuthService` para autenticar las credenciales proporcionadas.
                            /// - Si la autenticación es exitosa, redirige al usuario a la página principal (`Homepage`).
                            /// - Si la autenticación falla, muestra un mensaje de error en la consola.
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(150, 40),
                                    backgroundColor: Color(0xFFEC6666),
                                  ),
                                  onPressed: () async {
                                    //Captura los datos del usuario
                                    String email = emailController.text;
                                    String password = passwordController.text;

                                    //Llama al servicio de autentificacion
                                    AuthService auth = AuthService();
                                    User? user = await auth.signInWithEmail(
                                      email,
                                      password,
                                    );

                                    //Maneja la autentificacion
                                    if (user != null) {
                                      debugPrint('Bienvenido ${user.email}');

                                      if (context.mounted) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder:
                                                (context) => const Homepage(),
                                          ),
                                        );
                                      }
                                    } else {
                                      debugPrint('Login fallido');
                                    }
                                  },
                                  child: const Text(
                                    "LOG IN",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),


                Padding(

                  padding: const EdgeInsets.only(
                    top: 15.0,
                    right: 135,
                    left: 135,
                  ),

                  /// - Utiliza el servicio `GoogleAuth` para manejar el inicio de sesión con Google.
                  /// - Redirige al usuario a la página principal si la autenticación es exitosa.
                  /// - Muestra un mensaje de error en caso de fallar.
                  child: GestureDetector(
                    child: Image.asset(
                      "lib/icons/google_icon.png",
                      width: 40,
                      height: 40,
                    ),
                    onTap: () async {
                      //Llama al servicio de autentificacion de Google
                      GoogleAuth auth = GoogleAuth();
                      User? user = await auth.signInWithGoogle();

                      //Maneja la autentificacion
                      if (user != null) {
                        debugPrint('Bienvenido ${user.email}');

                        if (context.mounted) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const Homepage(),
                            ),
                          );
                        }
                      } else {
                        debugPrint('Login fallido');
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Column(
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xFF2E405A),
                        ),
                      ),
                      /// - Muestra un texto que pregunta al usuario si no tiene una cuenta.
                      /// - Incluye un enlace que redirige a la página de registro (`RegisterPage`).
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "REGISTER",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                /// - Permite al usuario iniciar sesión de manera anónima utilizando `FirebaseAuth`.
                  /// - Redirige al usuario a la página principal si el inicio de sesión es exitoso.
                  /// - Muestra un mensaje de error en caso de falla.
                GestureDetector(
                  onTap: () async {
                    try {
                      //Inicia sesion de anonima
                      UserCredential userCredential =
                          await FirebaseAuth.instance.signInAnonymously();

                      // Verifica si el usuario anónimo es válido.
                      User? user = userCredential.user;

                      if (user != null) {
                        debugPrint(
                          'Inicio de sesión exitoso. UID: ${user.uid}',
                        );

                        if (context.mounted) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const Homepage(),
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      debugPrint('Error al iniciar sesión anónimamente: $e');
                    }
                  },
                  child: Text(
                    "Continue As Anonymous",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      fontWeight: FontWeight.bold,
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
