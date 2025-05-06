import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:donut_app/services/storage_service.dart'; // Asegúrate de tener este servicio para Supabase
import 'package:donut_app/services/firestore_service.dart';
import 'package:image_picker/image_picker.dart';

class CreateUser {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> createUser(
      String email,
      String password,
      String name,
      String username,
      XFile? pickerFile,
      ) async {
    try {
      // Crear usuario en Firebase Authentication
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      User? user = result.user;

      if (user != null) {
        // Si el usuario se creó correctamente, subimos la foto si existe
        String? photoUrl;
        if (pickerFile != null) {
          // Subir la foto a Supabase y obtener la URL
          photoUrl = await StorageService().uploadPhoto(pickerFile, user.uid);
        }

        // Guardar los datos del usuario en Firestore
        await FirestoreService().saveUserData(
          name,
          username,
          email,
          user.uid,
          photoUrl ?? '',  // Si no se sube la foto, se pasa un string vacío
        );

        return user;
      } else {
        debugPrint('No se pudo crear el usuario');
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('La contraseña es muy débil');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('El correo ya está en uso');
      } else if (e.code == 'invalid-email') {
        debugPrint('El correo no es válido');
      } else {
        debugPrint('Error de Firebase: ${e.code} - ${e.message}');
      }
      return null;
    } catch (e) {
      debugPrint('Error inesperado: $e');
      return null;
    }
  }
}