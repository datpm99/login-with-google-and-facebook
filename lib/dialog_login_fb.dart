import 'package:flutter/material.dart';

class DialogLoginFaceBook extends StatelessWidget {
  const DialogLoginFaceBook({
    Key? key,
    required this.name,
    required this.email,
    required this.img,
    required this.logout,
  }) : super(key: key);
  final String name, email, img;
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
              'Login with facebook success!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(img),
            ),
            const SizedBox(height: 5),
            Text('Name: $name'),
            Text('Email: $email'),
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
