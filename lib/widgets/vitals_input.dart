import 'package:flutter/cupertino.dart';

import '../constants/constants.dart';

class VitalsInput extends StatelessWidget {
  const VitalsInput({Key? key, required this.widgetList}) : super(key: key);

  final List<Widget> widgetList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: setHeight(context, 0.12),
      width: setWidth(context, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgetList,
      ),
    );
  }
}
