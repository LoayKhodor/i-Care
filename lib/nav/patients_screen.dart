import 'package:capstone_project/classes/clinic.dart';
import 'package:capstone_project/dialogs/add_patient_dialog.dart';
import 'package:capstone_project/nav/edit_patient_screen.dart';
import 'package:capstone_project/widgets/custom_icon_button.dart';
import 'package:capstone_project/screens/general_screen2.dart';
import 'package:capstone_project/widgets/patient_headings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/constants/constants.dart';
import '../widgets/patient_cell.dart';
import '../widgets/text_fields.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({Key? key, this.clinicID}) : super(key: key);
  static String id = 'patients_screen';
  final String? clinicID;

  @override
  _PatientsScreenState createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  ScrollController controller = ScrollController();

  // List tempList = FetchPatientList.patientInstance.getPatientList;
  String dropDownItemBloodSelected = 'A+';
  String dropDownItemGenderSelected = 'Male';
  String dropDownItemStatusSelected = 'Married';
  String searchedPatient = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GeneralScreen2(
        screenTitle: 'Patients',
        clinicID: widget.clinicID,
        width: 1,
        widget: Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      SizedBox(
                        width: setWidth(context, 0.16),
                      ),
                      Center(
                        child: PatientSearchField(
                          onChanged: (newValue) {
                            setState(() {
                              searchedPatient = newValue!;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: setWidth(context, 0.1),
                      ),
                      Positioned(
                        right: 20,
                        child: CustomIconButton(
                          path: 'icons/custom_add.png',
                          tipText: 'Add New Patient',
                          onPressed: () => showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              //statefulBuilder to change the state of the alertDialog
                              //update the date instantly once selected
                              return AddPatientDialog(
                                clinicID: widget.clinicID!,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: setHeight(context, 0.05),
                  ),
                  const PatientHeadings(), //MRN Fname Lname
                  SizedBox(
                    height: setHeight(context, 0.02),
                  ),
                  StreamBuilder<DocumentSnapshot>(
                      stream: (searchedPatient == '')
                          ? Clinic.clinic.doc(widget.clinicID).snapshots()
                          : Clinic.clinic
                              .doc(widget.clinicID)
                              .snapshots()
                              .where(
                                (doc2) => doc2.data()!['patients'].forEach(
                                    (snapshot) => snapshot['firstName']
                                            .contains(searchedPatient)
                                        ? true
                                        : false),
                              ),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                              shrinkWrap: true,
                              controller: controller,
                              itemCount:
                                  (snapshot.data!['patients'].length >= 20)
                                      ? 20
                                      : snapshot.data!['patients'].length,
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    PatientCell(
                                        patientData: snapshot.data!['patients']
                                            .elementAt(index)['MRN']),
                                    SizedBox(
                                      width: setWidth(context, 0.05),
                                    ),
                                    PatientCell(
                                        patientData: snapshot.data!['patients']
                                            .elementAt(index)['firstName']),
                                    SizedBox(
                                      width: setWidth(context, 0.05),
                                    ),
                                    PatientCell(
                                        patientData: snapshot.data!['patients']
                                            .elementAt(index)['lastName']),
                                    SizedBox(
                                      width: setWidth(context, 0.05),
                                    ),
                                    CustomIconButton(
                                      path: 'icons/custom_edit_pen.png',
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditPatientScreen(
                                                    snapshot: snapshot
                                                        .data!['patients']
                                                        .elementAt(index),
                                                    clinicID: widget.clinicID!),
                                          ),
                                        );
                                      },
                                      tipText: 'Edit Info',
                                    ),
                                    SizedBox(
                                      height: setHeight(context, 0.06),
                                    ),
                                  ],
                                );
                              });
                        }
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
