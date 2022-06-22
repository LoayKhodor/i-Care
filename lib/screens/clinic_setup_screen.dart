import 'package:capstone_project/screens/login_screen.dart';
import 'package:capstone_project/widgets/buttons.dart';
import 'package:capstone_project/constants/constants.dart';
import 'package:capstone_project/screens/general_screen.dart';
import 'package:capstone_project/widgets/registration_progress.dart';
import 'package:capstone_project/widgets/text_fields.dart';
import 'package:capstone_project/widgets/toast_error.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../classes/clinic.dart';
import '../classes/user.dart';

class ClinicSetupScreen extends StatefulWidget {
  const ClinicSetupScreen({Key? key, this.user}) : super(key: key);
  static String id = 'clinic_setup_screen';
  final AppUser? user;

  @override
  State<ClinicSetupScreen> createState() => _ClinicSetupScreenState();
}

class _ClinicSetupScreenState extends State<ClinicSetupScreen> {
  late Clinic clinic;

  @override
  void initState() {
    // TODO: implement initState
    clinic = Clinic(
        specialty: '',
        workingHours: '',
        clinicName: '',
        address: '',
        userEmails: [],
        patients: [],
        nbrOfPatients: 0,
        queue: [],
        requests: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScreen(
      screenTitle: 'Clinic Setup',
      widget: Column(
        children: <Widget>[
          RegistrationProgress(3),
          SizedBox(
            height: setHeight(context, 0.06),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTextfield(
                  hintTxt: 'e.g. Miracle',
                  stringType: 'regular',
                  textfieldSize: 'small',
                  labelText: 'Clinic Name*',
                  fmt: kTxtFmt,
                  maxLength: 30,
                  onChanged: (value) => clinic.clinicName = value),
              SizedBox(
                width: setWidth(context, 0.1),
              ),
              CustomTextfield(
                  hintTxt: 'e.g. Neurology',
                  stringType: 'regular',
                  textfieldSize: 'small',
                  labelText: 'Specialty*',
                  fmt: kTxtFmt,
                  maxLength: 30,
                  onChanged: (value) => clinic.specialty = value)
            ],
          ),
          SizedBox(
            height: setHeight(context, 0.03),
          ),
          CustomTextfield(
              hintTxt: 'e.g. Lebanon, Beirut, Hamra Street',
              stringType: 'regular',
              labelText: 'Address*',
              maxLength: 40,
              fmt: kTxtFmt,
              textfieldSize: 'large',
              onChanged: (value) => clinic.address = value),
          SizedBox(
            height: setHeight(context, 0.03),
          ),
          CustomTextfield(
              hintTxt: 'e.g. Monday - Friday 8:00 AM - 4:00 PM',
              stringType: 'regular',
              labelText: 'Working Hours',
              fmt: kTxtFmt,
              maxLength: 40,
              textfieldSize: 'large',
              onChanged: (value) => clinic.workingHours = value),
          SizedBox(
            height: setHeight(context, 0.03),
          ),
          // CustomTextfield(
          //     hintTxt: 'e.g. clinic0001',
          //     stringType: 'regular',
          //     labelText: 'Clinic ID*',
          //     maxLength: 12,
          //     fmt: kAlphaNumSpecialFmt,
          //     textfieldSize: 'large',
          //     onChanged: (value) => clinic.Id = value),
          SizedBox(
            height: setHeight(context, 0.14),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomButton(
                  txt: 'Back',
                  widthPercent: 0.4,
                  heightPercent: 0.1,
                  buttonType: 'back',
                  onPressed: () => Navigator.pop(context)),
              SizedBox(width: setWidth(context, 0.15)),
              CustomButton(
                txt: 'Submit',
                widthPercent: 0.4,
                heightPercent: 0.1,
                buttonType: 'regular',
                onPressed: () async {
                  if (clinic.checkFields()) {
                    FToast().init(context);
                    showCustomToast('please fill all fields', Icons.warning);
                  }
                  // else if (clinic.Id.length < 8) {
                  //   FToast().init(context);
                  //   showCustomToast(
                  //       'ID should be at least 8 characters', Icons.warning);
                  // }
                  else {
                    clinic.userEmails.add(widget.user!.email);
                    await AppUser.usersRef.add(widget.user!);
                    await Clinic.clinicsRef.add(clinic);
                    Navigator.pushNamed(context, LoginScreen.id);
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: setHeight(context, 0.02),
          ),
          Image(image: AssetImage('images/bg/medical_characters.png'))
        ],
      ),
    );
  }
}
