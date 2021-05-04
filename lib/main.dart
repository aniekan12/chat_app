import 'package:chat_app/messaging/message_wall.dart';
import 'package:chat_app/messaging/messageform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth/stub.dart'
    if (dart.library.io) 'auth/android_auth.dart'
    if (dart.library.html) 'auth/web_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthProvider().initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();

  final store = FirebaseFirestore.instance.collection('anis_chat');
}

class _LandingPageState extends State<LandingPage> {
  bool _signedIn = false;

  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user is User) {
        _signedIn = true;
      } else {
        _signedIn = false;
      }
    });
  }

  void _signIn() async {
    try {
      final creds = await AuthProvider().signInWithGoogle();
      print(creds);
      setState(() {
        _signedIn = true;
      });
    } catch (e) {
      print('Login failed: $e');
    }
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      _signedIn = false;
    });
  }

  void _addMessage(String value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await widget.store.add({
        'author': user.displayName ?? 'Anonymous',
        'author_id': user.uid,
        'photo_url': user.photoURL,
        'timestamp': Timestamp.now().millisecondsSinceEpoch,
        'value': value,
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        actions: [
          if (_signedIn)
            InkWell(
              onTap: _signOut,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
            )
        ],
        title: Text(
          'fluttergods chat app',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: widget.store.orderBy('timestamp').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data.docs.isEmpty) {
                  return Center(
                    child: Text('No Messages to Display'),
                  );
                }
                if (snapshot.hasData) {
                  return MessageWall(
                    messages: snapshot.data.docs,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          if (_signedIn)
            MessageForm(
              onSubmit: _addMessage,
            )
          else
            Container(
              padding: EdgeInsets.all(5),
              child: SignInButton(
                Buttons.Google,
                onPressed: _signIn,
              ),
            ),
        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
