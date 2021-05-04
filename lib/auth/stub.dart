import 'package:firebase_core/firebase_core.dart';

import 'auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider implements AuthProviderBase {
  @override
  Future<FirebaseApp> initializeApp() {
    // TODO: implement initializeApp
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
