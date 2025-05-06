import 'package:firebase_auth/firebase_auth.dart';

class SignoutService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signOut() async {
    await _auth.signOut();
  }
}