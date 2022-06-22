import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone_project/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage extends StatelessWidget {
  const ToastMessage({Key? key, required this.msg, required this.iconData})
      : super(key: key);

  final String msg;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    bool checkMsg(String msg) {
      if ((msg.contains('Success')) || (msg.contains('Successfully'))) {
        return false;
      }
      return true;
    }

    return Container(
      //takes 70% of screen width & displayed at the bottom center
      width: setWidth(context, 0.7),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color:
            (checkMsg(msg) == true) ? kRedColor : Colors.greenAccent.shade700,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: kBackgroundColor,
          ),
          SizedBox(
            width: setWidth(context, 0.02),
          ),
          Expanded(
            child: AutoSizeText(
              msg,
              style: kTextTextStyleWhite14,
              maxLines: 1,
              minFontSize: 9,
              maxFontSize: 14,
              softWrap: true,
              wrapWords: true,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

void showCustomToast(String msg, IconData iconData) {
  FToast().showToast(
    child: ToastMessage(msg: msg, iconData: iconData),
    toastDuration: const Duration(seconds: 2),
    gravity: ToastGravity.BOTTOM,
  );
}
