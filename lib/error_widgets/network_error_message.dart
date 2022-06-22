import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone_project/classes/corona.dart';
import 'package:capstone_project/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import '../classes/news.dart';
import '../constants/constants.dart';
import '../screens/login_screen.dart';

class NetworkErrorMessage extends StatefulWidget {
  const NetworkErrorMessage({Key? key, this.onPressed,})
      : super(key: key);
  final VoidCallback? onPressed;

  @override
  State<NetworkErrorMessage> createState() => _NetworkErrorMessageState();
}

class _NetworkErrorMessageState extends State<NetworkErrorMessage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              'Check your \ninternet connection!',
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.start,
              maxLines: 2,
              maxFontSize: 14,
              minFontSize: 12,
            ),
            CustomIconButton(
              onPressed: widget.onPressed!,
              tipText: 'Refresh',
              iconData: Icons.refresh,
              size: 0.04,
            )
          ],
        ),
        SizedBox(
          width: setWidth(context, 0.7),
          height: setHeight(context, 0.35),
          child: Image(
            image: AssetImage('images/bg/first_aid.png'),
          ),
        )
      ],
    );
  }
}
