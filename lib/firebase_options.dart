// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAKIUxnuwEbo9CPwIHUMsGszSTgioJqvz4',
    appId: '1:639609205185:web:88250d4a5298e83c8cbf40',
    messagingSenderId: '639609205185',
    projectId: 'doctor-767d8',
    authDomain: 'doctor-767d8.firebaseapp.com',
    storageBucket: 'doctor-767d8.appspot.com',
    measurementId: 'G-9KL2F2E5XB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZwgEYdlXM4tnyOeiXzfE4FUA5kGQPmpw',
    appId: '1:639609205185:android:e0c848c5ed4df7c88cbf40',
    messagingSenderId: '639609205185',
    projectId: 'doctor-767d8',
    storageBucket: 'doctor-767d8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDepfJAkbXcD-8VlatPkO7k7O2WHF8d8VU',
    appId: '1:639609205185:ios:f9357a958a282be48cbf40',
    messagingSenderId: '639609205185',
    projectId: 'doctor-767d8',
    storageBucket: 'doctor-767d8.appspot.com',
    iosBundleId: 'com.example.doctor',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDepfJAkbXcD-8VlatPkO7k7O2WHF8d8VU',
    appId: '1:639609205185:ios:9652561391ee82e78cbf40',
    messagingSenderId: '639609205185',
    projectId: 'doctor-767d8',
    storageBucket: 'doctor-767d8.appspot.com',
    iosBundleId: 'com.example.doctor.RunnerTests',
  );
}
