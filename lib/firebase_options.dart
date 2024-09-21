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
    apiKey: 'AIzaSyCSOyFextSkdTMTD58x463xSwedw1xG7j8',
    appId: '1:334918556043:web:ae08b44df2d5356e32378e',
    messagingSenderId: '334918556043',
    projectId: 'comments-75906',
    authDomain: 'comments-75906.firebaseapp.com',
    storageBucket: 'comments-75906.appspot.com',
    measurementId: 'G-FPQ6T2B7P9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_rbC2OLS-bGKuObqcStuAuZGp9kPOXGo',
    appId: '1:334918556043:android:58d8dfbef436bdc632378e',
    messagingSenderId: '334918556043',
    projectId: 'comments-75906',
    storageBucket: 'comments-75906.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBNxot70nnDSH8dSvqsQBPRuWSkiaxbe-o',
    appId: '1:334918556043:ios:c0c62cb7eed39f9732378e',
    messagingSenderId: '334918556043',
    projectId: 'comments-75906',
    storageBucket: 'comments-75906.appspot.com',
    iosBundleId: 'com.example.cmtx',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBNxot70nnDSH8dSvqsQBPRuWSkiaxbe-o',
    appId: '1:334918556043:ios:c0c62cb7eed39f9732378e',
    messagingSenderId: '334918556043',
    projectId: 'comments-75906',
    storageBucket: 'comments-75906.appspot.com',
    iosBundleId: 'com.example.cmtx',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCSOyFextSkdTMTD58x463xSwedw1xG7j8',
    appId: '1:334918556043:web:d01b92108edd4a0232378e',
    messagingSenderId: '334918556043',
    projectId: 'comments-75906',
    authDomain: 'comments-75906.firebaseapp.com',
    storageBucket: 'comments-75906.appspot.com',
    measurementId: 'G-RX3NC061JL',
  );
}
