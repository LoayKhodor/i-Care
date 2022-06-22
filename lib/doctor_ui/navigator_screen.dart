// import 'package:flutter/material.dart';
// import '../classes/corona.dart';
// import '../classes/news.dart';
// import '../constants/constants.dart';
// import '../nav/patients_screen.dart';
// import '../nav/queue_screen.dart';
// import '../nav/welcome_screen.dart';
// import '../dialogs/medical_record_dialog.dart';
//
// class DoctorNavigatorScreen extends StatefulWidget {
//   const DoctorNavigatorScreen(
//       {Key? key, this.futureCorona, this.futureNews, this.clinicID, this.MRN})
//       : super(key: key);
//   static String id = 'navigator_doctor';
//   final Future<Corona>? futureCorona;
//   final Future<MedicalNews>? futureNews;
//   final String? clinicID;
//   final String? MRN;
//
//   @override
//   State<DoctorNavigatorScreen> createState() => _DoctorNavigatorScreenState();
// }
//
// class _DoctorNavigatorScreenState extends State<DoctorNavigatorScreen> {
//   late List<Widget> pages;
//   late int selectedIndex;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     selectedIndex = 0;
//     pages = [
//       WelcomeScreen(
//         futureCorona: widget.futureCorona!,
//         futureNews: widget.futureNews!,
//         clinicID: widget.clinicID!,
//       ),
//       QueueScreen(
//         selectedPath: 'icons/custom_clipboard.png',
//         tipText: 'Add to Medical Record',
//         clinicID: widget.clinicID!,
//         specialty: 'doctor',
//         MRN: widget.MRN,
//       ),
//       PatientsScreen(clinicID: widget.clinicID!,),
//     ];
//     super.initState();
//   }
//
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: selectedIndex,
//         children: pages,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: selectedIndex,
//         onTap: _onItemTapped,
//         selectedLabelStyle: kTextTextStyleBlue14,
//         unselectedLabelStyle: kTextTextStyleBlue14,
//         selectedItemColor: kBackgroundColor,
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: kRedColor,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//               icon: Image.asset('icons/custom_home.png'), label: 'Home'),
//           BottomNavigationBarItem(
//               icon: Image.asset('icons/custom_queue.png'), label: 'Queue'),
//           BottomNavigationBarItem(
//               icon: Image.asset('icons/custom_patient.png'), label: 'Patients'),
//         ],
//       ),
//     );
//   }
// }
