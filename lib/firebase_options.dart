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
    print('reached firebase config page');
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
    apiKey: 'AIzaSyAJVL0hZ9PBFNPlNklqnkyAG-92N9Tq3Tc',
    appId: '1:684026150374:web:46b03fd4689b11f6d66a27',
    messagingSenderId: '684026150374',
    projectId: 'krenter-3989e',
    authDomain: 'krenter-3989e.firebaseapp.com',
    storageBucket: 'krenter-3989e.firebasestorage.app',
    measurementId: 'G-DFFT49E8DL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBBKKXSLHELprICTm742cJ_UrUgS4REGgU',
    appId: '1:684026150374:android:fe8ee44076637800d66a27',
    messagingSenderId: '684026150374',
    projectId: 'krenter-3989e',
    storageBucket: 'krenter-3989e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAHn_dFsv9f72qjKjUAn1re8Y7yOFNFRJE',
    appId: '1:684026150374:ios:6d980399dcc16d6ad66a27',
    messagingSenderId: '684026150374',
    projectId: 'krenter-3989e',
    storageBucket: 'krenter-3989e.firebasestorage.app',
    iosBundleId: 'com.example.flutterFirestore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAHn_dFsv9f72qjKjUAn1re8Y7yOFNFRJE',
    appId: '1:684026150374:ios:6d980399dcc16d6ad66a27',
    messagingSenderId: '684026150374',
    projectId: 'krenter-3989e',
    storageBucket: 'krenter-3989e.firebasestorage.app',
    iosBundleId: 'com.example.flutterFirestore',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAJVL0hZ9PBFNPlNklqnkyAG-92N9Tq3Tc',
    appId: '1:684026150374:web:57757737f9051674d66a27',
    messagingSenderId: '684026150374',
    projectId: 'krenter-3989e',
    authDomain: 'krenter-3989e.firebaseapp.com',
    storageBucket: 'krenter-3989e.firebasestorage.app',
    measurementId: 'G-BLS972GVHJ',
  );
}
