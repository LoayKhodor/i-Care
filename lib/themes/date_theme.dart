import 'package:flutter/material.dart';

import '../constants/constants.dart';

class DateTheme extends StatelessWidget {
  const DateTheme({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: ThemeData(
        colorScheme: const ColorScheme.light(
          onPrimary: Colors.black,
          primary: kRedColor,
        ),
        backgroundColor: kBackgroundColor,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.blue, // button text color
          ),
        ),
      ),
    );
  }
}
