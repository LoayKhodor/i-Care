import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone_project/screens/login_screen.dart';
import 'package:capstone_project/widgets/buttons.dart';
import 'package:flutter/material.dart';

import '../classes/user.dart';
import '../constants/constants.dart';
import '../widgets/registration_progress.dart';
import 'general_screen.dart';

class NurseGuideScreen extends StatelessWidget {
  const NurseGuideScreen({Key? key, this.user}) : super(key: key);
  static String id = 'nurse_guide';
  final AppUser? user;

  @override
  Widget build(BuildContext context) {
    return GeneralScreen(
      screenTitle: 'Guide',
      widget: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: setHeight(context, 0.01),
            ),
            RegistrationProgress(3),
            SizedBox(
              height: setHeight(context, 0.05),
            ),
            SizedBox(
              height: setHeight(context, 0.25),
              width: setWidth(context, 0.7),
              child: AutoSizeText(
                'Once you log in to your account for the first time,'
                ' you shall register in a clinic.\n\n'
                'You can search for the doctor\'s email'
                '\n\nOnce your request is approved you\'ll have access to the data of that clinic',
                minFontSize: 11,
                maxFontSize: 12,
                softWrap: true,
                wrapWords: true,
                style: kTextTextStyleBlack11Bold,
              ),
            ),
            Image(
              image: AssetImage('images/bg/nurse_and_equipment.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  txt: 'Back',
                  widthPercent: 0.4,
                  heightPercent: 0.1,
                  buttonType: 'back',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CustomButton(
                  txt: 'Next',
                  widthPercent: 0.4,
                  heightPercent: 0.1,
                  buttonType: 'regular',
                  onPressed: () async {
                    await AppUser.usersRef.add(user!);
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
