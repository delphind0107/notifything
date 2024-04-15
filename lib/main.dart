import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myfirstnote/firebase_options.dart';
import 'package:myfirstnote/pages/email_verification.dart';
import 'package:myfirstnote/pages/mainui_view.dart';
import 'package:myfirstnote/pages/registration.dart';
import 'package:myfirstnote/pages/sing_in.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/registration_view/': (context) => const RegistrationView(),
        '/Email_registrationView/': (context) => const EmailVerificationView(),
        '/SigninView/': (context) => const SigninView(),
        '/main_ui/': (context) => const MainUi(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final userCredentials = FirebaseAuth.instance.currentUser;
            if (userCredentials != null) {
              if (userCredentials.emailVerified) {
                return const MainUi();
              } else {
                return const EmailVerificationView();
              }
            } else {
              return const SigninView();
            }
          default:
            const CircularProgressIndicator();
        }
        return const MainUi();
      },
    );
  }
}
