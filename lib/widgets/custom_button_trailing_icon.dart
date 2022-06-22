import 'package:capstone_project/constants/constants.dart';
import 'package:flutter/material.dart';

//Custom Button with leading icon
class CustomButtonTrailingIcon extends StatelessWidget {
  const CustomButtonTrailingIcon({
    Key? key,
    this.url,
    required this.txt,
    required this.onPressed,
    this.iconData,
  }) : super(key: key);
  final String? url;
  final String txt;
  final VoidCallback onPressed;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: setWidth(context, 0.33),
      height: setHeight(context, 0.08),
      child: Card(
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          trailing: url != null
              ? Image.asset(
                  url!,
                  width: setWidth(context, 0.06),
                  height: setHeight(context, 0.06),
                )
              : Icon(
                iconData,
                color: kBackgroundColor,
              ),
          title: Text(
            txt,
            style: kTextTextStyleBlue11,
          ),
          tileColor: kRedColor,
          horizontalTitleGap: 20,
          onTap: onPressed,
        ),
      ),
    );
  }
}
