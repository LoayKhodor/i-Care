import 'package:flutter/material.dart';
import '../constants/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.txt,
    required this.widthPercent,
    required this.heightPercent,
    required this.buttonType,
    required this.onPressed,
    this.borderWidth,
    this.isUnderlined,
    // required this.onPressed,
  }) : super(key: key);
  final String txt;
  final double widthPercent;
  final double heightPercent;
  final String buttonType;
  final VoidCallback onPressed;
  final double? borderWidth;
  final bool? isUnderlined;

  // final Function onPressed;

// final Function fnct;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: setWidth(context, widthPercent),
        minWidth: setWidth(context, widthPercent / 1.5),
        maxHeight: setHeight(context, heightPercent),
        minHeight: setHeight(context, heightPercent / 1.5),
      ),
      child: TextButton(
        onPressed: onPressed,
        // Navigator.pushNamed(context, RegistrationScreen.id);
        child: Text(
          txt,
        ),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double?>(10),
          textStyle:
              MaterialStateProperty.all<TextStyle>(kTextTextStyleRedColor14),
          backgroundColor: (buttonType == 'back')
              ? MaterialStateProperty.all<Color>(kBackgroundColor)
              : MaterialStateProperty.all<Color>(kRedColor),
          foregroundColor: (buttonType == 'back')
              ? MaterialStateProperty.all<Color>(kRedColor)
              : MaterialStateProperty.all<Color>(kWhiteTextColor),
          // maximumSize: MaterialStateProperty.all<Size>(Size.fromWidth(setWidth(context, 0.3))),
          side: MaterialStateProperty.all(
            BorderSide(
              //hide the border when borderWidth is Changed (used to hide border if needed)
              color: kRedColor,
              width: (borderWidth != null) ? borderWidth! : 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
