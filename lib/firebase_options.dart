import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB86BXq4xTaIGwCxvBDMTPu60PwE9QNFkI',
    appId: '1:236951048446:web:4e546bf991e12a7b58d5af',
    messagingSenderId: '236951048446',
    projectId: 'plotsklapps-gymnotes',
    authDomain: 'plotsklapps-gymnotes.firebaseapp.com',
    storageBucket: 'plotsklapps-gymnotes.appspot.com',
    measurementId: 'G-J1LRDB1Y08',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA19CGcqVhK_QLi4AlkNJbhjrP3m7Wn1I0',
    appId: '1:236951048446:android:5a2144deee6a5cef58d5af',
    messagingSenderId: '236951048446',
    projectId: 'plotsklapps-gymnotes',
    storageBucket: 'plotsklapps-gymnotes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANQgjbNoATY53x0TAnqMScg-DC_1I5USs',
    appId: '1:236951048446:ios:138ee63ab4b93af958d5af',
    messagingSenderId: '236951048446',
    projectId: 'plotsklapps-gymnotes',
    storageBucket: 'plotsklapps-gymnotes.appspot.com',
    iosClientId:
        '236951048446-1q4a0lh5klmu8sgiijn2sugitpq4ou25.apps.googleusercontent.com',
    iosBundleId: 'nl.plotsklapps.gymnotes',
  );
}
