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
    apiKey: 'AIzaSyBgeeN67_KWzVUWspqBCVy9YAsxEaXixac',
    appId: '1:191222270617:android:f38312721970ff9da50608',
    messagingSenderId: '191222270617',
    projectId: 'shopping-flutter-e6d08',
    databaseURL: 'https://shopping-flutter-e6d08-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'shopping-flutter-e6d08.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIClEVtWx-p6sOnIknz7dQSlttcqhoZ7g',
    appId: '1:191222270617:ios:704470cb11b5f61ca50608',
    messagingSenderId: '191222270617',
    projectId: 'shopping-flutter-e6d08',
    databaseURL: 'https://shopping-flutter-e6d08-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'shopping-flutter-e6d08.appspot.com',
    iosClientId: '191222270617-p42am70aipk8qmlcr2v0i7pa0nsggmng.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}
