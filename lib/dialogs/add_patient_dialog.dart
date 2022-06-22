import 'package:capstone_project/themes/date_theme.dart';
import 'package:capstone_project/widgets/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../classes/clinic.dart';
import '../classes/patient.dart';
import '../constants/constants.dart';
import '../widgets/custom_dropdown_list.dart';
import '../widgets/text_fields.dart';

class AddPatientDialog extends StatefulWidget {
  AddPatientDialog({Key? key, required this.clinicID}) : super(key: key);

  final String clinicID;

  @override
  State<AddPatientDialog> createState() => _AddPatientDialogState();
}

class _AddPatientDialogState extends State<AddPatientDialog> {
  //patient to add
  Patient patient = Patient(
      MRN: '',
      firstName: '',
      lastName: '',
      middleName: '',
      dob: '',
      phoneNbr: '',
      occupation: '',
      address: '',
      bloodType: 'A+',
      medicalRecords: [],
      selectedGender: 'M',
      status: 'M',
      startingDate: '',
      nbrOfVisits: 0);

  List<String> dropdownItems = ['A+', 'M', 'M'];
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    bool isChanged = false;
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        scrollable: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add Patient',
              textAlign: TextAlign.center,
              style: kTextTextStyleRedColor20,
            ),
            SizedBox(
              height: setHeight(context, 0.08),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PatientTextField(
                  hintTxt: 'e.g. John',
                  width: 0.3,
                  labelText: 'First Name',
                  maxLength: 20,
                  fmt: kNamesFmt,
                  textToShow: '',
                  onChanged: (newValue) {
                    patient.firstName = newValue!;
                  },
                ),
                PatientTextField(
                  hintTxt: 'e.g. Doe',
                  labelText: 'Last Name',
                  maxLength: 20,
                  fmt: kNamesFmt,
                  width: 0.3,
                  textToShow: '',
                  onChanged: (newValue) {
                    patient.lastName = newValue!;
                  },
                ),
              ],
            ),
            SizedBox(
              height: setHeight(context, 0.03),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PatientTextField(
                  hintTxt: 'e.g. Joe',
                  width: 0.3,
                  labelText: 'Middle Name',
                  maxLength: 20,
                  fmt: kNamesFmt,
                  textToShow: '',
                  onChanged: (newValue) {
                    patient.middleName = newValue!;
                  },
                ),
                PatientTextField(
                  hintTxt: 'e.g. 81816583',
                  width: 0.3,
                  labelText: 'Phone No.',
                  maxLength: 16,
                  fmt: kDigitsFmt,
                  textToShow: '',
                  onChanged: (newValue) {
                    patient.phoneNbr = newValue!;
                  },
                ),
                // StatefulBuilder(builder: (context, setState) {
              ],
            ),
            SizedBox(
              height: setHeight(context, 0.03),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    // setState(() {
                    isChanged = true;
                    selectedDate = pickedDate!;
                    patient.dob = selectedDate.toString().substring(0, 10);
                    // });
                  }),
                  child: Column(
                    children: [
                      Container(
                        width: setWidth(context, 0.3),
                        height: setHeight(context, 0.06),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: kRedColor, width: 2.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 0.0, left: 10.0),
                          child: Text(
                            (isChanged == true)
                                ? selectedDate.toString().substring(0, 10)
                                : 'Date of Birth',
                            style: kTextTextStyleBlack9,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: setHeight(context, 0.03),
                      ),
                    ],
                  ),
                ),
                PatientTextField(
                  hintTxt: 'e.g. Engineer',
                  width: 0.3,
                  labelText: 'Occupation',
                  maxLength: 30,
                  fmt: kTxtFmt,
                  textToShow: '',
                  onChanged: (newValue) {
                    patient.occupation = newValue!;
                  },
                ),
              ],
            ),
            SizedBox(
              height: setHeight(context, 0.03),
            ),
            PatientTextField(
              hintTxt: 'e.g. Beirut, Lebanon',
              width: 0.65,
              labelText: 'Address',
              maxLength: 50,
              fmt: kTxtFmt,
              textToShow: '',
              onChanged: (newValue) {
                patient.address = newValue!;
              },
            ),
            // SizedBox(
            //   height: setHeight(context, 0.05),
            // ),
            SizedBox(
              height: setHeight(context, 0.02),
            ),
            SizedBox(
              width: setWidth(context, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomDropDownItems(
                    title: 'Blood\nType',
                    item: dropdownItems[0],
                    list: kBloodTypes,
                    height: 0.2,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownItems[0] = newValue!;
                        patient.bloodType = newValue;
                      });
                    },
                  ),
                  CustomDropDownItems(
                    title: 'Gender\nType',
                    item: dropdownItems[1],
                    list: kGenderTypes,
                    height: 0.2,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownItems[1] = newValue!;
                        patient.selectedGender = newValue;
                      });
                    },
                  ),
                  CustomDropDownItems(
                    title: 'Marital\nStatus',
                    item: dropdownItems[2],
                    list: kMaritalStatus,
                    height: 0.2,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownItems[2] = newValue!;
                        patient.status = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              //check if any field is empty then show error toast
              if (patient.checkFields()) {
                //dismiss keyboard
                // Next, we need to check to see if the current FocusNode has the “primary focus.”
                // If it doesn’t, we call unfocus() on the current node
                // to remove focus and trigger the keyboard to dismiss
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                FToast().init(context);
                showCustomToast('Please fill all fields', Icons.warning);
              } else {
                patient.startingDate =
                    DateTime.now().toString().substring(0, 10);
                print(patient.toString());
                FocusScope.of(context);
                await Clinic.clinic
                    .doc(widget.clinicID)
                    .update({"nbrOfPatients": FieldValue.increment(1)});
                Navigator.pop(context);
                //starts with MRN0001

                await Clinic.clinic.doc(widget.clinicID).get().then(
                    (snapshot) => patient.MRN = 'MRN' +
                        (kMRNFormatter
                            .format(snapshot.get('nbrOfPatients'))
                            .toString()));
                await Clinic.clinic.doc(widget.clinicID).update({
                  "patients": FieldValue.arrayUnion([patient.toJson()])
                });
              }
            },
            child: const Text('Add'),
          ),
        ],
      );
    });
  }
}
