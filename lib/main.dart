import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'dialog_login_gg.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleUser;

  Future<void> loginWithGoogle() async {
    final result = await googleSignIn.signIn();
    if (result == null) return;
    googleUser = result;

    showDialog(
      context: context,
      builder: (ctx) =>
          DialogLoginGoogle(googleUser: googleUser!, logout: logoutGoogle),
    );
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.disconnect();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with google and facebook'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 100),
            const Text(
              'Login with',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 50),

            //
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    'assets/images/facebook.png',
                    width: 50,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: loginWithGoogle,
                  child: Image.asset(
                    'assets/images/google.png',
                    width: 50,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
