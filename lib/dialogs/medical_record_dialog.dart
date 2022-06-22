import 'package:capstone_project/classes/clinic.dart';
import 'package:capstone_project/classes/medical_record.dart';
import 'package:capstone_project/constants/constants.dart';
import 'package:capstone_project/widgets/custom_icon_button.dart';
import 'package:capstone_project/widgets/text_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../classes/patient.dart';
import '../widgets/toast_error.dart';

class MedicalRecordDialogBuilder extends StatefulWidget {
  const MedicalRecordDialogBuilder(
      {Key? key,
      required this.clinicID,
      this.MRN,
      required this.snapshot,
      required this.tempQueue,
      required this.index})
      : super(key: key);
  final String clinicID;
  final String? MRN;
  final Map<String, dynamic> snapshot;
  final List tempQueue;
  final int index;

  @override
  _MedicalRecordDialogBuilderState createState() =>
      _MedicalRecordDialogBuilderState();
}

class _MedicalRecordDialogBuilderState
    extends State<MedicalRecordDialogBuilder> {
  //MR to add to Patient p then add to db
  MedicalRecord medicalRecord = MedicalRecord(
    chiefComplaint: '',
    hpi: '',
    pmh: '',
    labs: '',
    imaging: '',
    vitals: {},
  );
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

    if (p.medicalRecords!.length > p.nbrOfVisits) {
      medicalRecord.vitals =
          p.medicalRecords!.elementAt(p.nbrOfVisits)['vitals'];
    }
    print(medicalRecord);
    // print(widget.MRN);
    // print(p.toString());

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return GestureDetector(
        onTap: () {
          //remove any overlays when clicking anywhere on the screen
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: AlertDialog(
          scrollable: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Medical Record',
                style: kTextTextStyleRedColor20,
              ),
              SizedBox(
                height: setHeight(context, 0.05),
              ),
              PatientTextField(
                hintTxt: 'Enter your text here',
                labelText: 'Chief Complaint*',
                width: 1,
                fmt: kTxtFmt,
                textToShow: '',
                onChanged: (newValue) {
                  medicalRecord.chiefComplaint = newValue!;
                },
              ),
              SizedBox(
                height: setHeight(context, 0.04),
              ),
              PatientTextField(
                hintTxt: 'Enter your text here',
                labelText: 'History of Present Illness (HPI)*',
                width: 1,
                maxLines: 6,
                fmt: kTxtFmt,
                textToShow: '',
                onChanged: (newValue) {
                  medicalRecord.hpi = newValue!;
                },
              ),
              SizedBox(
                height: setHeight(context, 0.04),
              ),
              PatientTextField(
                hintTxt: 'Enter your text here',
                labelText: 'Past Medical History*',
                width: 1,
                maxLines: 6,
                fmt: kTxtFmt,
                textToShow: '',
                onChanged: (newValue) {
                  medicalRecord.pmh = newValue!;
                },
              ),
              SizedBox(
                height: setHeight(context, 0.04),
              ),
              PatientTextField(
                hintTxt: 'Enter your text here',
                labelText: 'Labs',
                width: 1,
                maxLines: 6,
                fmt: kTxtFmt,
                textToShow: '',
                onChanged: (newValue) {
                  medicalRecord.labs = newValue!;
                },
              ),
              SizedBox(
                height: setHeight(context, 0.04),
              ),
              PatientTextField(
                hintTxt: 'Enter your text here',
                labelText: 'Imaging',
                width: 1,
                fmt: kTxtFmt,
                textToShow: '',
                onChanged: (newValue) {
                  medicalRecord.imaging = newValue!;
                },
                onPressed: () {},
              ),
              SizedBox(
                height: setHeight(context, 0.01),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomIconButton(
                    iconData: Icons.camera_alt_outlined,
                    onPressed: () {},
                    tipText: 'Scan',
                    size: 0.04,
                  ),
                  CustomIconButton(
                    iconData: Icons.upload_rounded,
                    onPressed: () {},
                    tipText: 'Upload',
                    size: 0.04,
                  ),
                ],
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (medicalRecord.checkFields()) {
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
                  //remove old patient
                  Clinic.clinic.doc(widget.clinicID).update({
                    'patients': FieldValue.arrayRemove([widget.snapshot])
                  });
                  //overwrite this patient with a medical record now - this condition is true if nurse added vitals
                  if (p.medicalRecords!.length > p.nbrOfVisits) {
                    //if nurse added Vitals then MR length increments - so overwrite this MR (remove and insert)
                    p.medicalRecords!.removeAt(p.nbrOfVisits);
                  }

                  p.nbrOfVisits++;
                  p.medicalRecords!.add(medicalRecord.toJson());

                  // print(p.toString());

                  await Clinic.clinic.doc(widget.clinicID).update({
                    'patients': FieldValue.arrayUnion([p.toJson()])
                  });
                  await Clinic.clinic.doc(widget.clinicID).update(
                      {'queue': FieldValue.arrayRemove(widget.tempQueue)});
                  //remove the patient at the index then rewrite new queue
                  if (widget.tempQueue.isNotEmpty) {
                    widget.tempQueue.removeAt(widget.index);
                  }
                  await Clinic.clinic.doc(widget.clinicID).update(
                      {'queue': FieldValue.arrayUnion(widget.tempQueue)});
                  await Clinic.reorderClinicPatients(widget.clinicID);
                  FToast().init(context);
                  showCustomToast('Added Successfully', Icons.check);
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      );
    });
  }
}
