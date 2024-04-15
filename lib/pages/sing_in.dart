import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myfirstnote/firebase_options.dart';
import 'package:myfirstnote/pages/alert_dialog.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case (ConnectionState.done):
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Signin here to enjoy our app",
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        hintText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                      ),
                      controller: _email,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                      ),
                      controller: _password,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user not found') {
                          await showAlertDialog(
                            context,
                            "user id not found ",
                          );
                        } else if (e.code == "weak-password") {
                          await showAlertDialog(
                            context,
                            "user password is weak ",
                          );
                        } else if (e.code == "user not login") {
                          await showAlertDialog(
                            context,
                            "user not login yet ",
                          );
                        } else {
                          await showAlertDialog(
                            context,
                            "${e.code} ",
                          );
                        }
                      } catch (e) {
                        await showAlertDialog(
                          context,
                          e.toString(),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.blue,
                      ),
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 40,
                      child: const Text(
                        'login',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/registration_view/');
                    },
                    child:
                        const Text('Not Register yet? click here to register!'),
                  ),
                ],
              ),
            );
          default:
            const CircularProgressIndicator();
            return const Text("You are not register");
        }
      },
    );
  }
}
