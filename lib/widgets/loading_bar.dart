//Loading Bar Borders
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class LoadingBar extends StatelessWidget {
  const LoadingBar({
    Key? key,
    required this.controller,
    required this.BorderWidth,
  }) : super(key: key);

  final AnimationController controller;
  final double BorderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: setWidth(context, 0.7),
      decoration: BoxDecoration(
        color: kTextColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          left: BorderSide(color: kTextColor, width: BorderWidth),
          right: BorderSide(color: kTextColor, width: BorderWidth),
          top: BorderSide(color: kTextColor, width: BorderWidth),
          bottom: BorderSide(color: kTextColor, width: BorderWidth),
        ),
      ),
      padding: EdgeInsets.all(2), //border width
      child: LinearProgressIndicator(
        value: controller.value,
        color: kRedColor,
        backgroundColor: kLightBlueColor,
        minHeight: setWidth(context, 0.07),
      ),
    );
  }
}