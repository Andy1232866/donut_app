import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdatePassword {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> updatePassword(String pass, String word) async {
    final Pass = pass.trim();
    final Word = word.trim();

    if (Pass.isEmpty || Word.isEmpty) {
      return "Please enter your password";
    }

    if (Pass != Word) {
      return "Passwords do not match";
    }

    if (Pass.length < 6) {
      return "Password must be at least 6 characters";
    }

    final user = _auth.currentUser;
    if (user == null) return "No authenticated user";

    try {
      await user.updatePassword(Pass);
      debugPrint("Contraseña actualizada: $Pass");
      return null;
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }
}
