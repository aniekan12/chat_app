import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth_platform_interface/src/auth_provider.dart';

abstract class AuthProviderBase {
  Future<FirebaseApp> initializeApp();
  Future<UserCredential> signInWithGoogle();
}
