import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class PatientHeadings extends StatelessWidget {
  const PatientHeadings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: setWidth(context, 0.07),
        ),
        SizedBox(
          width: setWidth(context, 0.2),
          child: AutoSizeText(
            'MRN',
            style: kTextTextStyleRedColor12,
            minFontSize: 9,
            maxFontSize: 12,
            maxLines: 1,
          ),
        ),
        SizedBox(
          width: setWidth(context, 0.04),
        ),
        SizedBox(
          width: setWidth(context, 0.25),
          child: AutoSizeText(
            'First\nName',
            style: kTextTextStyleRedColor12,
            minFontSize: 6,
            maxFontSize: 12,
            maxLines: 2,
          ),
        ),

        SizedBox(
          width: setWidth(context, 0.25),
          child: AutoSizeText(
            'Last\nName',
            style: kTextTextStyleRedColor12,
            minFontSize: 9,
            maxFontSize: 12,
            maxLines: 2,
          ),
        ),
        SizedBox(
          width: setWidth(context, 0.1),
        ),
      ],
    );
  }
}
