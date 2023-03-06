import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_with_google_and_fb/dialog_login_fb.dart';

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

  Future<void> loginWithFB() async {
    final result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      // you are logged
      final userData = await FacebookAuth.instance.getUserData();

      showDialog(
        context: context,
        builder: (ctx) => DialogLoginFaceBook(
          name: userData['name'],
          email: userData['email'],
          img: userData['picture']['data']['url'],
          logout: logoutFB,
        ),
      );
    } else {
      debugPrint('${result.status}');
      debugPrint(result.message);
    }
  }

  Future<void> logoutFB() async {
    await FacebookAuth.instance.logOut();
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
                  onTap: loginWithFB,
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
