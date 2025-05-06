import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:donut_app/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:donut_app/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Supabase.initialize(
    url: 'https://pwqndnpxmllcxkicwabj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB3cW5kbnB4bWxsY3hraWN3YWJqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQyNjM3MTksImV4cCI6MjA1OTgzOTcxOX0.pafDtu5umW_M4mU97FDPhGLMwWG3bEYzdSeu3GdmtQo',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Donut App',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        tabBarTheme: const TabBarTheme(
          // Cambia el color del indicador de los tabs
          indicatorColor: Colors.pink,
        ),
      ),
      home: const LoginPage(),
    );
  }
}
