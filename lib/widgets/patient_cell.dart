import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class PatientCell extends StatelessWidget {
  const PatientCell({
    Key? key,
    required this.patientData,
  }) : super(key: key);

  final String patientData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: setWidth(context, 0.2),
        child: AutoSizeText(
          patientData,
          style: kTextTextStyleBlack11,
          minFontSize: 7,
          maxFontSize: 11,
          maxLines: 1,
        ));
  }
}
