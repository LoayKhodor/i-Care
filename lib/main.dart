import 'package:capstone_project/nav/edit_patient_screen.dart';
import 'package:capstone_project/nav/patients_screen.dart';
import 'package:capstone_project/nav/search_screen.dart';
import 'package:capstone_project/nav/welcome_screen.dart';
import 'package:capstone_project/screens/login_screen.dart';
import 'package:capstone_project/nav/queue_screen.dart';
import 'package:capstone_project/screens/nurse_guide.dart';
import 'package:capstone_project/screens/registration_screen.dart';
import 'package:capstone_project/screens/clinic_setup_screen.dart';
import 'package:capstone_project/screens/gender_screen.dart';
import 'package:capstone_project/screens/specialty_screen.dart';
import 'package:capstone_project/nav/navigator_screen.dart';
import 'package:capstone_project/widgets/pdfViewer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoadingScreen(),
      routes: {
        LoadingScreen.id: (context) => const LoadingScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        GenderScreen.id: (context) => const GenderScreen(),
        ClinicSetupScreen.id: (context) => const ClinicSetupScreen(),
        SpecialtyScreen.id: (context) => const SpecialtyScreen(),
        SearchScreen.id: (context) => SearchScreen(
              email: '',
            ),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        QueueScreen.id: (context) => QueueScreen(),
        PatientsScreen.id: (context) => const PatientsScreen(),
        NavigatorScreen.id: (context) => const NavigatorScreen(),
        EditPatientScreen.id: (context) => const EditPatientScreen(
              snapshot: {},
            ),
        NurseGuideScreen.id: (context) => const NurseGuideScreen(),
        pdfView.id: (context) => const pdfView(),
      },
    );
  }
}
