import 'package:capstone_project/classes/gender.dart';
import 'package:capstone_project/constants/constants.dart';
import 'package:flutter/material.dart';

class GenderCard extends StatelessWidget {
  Gender _gender;
  GenderCard(this._gender);


  @override
  Widget build(BuildContext context) {
    return Card(
      color: (_gender.isSelected) ? kRedColor : kBackgroundColor,
      elevation: 20.0,
      child: Container(
        height: setHeight(context, 0.13),
        width: setWidth(context, 0.4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          // border: Border.all(color: kRedColor, width: 2.0),
        ),
        // margin: EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(_gender.iconData,
                color: _gender.isSelected ? kBackgroundColor : kRedColor,
                size: setWidth(context, 0.1)),
            SizedBox(
              height: setHeight(context, 0.01),
            ),
            Text(
              _gender.txt,
              style: _gender.isSelected ? kTextTextStyleBlue14 : kTextTextStyleBlack14,
            ),
          ],
        ),
      ),
    );
  }
}
