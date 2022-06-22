import 'package:capstone_project/classes/user.dart';
import 'package:capstone_project/widgets/buttons.dart';
import 'package:capstone_project/constants/constants.dart';
import 'package:capstone_project/screens/general_screen.dart';
import 'package:capstone_project/widgets/registration_progress.dart';
import 'package:capstone_project/widgets/text_fields.dart';
import 'package:capstone_project/screens/gender_screen.dart';
import 'package:capstone_project/widgets/toast_error.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late AppUser user;
  late String password;
  late String confirmPassword;

  // bool continueButtonPressed = false;
  dynamic newUser;

  @override
  void initState() {
    user = AppUser(
      firstName: '',
      email: '',
      lastName: '',
    );
    password = '';
    confirmPassword = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScreen(
      screenTitle: 'Registration',
      widget: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: setHeight(context, 0.01),
            ),
            RegistrationProgress(0),
            SizedBox(
              height: setHeight(context, 0.05),
            ),
            SizedBox(
              width: setWidth(context, 0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextfield(
                      hintTxt: 'e.g. John',
                      stringType: 'regular',
                      textfieldSize: 'small',
                      labelText: 'First Name*',
                      fmt: kNamesFmt,
                      maxLength: 20,
                      onChanged: (value) => user.firstName = value),
                  SizedBox(
                    width: setWidth(context, 0.1),
                  ),
                  CustomTextfield(
                      hintTxt: 'e.g. Doe',
                      stringType: 'regular',
                      textfieldSize: 'small',
                      labelText: 'Last Name*',
                      fmt: kNamesFmt,
                      maxLength: 16,
                      onChanged: (value) => user.lastName = value),
                ],
              ),
            ),
            SizedBox(
              height: setHeight(context, 0.03),
            ),
            CustomTextfield(
                hintTxt: 'e.g. JohnDoe@email.com',
                stringType: 'regular',
                labelText: 'Email*',
                capitalize: false,
                fmt: kAlphaNumSpecialFmt,
                maxLength: 35,
                textfieldSize: 'large',
                onChanged: (value) => user.email = value),
            SizedBox(
              height: setHeight(context, 0.03),
            ),
            CustomTextfield(
                hintTxt: 'e.g. 123456 (atleast 6 characters)',
                stringType: 'password',
                labelText: 'Password* ',
                capitalize: false,
                fmt: kAlphaNumSpecialFmt,
                maxLength: 35,
                textfieldSize: 'large',
                onChanged: (value) => password = value),
            SizedBox(
              height: setHeight(context, 0.03),
            ),
            CustomTextfield(
              hintTxt: 'e.g. 12345678',
              stringType: 'password',
              labelText: 'Confirm Password*',
              capitalize: false,
              maxLength: 35,
              fmt: kAlphaNumSpecialFmt,
              textfieldSize: 'large',
              onChanged: (value) => confirmPassword = value,
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
                      Navigator.pop(context);
                    }),
                SizedBox(width: setWidth(context, 0.15)),
                //Error Handling & sending data to next page
                CustomButton(
                    txt: 'Next',
                    widthPercent: 0.4,
                    heightPercent: 0.1,
                    buttonType: 'regular',
                    //show Toast 'Invalid email' or other errors
                    onPressed: () async {
                      try {
                        //check if there are empty fields (firstName LastName...)
                        if (user.checkFields() ||
                            password.isEmpty ||
                            confirmPassword.isEmpty) {
                          FToast().init(context);
                          showCustomToast(
                              'please fill all fields', Icons.warning);
                        } else if (password != confirmPassword) {
                          FToast().init(context);
                          showCustomToast(
                              'passwords do not match', Icons.close);
                        } else {
                          // if (!continueButtonPressed) {
                          newUser = await _auth.createUserWithEmailAndPassword(
                              email: user.email, password: password);
                          // }
                          if (newUser != null) {
                            // continueButtonPressed = true;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GenderScreen(
                                  user: user,
                                  userFirebase: newUser,
                                ),
                              ),
                            );
                          }
                        }
                      } on FirebaseAuthException catch (e) {
                        FToast().init(context);
                        //there is 1 really long error i trimmed
                        showCustomToast(
                            e.code.replaceAll('-', ' '),
                            // (e.message!.contains('already in use'))
                            //     ? e.message!.substring(0, 35) + '!'
                            //     : e.message! + '!',
                            Icons.close);
                      }
                    }),
              ],
            ),
            SizedBox(
              height: setHeight(context, 0.02),
            ),
            Image(image: AssetImage('images/bg/medical_characters.png'))
          ],
        ),
      ),
    );
  }
}
