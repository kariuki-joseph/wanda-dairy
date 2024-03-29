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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCSjB_KxYXlNWW4GN3AGBIAqQ-HGvs6zsc',
    appId: '1:31012006028:web:17dff523eb155f764f73a9',
    messagingSenderId: '31012006028',
    projectId: 'dairysmart-ada7c',
    authDomain: 'dairysmart-ada7c.firebaseapp.com',
    storageBucket: 'dairysmart-ada7c.appspot.com',
    measurementId: 'G-BMG7G1QSYT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzakDjC--UxoBQfEcG01VC_puOoxAgqys',
    appId: '1:31012006028:android:56e5ebffafd3054a4f73a9',
    messagingSenderId: '31012006028',
    projectId: 'dairysmart-ada7c',
    storageBucket: 'dairysmart-ada7c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDg7bWwgFyBBC9hpuDqJU0UEPDiaqd_Lns',
    appId: '1:31012006028:ios:61c1954a3073fb724f73a9',
    messagingSenderId: '31012006028',
    projectId: 'dairysmart-ada7c',
    storageBucket: 'dairysmart-ada7c.appspot.com',
    iosBundleId: 'com.example.wandaDairy',
  );
}
