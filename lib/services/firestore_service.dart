import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserData(
      String name,
      String username,
      String email,
      String uid,
      String photoUrl,
      ) async {
    try {
      // Guardar la información del usuario en Firestore
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'username': username,
        'email': email,
        'photoUrl': photoUrl,  // URL de la foto de Supabase
        'uid': uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
      debugPrint('User data saved to Firestore');
    } catch (e) {
      debugPrint('Error saving user data: $e');
    }
  }
}