import 'package:capstone_project/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    this.path,
    this.iconData,
    required this.onPressed,
    required this.tipText,
    this.size,
    this.color, this.enabled,
  }) : super(key: key);
  final String? path;
  final IconData? iconData;
  final VoidCallback onPressed;
  final String tipText;
  final double? size;
  final Color? color;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: (path != null)
          ? Image.asset(
              path!,
              fit: BoxFit.scaleDown,
            )
          : Icon(iconData),
      onPressed:  onPressed,
      iconSize:
          (size != null) ? setHeight(context, size!) : setHeight(context, 0.01),
      color: color ?? kRedColor,
      splashColor: color ?? kRedColor,
      splashRadius: 20.0,
      tooltip: tipText,
    );
  }
}
