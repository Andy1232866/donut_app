import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> resendVerificationEmail(BuildContext context) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      final refreshedUser = FirebaseAuth.instance.currentUser;

      if (refreshedUser != null && !refreshedUser.emailVerified) {
        await refreshedUser.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Verification email has been resent.'),
            backgroundColor: Colors.green[300],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Your email is already verified.',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Color(0xFFE0E0E0),
          ),
        );
      }
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to resend email: $e'),
        backgroundColor: Colors.red[300],
      ),
    );
  }
}
