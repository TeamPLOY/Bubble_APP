// firebase_options.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdPqbUcAu2L3Sc_y8DAtsUIFW5a7WTvFg',
    appId: '1:677835780738:ios:49d9af5a47cfc923a67a9b',
    messagingSenderId: '677835780738',
    projectId: 'bubble-457b0',
    storageBucket: 'bubble-457b0.firebasestorage.app',
    iosBundleId: 'com.example.bubbleApp',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDa5In0f4Tm1hfYOGx-Qfq8GxJCf9MjxuY',
    appId: '1:677835780738:web:43ce9d49d31daeaba67a9b',
    messagingSenderId: '677835780738',
    projectId: 'bubble-457b0',
    authDomain: 'bubble-457b0.firebaseapp.com',
    storageBucket: 'bubble-457b0.firebasestorage.app',
    measurementId: 'G-1GHM97ETQN',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAdPqbUcAu2L3Sc_y8DAtsUIFW5a7WTvFg',
    appId: '1:677835780738:ios:49d9af5a47cfc923a67a9b',
    messagingSenderId: '677835780738',
    projectId: 'bubble-457b0',
    storageBucket: 'bubble-457b0.firebasestorage.app',
    iosBundleId: 'com.example.bubbleApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAdPqbUcAu2L3Sc_y8DAtsUIFW5a7WTvFg',
    appId: '1:677835780738:ios:49d9af5a47cfc923a67a9b',
    messagingSenderId: '677835780738',
    projectId: 'bubble-457b0',
    storageBucket: 'bubble-457b0.firebasestorage.app',
    iosBundleId: 'com.example.bubbleApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDa5In0f4Tm1hfYOGx-Qfq8GxJCf9MjxuY',
    appId: '1:677835780738:web:8ea1101c03ccd617a67a9b',
    messagingSenderId: '677835780738',
    projectId: 'bubble-457b0',
    authDomain: 'bubble-457b0.firebaseapp.com',
    storageBucket: 'bubble-457b0.firebasestorage.app',
    measurementId: 'G-97HDWJWT6T',
  );
}
