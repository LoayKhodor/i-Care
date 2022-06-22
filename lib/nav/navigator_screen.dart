import 'package:capstone_project/classes/news.dart';
import 'package:capstone_project/nav/patients_screen.dart';
import 'package:capstone_project/nav/queue_screen.dart';
import 'package:capstone_project/nav/welcome_screen.dart';
import 'package:capstone_project/dialogs/pulse_dialog.dart';
import 'package:flutter/material.dart';

import '../classes/corona.dart';
import '../constants/constants.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({
    Key? key,
    this.futureCorona,
    this.futureNews,
    this.clinicID,
    this.specialty,
  }) : super(key: key);

  static String id = 'navigator_nurse';
  final Future<Corona>? futureCorona;
  final Future<MedicalNews>? futureNews;
  final String? clinicID;
  final String? specialty;

  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  late List<Widget> pages;
  late int selectedIndex;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      selectedIndex = 0;
      pages = [
        WelcomeScreen(
            futureCorona: widget.futureCorona!,
            futureNews: widget.futureNews!,
            clinicID: widget.clinicID!),
        QueueScreen(
          selectedPath: widget.specialty=='nurse'?'icons/custom_pulse.png':'icons/custom_clipboard.png',
          tipText: 'Enter Vitals',
          clinicID: widget.clinicID!,
          specialty: widget.specialty,
        ),
        PatientsScreen(clinicID: widget.clinicID!),
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        selectedLabelStyle: kTextTextStyleBlue14,
        unselectedLabelStyle: kTextTextStyleBlue14,
        selectedItemColor: kBackgroundColor,
        type: BottomNavigationBarType.fixed,
        backgroundColor: kRedColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image.asset('icons/custom_home.png'), label: 'Home'),
          BottomNavigationBarItem(
              icon: Image.asset('icons/custom_queue.png'), label: 'Queue'),
          BottomNavigationBarItem(
              icon: Image.asset('icons/custom_patient.png'), label: 'Patients'),
        ],
      ),
    );
  }
}
