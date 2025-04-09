// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB7YNZdlnEiEaJZxTF_9-LY-USraHwek84',
    appId: '1:920559667634:web:42a82e0e7734cd7ebebcab',
    messagingSenderId: '920559667634',
    projectId: 'test-18-03-2025',
    authDomain: 'test-18-03-2025.firebaseapp.com',
    storageBucket: 'test-18-03-2025.firebasestorage.app',
    measurementId: 'G-9KDPV2J4MR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBEKF6x3IizrZOf4qtlsX4ZMDNTzPFqhLM',
    appId: '1:920559667634:android:7cda433faf248764bebcab',
    messagingSenderId: '920559667634',
    projectId: 'test-18-03-2025',
    storageBucket: 'test-18-03-2025.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3Gd73HJGGuw_4dckt8xsnm6YGWYjZT8M',
    appId: '1:920559667634:ios:3528fd4220497247bebcab',
    messagingSenderId: '920559667634',
    projectId: 'test-18-03-2025',
    storageBucket: 'test-18-03-2025.firebasestorage.app',
    iosBundleId: 'com.example.donutApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA3Gd73HJGGuw_4dckt8xsnm6YGWYjZT8M',
    appId: '1:920559667634:ios:3528fd4220497247bebcab',
    messagingSenderId: '920559667634',
    projectId: 'test-18-03-2025',
    storageBucket: 'test-18-03-2025.firebasestorage.app',
    iosBundleId: 'com.example.donutApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB7YNZdlnEiEaJZxTF_9-LY-USraHwek84',
    appId: '1:920559667634:web:2ba17bf56cd7465dbebcab',
    messagingSenderId: '920559667634',
    projectId: 'test-18-03-2025',
    authDomain: 'test-18-03-2025.firebaseapp.com',
    storageBucket: 'test-18-03-2025.firebasestorage.app',
    measurementId: 'G-CEMMTHF5SM',
  );
}
