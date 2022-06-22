import 'package:capstone_project/constants/constants.dart';
import 'package:capstone_project/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';

class RegistrationProgress extends StatefulWidget {
  int index;

  RegistrationProgress(this.index);

  @override
  State<RegistrationProgress> createState() => _RegistrationProgressState();
}

class _RegistrationProgressState extends State<RegistrationProgress> {
  Future<int> changeIndex(idx) async {
    setState(() {
      widget.index = idx;
    });
    return idx;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: changeIndex(widget.index),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return DotStepper(
          activeStep: widget.index,
          dotCount: 4,
          spacing: 40.0,
          dotRadius: 6.0,
          direction: Axis.horizontal,
          indicator: Indicator.slide,
          fixedDotDecoration: FixedDotDecoration(color: kDarkBlueColor),
          indicatorDecoration:
              IndicatorDecoration(color: kRedColor, strokeColor: kRedColor),
          lineConnectorsEnabled: true,
          lineConnectorDecoration:
              LineConnectorDecoration(color: kLightBlueColor),
          tappingEnabled: false,
        );
      },
    );
  }
}


