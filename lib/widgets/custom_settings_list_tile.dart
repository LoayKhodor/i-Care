import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomSettingsListTile extends StatelessWidget {
  const CustomSettingsListTile(
      {Key? key,
      required this.iconData,
      required this.txt,
      required this.onPressed})
      : super(key: key);

  final IconData iconData;
  final String txt;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        txt,
        style: kTextTextStyleBlack14,
      ),
      leading: Icon(iconData, color: Colors.black,),
      onTap: onPressed,
    );
  }
}
