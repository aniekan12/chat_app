import 'package:chat_app/auth/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class _AndroidAuth implements AuthProvider {
  @override
  Future<FirebaseApp> initializeApp() async {
    return await Firebase.initializeApp(
      name: 'fluttergodschat',
      options: FirebaseOptions(
          apiKey: "AIzaSyCiTuNlzfVS6M3BK5s0caP2EOzV4JofJWg",
          authDomain: "fluttergodschat.firebaseapp.com",
          projectId: "fluttergodschat",
          storageBucket: "fluttergodschat.appspot.com",
          messagingSenderId: "991089794291",
          appId: "1:991089794291:android:4e141c211de8042856eb86",
          measurementId: "G-S89K2PBHV8"),
    );
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class AndroidAuthen extends _AndroidAuth {}
