import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../screens/login_screen.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kBackgroundColor,
      title: Text(
        "Are you sure you want to logout?",
        style: kTextTextStyleRedColor14Bold,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        //logout
        TextButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, LoginScreen.id);
          },
          child: Text("Logout"),
        ),
      ],
    );
  }
}
