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
    apiKey: 'AIzaSyAsc-evj8TURSFFWpFV9lDXlsKi4s_Zw9I',
    appId: '1:151755384366:web:8c8aa3a29637c0349f21bf',
    messagingSenderId: '151755384366',
    projectId: 'rakshak-main-hackathon',
    authDomain: 'rakshak-main-hackathon.firebaseapp.com',
    storageBucket: 'rakshak-main-hackathon.appspot.com',
    measurementId: 'G-K5LM1M8NEE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8QiwEQYfDUBqDEG-xSax22_nG3ieuKc0',
    appId: '1:151755384366:android:6d846cd3e5a77ac79f21bf',
    messagingSenderId: '151755384366',
    projectId: 'rakshak-main-hackathon',
    storageBucket: 'rakshak-main-hackathon.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWzw5Dm7nFo6Kv5YxYZk-uoblO3bb7vCE',
    appId: '1:151755384366:ios:2f64e48cad63d9fe9f21bf',
    messagingSenderId: '151755384366',
    projectId: 'rakshak-main-hackathon',
    storageBucket: 'rakshak-main-hackathon.appspot.com',
    iosBundleId: 'com.example.rakashkh',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAWzw5Dm7nFo6Kv5YxYZk-uoblO3bb7vCE',
    appId: '1:151755384366:ios:0024f174f9b192209f21bf',
    messagingSenderId: '151755384366',
    projectId: 'rakshak-main-hackathon',
    storageBucket: 'rakshak-main-hackathon.appspot.com',
    iosBundleId: 'com.example.rakashkh.RunnerTests',
  );
}
