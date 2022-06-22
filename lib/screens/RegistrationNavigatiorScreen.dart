// import 'package:capstone_project/screens/clinic_setup_screen.dart';
// import 'package:capstone_project/screens/gender_screen.dart';
// import 'package:capstone_project/screens/registration_screen.dart';
// import 'package:capstone_project/screens/specialty_screen.dart';
// import 'package:flutter/material.dart';
//
// class RegistrationNavigatorScreen extends StatefulWidget {
//   const RegistrationNavigatorScreen({Key? key}) : super(key: key);
//
//   static String id = 'registration_navigator_screen';
//   static int regIndex=0;
//   @override
//   State<RegistrationNavigatorScreen> createState() =>
//       _RegistrationNavigatorScreenState();
// }
//
// class _RegistrationNavigatorScreenState
//     extends State<RegistrationNavigatorScreen> {
//   late List<Widget> pages;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       RegistrationNavigatorScreen.regIndex = index;
//     });
//   }
//
//   void initState() {
//     // TODO: implement initState
//     RegistrationNavigatorScreen.regIndex = 0;
//     pages = [
//       const RegistrationScreen(),
//       const GenderScreen(),
//       const SpecialtyScreen(),
//       const ClinicSetupScreen(),
//     ];
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: RegistrationNavigatorScreen.regIndex,
//         children: pages,
//       ),
//
//     );
//   }
// }
