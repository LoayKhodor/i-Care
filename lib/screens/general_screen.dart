import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';

class GeneralScreen extends StatelessWidget {
  const GeneralScreen(
      {Key? key, required this.widget, required this.screenTitle, this.width})
      : super(key: key);
  final String screenTitle;
  final Widget widget;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: (width != null)
                  ? setWidth(context, width!)
                  : setWidth(context, 0.8),
              height: setHeight(context, 1),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AutoSizeText(
                      screenTitle,
                      style: kTitleTextStyle,
                      minFontSize: 40,
                      maxLines: 1,
                      maxFontSize: 45,
                    ),
                    widget,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
