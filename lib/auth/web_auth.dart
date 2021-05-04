import 'package:chat_app/auth/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class _WebAuth implements AuthProviderBase {
  @override
  Future<FirebaseApp> initializeApp() async {
    return Firebase.apps[0];
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    final provider = GoogleAuthProvider();

    provider.addScope('https://www.googleapis.com/auth/userinfo.email');
    provider.addScope('https://www.googleapis.com/auth/userinfo.profile');
    provider.setCustomParameters({'login hint': 'user@example.com'});

    //sign in and return user crdential
    return await FirebaseAuth.instance.signInWithPopup(provider);
  }
}

class AuthProvider extends _WebAuth {}
