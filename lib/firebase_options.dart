// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyANRQpnAxr9qiDsgOx5T0jAuWjtM0zBueQ',
    appId: '1:322833193189:web:e9d31b47cfc5e91955dc0c',
    messagingSenderId: '322833193189',
    projectId: 'gradprjct2022-bb1c0',
    authDomain: 'gradprjct2022-bb1c0.firebaseapp.com',
    databaseURL: 'https://gradprjct2022-bb1c0-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gradprjct2022-bb1c0.appspot.com',
    measurementId: 'G-7C1K7402CZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFRacOZaAWzz-amBkrHA36bQPpGjOjjq0',
    appId: '1:322833193189:android:7340b815fdb8244355dc0c',
    messagingSenderId: '322833193189',
    projectId: 'gradprjct2022-bb1c0',
    databaseURL: 'https://gradprjct2022-bb1c0-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gradprjct2022-bb1c0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCHWlM4BZvx1i8qVejHRaQXyEW14B_G6mI',
    appId: '1:322833193189:ios:61439aa892d5a1a355dc0c',
    messagingSenderId: '322833193189',
    projectId: 'gradprjct2022-bb1c0',
    databaseURL: 'https://gradprjct2022-bb1c0-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gradprjct2022-bb1c0.appspot.com',
    androidClientId: '322833193189-d1cugticm29367vc9i5r6k345c4grrig.apps.googleusercontent.com',
    iosClientId: '322833193189-tlnf6mrp56qd2gg30vjs3n3sqhbbpcfk.apps.googleusercontent.com',
    iosBundleId: 'io.github.lmech',
  );
}
