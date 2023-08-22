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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCuSjHxATFrQFSglRMcHf8wlEtOA2K_muQ',
    appId: '1:814385216893:android:ed0e3ba0a95af3b17e6014',
    messagingSenderId: '814385216893',
    projectId: 'learn-and-earn-60221',
    databaseURL: 'https://learn-and-earn-60221-default-rtdb.firebaseio.com',
    storageBucket: 'learn-and-earn-60221.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBVqN7URMi8JT7mYrpft6WH8HZ0Nyjncws',
    appId: '1:814385216893:ios:7437077cb87b34c17e6014',
    messagingSenderId: '814385216893',
    projectId: 'learn-and-earn-60221',
    databaseURL: 'https://learn-and-earn-60221-default-rtdb.firebaseio.com',
    storageBucket: 'learn-and-earn-60221.appspot.com',
    androidClientId: '814385216893-8s219u6lmbgq9adoaaj44lki4dpnfsd0.apps.googleusercontent.com',
    iosClientId: '814385216893-fb3q9j09ufrrjv853e26l3o6d6s8ufve.apps.googleusercontent.com',
    iosBundleId: 'com.example.myFlutterApp',
  );
}
