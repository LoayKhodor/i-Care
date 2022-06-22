import 'package:capstone_project/nav/navigator_screen.dart';
import 'package:capstone_project/nav/search_screen.dart';
import 'package:capstone_project/widgets/buttons.dart';
import 'package:capstone_project/constants/constants.dart';
import 'package:capstone_project/screens/general_screen.dart';
import 'package:capstone_project/widgets/text_fields.dart';
import 'package:capstone_project/screens/registration_screen.dart';
import 'package:capstone_project/widgets/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../classes/corona.dart';
import '../classes/news.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'login_screen';

  // static String currentCountry = '';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Future<Corona> futureCorona;
  late Future<MedicalNews> futureNews;
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;
  dynamic user;

  @override
  void initState() {
    // TODO: implement initState
    email = '';
    password = '';
    fetchData();
    super.initState();
  }

  void fetchData() async {
    futureCorona = fetchCoronaData();
    futureNews = fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GeneralScreen(
        screenTitle: 'Login',
        widget: Column(
          children: <Widget>[
            SizedBox(
              height: setHeight(context, 0.1),
            ),
            SizedBox(
              height: setHeight(context, 0.03),
            ),
            CustomTextfield(
                hintTxt: 'e.g. JohnDoe@email.com',
                stringType: 'regular',
                labelText: 'Email*',
                capitalize: false,
                textfieldSize: 'large',
                fmt: kAlphaNumSpecialFmt,
                maxLength: 35,
                onChanged: (value) => email = value),
            SizedBox(
              height: setHeight(context, 0.03),
            ),
            CustomTextfield(
              hintTxt: 'e.g. 12345678',
              stringType: 'password',
              textfieldSize: 'large',
              capitalize: false,
              labelText: 'Password*',
              fmt: kAlphaNumSpecialFmt,
              maxLength: 35,
              onChanged: (value) => password = value,
            ),
            SizedBox(
              height: setHeight(context, 0.1),
            ),
            CustomButton(
                txt: 'Login',
                widthPercent: 0.4,
                heightPercent: 0.1,
                buttonType: 'regular',
                onPressed: () async {
                  try {
                    if (email.isEmpty || password.isEmpty) {
                      FToast().init(context);
                      showCustomToast('please fill all fields', Icons.warning);
                    } else {
                      user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        //Fetch the clinicID & load UI based on Specialty
                        String clinicID = "";
                        String specialty = "";
                        await FirebaseFirestore.instance
                            .collection('clinics')
                            .where('userEmails', arrayContains: email)
                            .get()
                            .then((snapshot) =>
                                clinicID = snapshot.docs[0].id.toString())
                            .onError((error, stackTrace) => clinicID = '');
                        // print(clinicID);
                        //fetch the user's specialty to load the UI
                        await FirebaseFirestore.instance
                            .collection('appUsers')
                            .where('email', isEqualTo: email)
                            .get()
                            .then((snapshot) => specialty =
                                snapshot.docs[0].data()['specialty']);
                        // print(specialty);
                        //load SearchScreen if nurse is not registered in a clinic
                        //else load the nurse UI
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => (clinicID == '')
                                ? SearchScreen(email: email)
                                : NavigatorScreen(
                                    futureCorona: futureCorona,
                                    futureNews: futureNews,
                                    clinicID: clinicID,
                                    specialty: specialty,
                                  ),
                          ),
                        );
                      }
                    }
                  } on FirebaseAuthException catch (e) {
                    FToast().init(context);
                    showCustomToast(e.code.replaceAll('-', ' '), Icons.close);
                  }
                }),
            SizedBox(
              height: setHeight(context, 0.03),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account? ',
                  style: kTextTextStyleRedColor12,
                ),
                GestureDetector(
                  child: Text(
                    'Sign Up',
                    style: kTextTextStyleRedColor12Underline,
                  ),
                  onTap: () =>
                      Navigator.pushNamed(context, RegistrationScreen.id),
                ),
              ],
            ),
            SizedBox(
              height: setHeight(context, 0.07),
            ),
            Image(
              image: AssetImage('images/bg/medical_characters.png'),
              height: setHeight(context, 0.2),
            ),
          ],
        ),
      ),
    );
  }
}
