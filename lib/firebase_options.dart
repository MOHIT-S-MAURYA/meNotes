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
    apiKey: 'AIzaSyAHuGX1V3ohJzRwsdcKpojOWEyuezlBgWk',
    appId: '1:683225156478:web:ff674daa5c28dc6a85412f',
    messagingSenderId: '683225156478',
    projectId: 'me-note-app',
    authDomain: 'me-note-app.firebaseapp.com',
    storageBucket: 'me-note-app.appspot.com',
    measurementId: 'G-B7D6HWKM9N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACTksA9HHkGucKEA7YBLqcJ0UDBW9ucqE',
    appId: '1:683225156478:android:98eefb7d02534d3585412f',
    messagingSenderId: '683225156478',
    projectId: 'me-note-app',
    storageBucket: 'me-note-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBf3BiilfIVmA6v5CjRq0p1zSi-2U8v8qo',
    appId: '1:683225156478:ios:5f5d6782fabe424d85412f',
    messagingSenderId: '683225156478',
    projectId: 'me-note-app',
    storageBucket: 'me-note-app.appspot.com',
    iosClientId: '683225156478-cu55rkt6cbri6m08gpapsi4mq9bp9qnc.apps.googleusercontent.com',
    iosBundleId: 'com.example.menotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBf3BiilfIVmA6v5CjRq0p1zSi-2U8v8qo',
    appId: '1:683225156478:ios:304067c1d23bf51885412f',
    messagingSenderId: '683225156478',
    projectId: 'me-note-app',
    storageBucket: 'me-note-app.appspot.com',
    iosClientId: '683225156478-lbmhhr8fv40q78f7ql3qobnilq2jr34i.apps.googleusercontent.com',
    iosBundleId: 'com.example.menotes.RunnerTests',
  );
}