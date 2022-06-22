import 'package:capstone_project/classes/patient.dart';
import 'package:capstone_project/constants/constants.dart';
import 'package:capstone_project/screens/general_screen2.dart';
import 'package:capstone_project/themes/date_theme.dart';
import 'package:capstone_project/widgets/buttons.dart';
import 'package:capstone_project/widgets/custom_dropdown_list.dart';
import 'package:capstone_project/widgets/text_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../classes/clinic.dart';
import '../widgets/pdfViewer.dart';

class EditPatientScreen extends StatefulWidget {
  const EditPatientScreen({Key? key, required this.snapshot, this.clinicID})
      : super(key: key);
  static String id = 'edit_patient';
  final Map<String, dynamic> snapshot;
  final String? clinicID;

  @override
  _EditPatientScreenState createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  DateTime selectedDate = DateTime.now();
  bool isChanged = false;
  late Patient p;

  @override
  void initState() {
    p = Patient(
        MRN: widget.snapshot['MRN'],
        firstName: widget.snapshot['firstName'],
        lastName: widget.snapshot['lastName'],
        middleName: widget.snapshot['middleName'],
        dob: widget.snapshot['dob'],
        phoneNbr: widget.snapshot['phoneNbr'],
        occupation: widget.snapshot['occupation'],
        address: widget.snapshot['address'],
        bloodType: widget.snapshot['bloodType'],
        selectedGender: widget.snapshot['selectedGender'],
        status: widget.snapshot['status'],
        startingDate: widget.snapshot['startingDate'],
        medicalRecords: widget.snapshot['medicalRecords'],
        nbrOfVisits: widget.snapshot['nbrOfVisits']);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScreen2(
      screenTitle: 'Edit Info',
      width: 1,
      widget: Expanded(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          scrollDirection: Axis.vertical,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: setHeight(context, 0.02),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PatientTextField(
                        hintTxt: 'e.g. John',
                        labelText: 'First Name',
                        width: 0.4,
                        maxLength: 20,
                        textToShow: widget.snapshot['firstName'],
                        fmt: kNamesFmt,
                        onChanged: (newValue) {
                          p.firstName = newValue!;
                        }),
                    PatientTextField(
                        hintTxt: 'e.g. Doe',
                        labelText: 'Last Name',
                        width: 0.4,
                        maxLength: 20,
                        textToShow: widget.snapshot['lastName'],
                        fmt: kNamesFmt,
                        onChanged: (newValue) {
                          p.lastName = newValue!;
                        }),
                  ],
                ),
                SizedBox(
                  height: setHeight(context, 0.02),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PatientTextField(
                        hintTxt: 'e.g. Joe',
                        labelText: 'Middle Name',
                        width: 0.4,
                        maxLength: 20,
                        textToShow: widget.snapshot['middleName'],
                        fmt: kNamesFmt,
                        onChanged: (newValue) {
                          p.middleName = newValue!;
                        }),
                    PatientTextField(
                        hintTxt: 'e.g. 81816583',
                        labelText: 'Phone No.',
                        width: 0.4,
                        maxLength: 16,
                        textToShow: widget.snapshot['phoneNbr'],
                        fmt: kDigitsFmt,
                        onChanged: (newValue) {
                          p.phoneNbr = newValue!;
                        }),
                  ],
                ),
                SizedBox(
                  height: setHeight(context, 0.02),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => showDatePicker(
                        initialEntryMode: DatePickerEntryMode.inputOnly,
                        helpText: "Select Birth Date",
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.utc(1917),
                        lastDate: DateTime.utc(DateTime.now().year + 1),
                        builder: (BuildContext context, Widget? child) {
                          return DateTheme(child: child!);
                        },
                      ).then((pickedDate) {
                        setState(() {
                          selectedDate = pickedDate!;
                          isChanged = true;
                        });
                      }),
                      child: Column(
                        children: [
                          Container(
                            width: setWidth(context, 0.4),
                            height: setHeight(context, 0.06),
                            margin: EdgeInsets.only(bottom: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: kRedColor, width: 2.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 6.0, bottom: 6.0, left: 10.0),
                              child: Text(
                                (isChanged == true)
                                    ? selectedDate.toString().substring(0, 10)
                                    : widget.snapshot['dob'],
                                style: kTextTextStyleBlack11,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: setHeight(context, 0.02),
                          ),
                        ],
                      ),
                    ),
                    PatientTextField(
                        hintTxt: 'e.g. Engineer',
                        labelText: 'Occupation',
                        width: 0.4,
                        maxLength: 30,
                        textToShow: widget.snapshot['occupation'],
                        fmt: kTxtFmt,
                        onChanged: (newValue) {
                          p.occupation = newValue!;
                        }),
                  ],
                ),
                SizedBox(
                  height: setHeight(context, 0.02),
                ),
                PatientTextField(
                    hintTxt: 'e.g. Lebanon, Beirut',
                    labelText: 'Address',
                    width: 0.87,
                    maxLength: 50,
                    textToShow: widget.snapshot['address'],
                    fmt: kTxtFmt,
                    onChanged: (newValue) {
                      p.address = newValue!;
                    }),
                SizedBox(
                  height: setHeight(context, 0.02),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomDropDownItems(
                        title: 'Blood Type',
                        item: widget.snapshot['bloodType'],
                        list: kBloodTypes,
                        height: 0.14,
                        onChanged: (newValue) {
                          p.bloodType = newValue!;
                        }),
                    CustomDropDownItems(
                        title: 'Gender Type',
                        item: widget.snapshot['selectedGender'],
                        list: kGenderTypes,
                        height: 0.14,
                        onChanged: (newValue) {
                          p.selectedGender = newValue!;
                        }),
                    CustomDropDownItems(
                        title: 'Marital Status',
                        item: widget.snapshot['status'],
                        list: kMaritalStatus,
                        height: 0.14,
                        onChanged: (newValue) {
                          p.status = newValue!;
                        }),
                  ],
                ),
                SizedBox(
                  height: setHeight(context, 0.02),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      txt: 'Go Back',
                      widthPercent: 0.3,
                      heightPercent: 0.1,
                      buttonType: 'back',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: setWidth(context, 0.05),
                    ),
                    CustomButton(
                      txt: 'Update',
                      widthPercent: 0.3,
                      heightPercent: 0.1,
                      buttonType: 'regular',
                      onPressed: () async {
                        // await clinic.doc(widget.clinicID).set(p.toJson());
                        await Clinic.clinic.doc(widget.clinicID).update({
                          "patients": FieldValue.arrayRemove([widget.snapshot]),
                        }); //remove old patient info from db
                        await Clinic.clinic.doc(widget.clinicID).update({
                          "patients": FieldValue.arrayUnion([p.toJson()]),
                        }); //add new patient info
                        await Clinic.reorderClinicPatients(widget.clinicID!);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: setHeight(context, 0.02),
                ),
                GestureDetector(
                    child: Text(
                      'View PDF',
                      style: kTextTextStyleRedColor12Underline,
                    ),
                    onTap: () async {
                      final output = await getTemporaryDirectory();
                      await generatePDF(p, output);
                      //view pdf
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => pdfView(
                            output: output,
                          ),
                        ),
                      );
                    }
                    // Navigator.pushNamed(context, RegistrationScreen.id),
                    ),
                SizedBox(
                  height: setHeight(context, 0.05),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
