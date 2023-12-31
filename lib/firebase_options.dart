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
    apiKey: 'AIzaSyCcJRCHoBDl5w2S2cONeCLP7efg7J2OL2A',
    appId: '1:936422836197:web:adb57d6181d17d1ca6110c',
    messagingSenderId: '936422836197',
    projectId: 'social-media-app-e878a',
    authDomain: 'social-media-app-e878a.firebaseapp.com',
    storageBucket: 'social-media-app-e878a.appspot.com',
    measurementId: 'G-BLMW7YX25V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDVF-X4JK3t5314BwiD2GJ_1YSJTyCv45k',
    appId: '1:936422836197:android:9f5e7d834869763ca6110c',
    messagingSenderId: '936422836197',
    projectId: 'social-media-app-e878a',
    storageBucket: 'social-media-app-e878a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBkhzoEvvxjp1QNbCw_c1s1mU_fLO49Z70',
    appId: '1:936422836197:ios:2c95f24e342a8839a6110c',
    messagingSenderId: '936422836197',
    projectId: 'social-media-app-e878a',
    storageBucket: 'social-media-app-e878a.appspot.com',
    iosBundleId: 'com.example.socialMediaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBkhzoEvvxjp1QNbCw_c1s1mU_fLO49Z70',
    appId: '1:936422836197:ios:ac00638aef9b6fd1a6110c',
    messagingSenderId: '936422836197',
    projectId: 'social-media-app-e878a',
    storageBucket: 'social-media-app-e878a.appspot.com',
    iosBundleId: 'com.example.socialMediaApp.RunnerTests',
  );
}
