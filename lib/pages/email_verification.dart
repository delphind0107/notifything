import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({super.key});

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'Verify your Email Here',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 45,
            ),
          ),
          const Text('we already sended a verification email'),
          TextButton(
            onPressed: () {
              final userEmail = FirebaseAuth.instance.currentUser;
              userEmail?.sendEmailVerification();
            },
            child: const Text("Click here to verify if you didn't get a email"),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/SigninView/');
            },
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}
