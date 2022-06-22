import 'package:capstone_project/classes/user.dart';
import 'package:capstone_project/constants/constants.dart';
import 'package:capstone_project/screens/clinic_setup_screen.dart';
import 'package:capstone_project/screens/gender_screen.dart';
import 'package:capstone_project/screens/login_screen.dart';
import 'package:capstone_project/screens/nurse_guide.dart';
import 'package:capstone_project/widgets/buttons.dart';
import 'package:capstone_project/screens/general_screen.dart';
import 'package:capstone_project/widgets/registration_progress.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/toast_error.dart';

class SpecialtyScreen extends StatefulWidget {
  const SpecialtyScreen({Key? key, this.user}) : super(key: key);
  static String id = 'specialty_screen';
  final AppUser? user;
  static String selectedSpecialty = '';

  @override
  State<SpecialtyScreen> createState() => _SpecialtyScreenState();
}

class _SpecialtyScreenState extends State<SpecialtyScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller2;
  late Animation<double> animation;
  late Animation<double> animation2;
  bool animation1Playing = false;

  @override
  void initState() {
    // TODO: implement initState
    //animation controller for icon animation
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100))
      ..addListener(() {
        setState(() {});
      });
    controller2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100))
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //when icon is clicked --> grow its size
    animation = Tween<double>(
            begin: setHeight(context, 0.2), end: (setHeight(context, 0.25)))
        .animate(controller)
      ..addStatusListener((status) {});
    animation2 = Tween<double>(
            begin: setHeight(context, 0.2), end: (setHeight(context, 0.15)))
        .animate(controller2)
      ..addStatusListener((status) {});
    return GeneralScreen(
      screenTitle: 'Specialty',
      widget: Column(
        children: <Widget>[
          SizedBox(
            height: setHeight(context, 0.01),
          ),
          RegistrationProgress(2),
          SizedBox(
            height: setHeight(context, 0.05),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                SpecialtyScreen.selectedSpecialty = 'doctor';
                print(SpecialtyScreen.selectedSpecialty);
                animation1Playing = true;
              });
              //play both animations to take their values
              controller.forward();
              controller2.forward();
            },
            icon: Image.asset(
                'icons/custom_doc_${GenderScreen.selectedGender}.png'),
            iconSize: animation1Playing ? animation.value : animation2.value,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                SpecialtyScreen.selectedSpecialty = 'nurse';
                print(SpecialtyScreen.selectedSpecialty);
                animation1Playing = false;
              });
              //play both animations to take their values
              controller2.forward();
              controller.forward();
            },
            icon: Image.asset(
                'icons/custom_nurse_${GenderScreen.selectedGender}.png'),
            iconSize: animation1Playing ? animation2.value : animation.value,
          ),
          SizedBox(
            height: setHeight(context, 0.05),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomButton(
                txt: 'Back',
                widthPercent: 0.4,
                heightPercent: 0.1,
                buttonType: 'back',
                onPressed: () {
                  print(SpecialtyScreen.selectedSpecialty);
                  SpecialtyScreen.selectedSpecialty = '';
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: setWidth(context, 0.15)),
              CustomButton(
                txt: 'Next',
                widthPercent: 0.4,
                heightPercent: 0.1,
                buttonType: 'regular',
                onPressed: () async {
                  if (SpecialtyScreen.selectedSpecialty != '') {
                    widget.user!.specialty = SpecialtyScreen.selectedSpecialty;
                    print(widget.user.toString());
                    if (SpecialtyScreen.selectedSpecialty == 'doctor') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ClinicSetupScreen(user: widget.user),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NurseGuideScreen(
                            user: widget.user,
                          ),
                        ),
                      );
                    }
                  } else {
                    FToast().init(context);
                    showCustomToast('Please select Specialty!', Icons.warning);
                  }
                },
              ),

              // Image(image: AssetImage('images/bg/medical_characters.png'),),
            ],
          ),
          SizedBox(
            height: setHeight(context, 0.02),
          ),
          Image(image: AssetImage('images/bg/medical_characters.png')),
        ],
      ),
    );
  }
}
