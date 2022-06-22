import 'package:capstone_project/classes/medical_record.dart';
import 'package:capstone_project/classes/vitals.dart';
import 'package:capstone_project/widgets/text_fields.dart';
import 'package:capstone_project/widgets/vitals_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/constants.dart';
import '../../widgets/custom_dropdown_list.dart';
import '../classes/clinic.dart';
import '../classes/patient.dart';

class PulseDialogBuilder extends StatefulWidget {
  const PulseDialogBuilder(
      {Key? key, required this.clinicID, this.MRN, required this.snapshot})
      : super(key: key);
  final String clinicID;
  final String? MRN;
  final Map<String, dynamic> snapshot;

  @override
  _PulseDialogBuilderState createState() => _PulseDialogBuilderState();
}

class _PulseDialogBuilderState extends State<PulseDialogBuilder> {
  //vitals to add to MR to add to patient then add to db
  Vitals vitals = Vitals(
      temperature: ['', 'C°'],
      heartRate: ['', 'BPM'],
      respirationRate: ['', 'BPM'],
      bloodPressure: ['', 'mmHg']);

  MedicalRecord mr = MedicalRecord(
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
      vitals.temperature[0] = p.medicalRecords!
              .elementAt(p.nbrOfVisits)['vitals']['temperature'][0] ??
          '';
      vitals.temperature[1] = p.medicalRecords!
              .elementAt(p.nbrOfVisits)['vitals']['temperature'][1] ??
          'C°';
      vitals.heartRate[0] = p.medicalRecords!.elementAt(p.nbrOfVisits)['vitals']
              ['heartRate'][0] ??
          '';
      vitals.respirationRate[0] = p.medicalRecords!
              .elementAt(p.nbrOfVisits)['vitals']['respirationRate'][0] ??
          '';
      vitals.bloodPressure[0] = p.medicalRecords!
              .elementAt(p.nbrOfVisits)['vitals']['bloodPressure'][0] ??
          '';
    }
    print(widget.MRN);
    print(p.toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        scrollable: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter Vital Signs',
              textAlign: TextAlign.center,
              style: kTextTextStyleRedColor20,
            ),
            SizedBox(
              height: setHeight(context, 0.05),
            ),
            VitalsInput(
              widgetList: [
                PatientTextField(
                  hintTxt: '37 C°',
                  labelText: 'Temperature',
                  textToShow: (p.medicalRecords!.length > p.nbrOfVisits)
                      ? p.medicalRecords!.elementAt(p.nbrOfVisits)['vitals']
                          ['temperature'][0]
                      : '',
                  units: 'C°',
                  maxLength: 5,
                  fmt: [
                    FilteringTextInputFormatter.allow(RegExp(r'([0-9.])')),
                  ],
                  width: 0.4,
                  onChanged: (newValue) {
                    vitals.temperature[0] = newValue!;
                  },
                ),
                CustomDropDownItems(
                  title: 'Unit',
                  item: vitals.temperature[1],
                  list: temperatureDegrees,
                  height: 0.12,
                  onChanged: (newValue) {
                    setState(() {
                      vitals.temperature[1] = newValue!;
                    });
                  },
                )
              ],
            ),
            VitalsInput(
              widgetList: [
                PatientTextField(
                  hintTxt: '160 BPM',
                  labelText: 'Heart Rate',
                  maxLength: 3,
                  textToShow: (p.medicalRecords!.length > p.nbrOfVisits)
                      ? p.medicalRecords!.elementAt(p.nbrOfVisits)['vitals']
                          ['heartRate'][0]
                      : '',
                  fmt: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                  width: 0.4,
                  onChanged: (newValue) {
                    vitals.heartRate[0] = newValue!;
                  },
                ),
                SizedBox(
                  width: setWidth(context, 0.05),
                ),
                CustomDropDownItems(
                    title: 'Unit',
                    item: 'BPM',
                    list: kPulseUnit,
                    height: 0.12,
                    onChanged: (newValue) {
                      vitals.heartRate[1] = newValue!;
                    }),
              ],
            ),
            VitalsInput(
              widgetList: [
                PatientTextField(
                  hintTxt: '15 BPM',
                  labelText: 'Respiration Rate',
                  maxLength: 3,
                  textToShow: (p.medicalRecords!.length > p.nbrOfVisits)
                      ? p.medicalRecords!.elementAt(p.nbrOfVisits)['vitals']
                          ['respirationRate'][0]
                      : '',
                  fmt: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                  width: 0.4,
                  onChanged: (newValue) {
                    vitals.respirationRate[0] = newValue!;
                  },
                ),
                SizedBox(
                  width: setWidth(context, 0.05),
                ),
                CustomDropDownItems(
                    title: 'Unit',
                    item: 'BPM',
                    list: kRespirationUnit,
                    height: 0.12,
                    onChanged: (newValue) {
                      vitals.respirationRate[1] = newValue!;
                    }),
              ],
            ),
            VitalsInput(
              widgetList: [
                PatientTextField(
                  hintTxt: '120/80 mmHg',
                  labelText: 'Blood Pressure',
                  maxLength: 7,
                  textToShow: (p.medicalRecords!.length > p.nbrOfVisits)
                      ? p.medicalRecords!.elementAt(p.nbrOfVisits)['vitals']
                          ['bloodPressure'][0]
                      : '',
                  fmt: [FilteringTextInputFormatter.allow(RegExp(r'[0-9\/]'))],
                  width: 0.4,
                  onChanged: (newValue) {
                    vitals.bloodPressure[0] = newValue!;
                  },
                ),
                SizedBox(
                  width: setWidth(context, 0.05),
                ),
                CustomDropDownItems(
                    title: 'Unit',
                    item: 'mmHg',
                    list: kBloodPressureUnit,
                    height: 0.12,
                    onChanged: (newValue) {
                      vitals.bloodPressure[1] = newValue!;
                    }),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              print(mr.vitals.toString());

              Clinic.clinic.doc(widget.clinicID).update({
                'patients': FieldValue.arrayRemove([widget.snapshot])
              });
              //overwrite this patient with a medical record having vitals only now
              //the doctor will also overwrite it adding the CC HPI PMH...
              //if the nurse made a mistake and wants to renter vitals replace MR
              if (p.medicalRecords!.length > p.nbrOfVisits) {
                p.medicalRecords!.removeAt(p.nbrOfVisits);
              }
              mr.vitals = vitals.toJson();
              print(mr.toJson());
              p.medicalRecords!.add(mr.toJson());
              // print(p.toString());

              Clinic.clinic.doc(widget.clinicID).update({
                'patients': FieldValue.arrayUnion([p.toJson()])
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      );
    });
  }
}
