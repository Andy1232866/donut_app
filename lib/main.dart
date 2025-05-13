import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:donut_app/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:donut_app/pages/login_page.dart';


//Funcion principal
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Deja a los witgets ejecutar operaciones asincronas
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); //Inicializa Firebase con las configuraciones específicas de la plataforma (Android, iOS o Web).

  await Supabase.initialize(  // Configura Supabase
    url: 'https://pwqndnpxmllcxkicwabj.supabase.co',  //Dirección URL de la instancia de Supabase.

    anonKey: //Clave pública (anon key) para autenticación de la app.
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB3cW5kbnB4bWxsY3hraWN3YWJqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQyNjM3MTksImV4cCI6MjA1OTgzOTcxOX0.pafDtu5umW_M4mU97FDPhGLMwWG3bEYzdSeu3GdmtQo',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { //: La clase MyApp extiende de StatelessWidget, lo que indica que no tiene un estado mutable.
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //Oculta el banner de depuración.
      title: 'Donut App', //Define el título de la aplicación.
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        tabBarTheme: const TabBarTheme(
          // Cambia el color del indicador de los tabs
          indicatorColor: Colors.pink,
        ),
      ),
      home: const LoginPage(), //Establece la página inicial de la aplicación como LoginPage.
    );
  }
}
