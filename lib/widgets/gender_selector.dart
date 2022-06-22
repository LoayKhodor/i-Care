import 'package:capstone_project/constants/constants.dart';
import 'package:capstone_project/screens/gender_screen.dart';
import 'package:capstone_project/cards/gender_card.dart';
import 'package:flutter/material.dart';

import '../classes/gender.dart';

class GenderSelector extends StatefulWidget {
  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  List<Gender> genders = <Gender>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genders.add(new Gender('male', Icons.male, false));
    genders.add(new Gender('female', Icons.female, false));
    genders.add(new Gender('other', Icons.transgender, false));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: genders.length,
        itemBuilder: (context, index) => InkWell(
              splashColor: kRedColor,
              onTap: () {
                setState(() {
                  genders.forEach((gender) => gender.isSelected = false);
                  genders[index].isSelected = true;
                  // widget.genderIndex = index;
                  // selectedGender = genders[index].txt;
                  GenderScreen.selectedGender = genders[index].txt;
                });
              },
              child: GenderCard(genders[index]),
            ));
  }
}
