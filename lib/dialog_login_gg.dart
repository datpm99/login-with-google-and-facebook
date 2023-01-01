import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DialogLoginGoogle extends StatelessWidget {
  const DialogLoginGoogle({
    Key? key,
    required this.googleUser,
    required this.logout,
  }) : super(key: key);
  final GoogleSignInAccount googleUser;
  final VoidCallback logout;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Login with google success!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(googleUser.photoUrl!),
            ),
            const SizedBox(height: 5),
            Text('Name: ${googleUser.displayName}'),
            Text('Email: ${googleUser.email}'),
            TextButton(
              onPressed: logout,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
