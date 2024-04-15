import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainUi extends StatelessWidget {
  const MainUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notify'),
        centerTitle: true,
        actions: [
          PopupMenuButton<LogOut>(
            onSelected: (value) async {
              switch (value) {
                case LogOut.logout:
                  final signOut = await logoutOption(context);
                  if (signOut) {
                    await FirebaseAuth.instance.signOut();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/SigninView/', (_) => false);
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<LogOut>(
                  value: LogOut.logout,
                  child: Text('logput'),
                ),
              ];
            },
          )
        ],
      ),
    );
  }
}

enum LogOut { logout }

Future<bool> logoutOption(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: const Text('Really wanna signout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("signout"),
          )
        ],
      );
    },
  ).then((value) => value ?? false);
}
