import 'package:capstone_project/screens/clinic_setup_screen.dart';
import 'package:capstone_project/screens/specialty_screen.dart';
import 'package:capstone_project/widgets/buttons.dart';
import 'package:capstone_project/widgets/gender_selector.dart';
import 'package:capstone_project/constants/constants.dart';
import 'package:capstone_project/screens/general_screen.dart';
import 'package:capstone_project/widgets/registration_progress.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../classes/user.dart';
import '../widgets/toast_error.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({Key? key, this.user, this.userFirebase})
      : super(key: key);
  static String id = 'gender_screen';
  final AppUser? user;
  final UserCredential? userFirebase;

  //insert in User Doctor/Patient class object
  static String selectedGender = '';

  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  @override
  Widget build(BuildContext context) {
    return GeneralScreen(
      screenTitle: 'Gender',
      widget: Column(
        children: <Widget>[
          SizedBox(
            height: setHeight(context, 0.01),
          ),
          RegistrationProgress(1),
          SizedBox(
            height: setHeight(context, 0.05),
          ),
          SizedBox(
              width: setWidth(context, 0.35),
              height: setHeight(context, 0.5),
              child: GenderSelector()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomButton(
                txt: 'Back',
                widthPercent: 0.4,
                heightPercent: 0.1,
                buttonType: 'back',
                onPressed: () {
                  FirebaseAuth.instance.currentUser!.delete();
                  Navigator.pop(context);
                  // print(GenderScreen.selectedGender);
                  GenderScreen.selectedGender = '';
                },
              ),
              SizedBox(width: setWidth(context, 0.15)),
              CustomButton(
                txt: 'Next',
                widthPercent: 0.4,
                heightPercent: 0.1,
                buttonType: 'regular',
                onPressed: () {
                  if (GenderScreen.selectedGender != '') {
                    widget.user!.selectedGender = GenderScreen.selectedGender;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpecialtyScreen(
                          user: widget.user,
                        ),
                      ),
                    );
                  } else {
                    FToast().init(context);
                    showCustomToast('Please select gender!', Icons.warning);
                  }
                },
              ),

              // Image(image: AssetImage('images/bg/medical_characters.png'),),
            ],
          ),
          SizedBox(
            height: setHeight(context, 0.02),
          ),
          Image(
            image: AssetImage('images/bg/medical_characters.png'),
          ),
        ],
      ),
    );
  }
}
