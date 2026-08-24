import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  FirebaseConfig._();

  static const apiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const appId = String.fromEnvironment('FIREBASE_APP_ID');
  static const messagingSenderId =
      String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID');
  static const projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');
  static const storageBucket =
      String.fromEnvironment('FIREBASE_STORAGE_BUCKET');
  static const authDomain = String.fromEnvironment('FIREBASE_AUTH_DOMAIN');
  static const measurementId =
      String.fromEnvironment('FIREBASE_MEASUREMENT_ID');

  static bool get configured =>
      apiKey.isNotEmpty &&
      appId.isNotEmpty &&
      messagingSenderId.isNotEmpty &&
      projectId.isNotEmpty;

  static FirebaseOptions? get options {
    if (!configured) return null;
    return FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      storageBucket: storageBucket.isEmpty ? null : storageBucket,
      authDomain: authDomain.isEmpty ? null : authDomain,
      measurementId: measurementId.isEmpty ? null : measurementId,
    );
  }
}
