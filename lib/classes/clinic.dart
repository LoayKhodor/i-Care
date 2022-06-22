import 'dart:async';
import 'package:capstone_project/classes/patient.dart';
import 'package:capstone_project/classes/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Clinic {
  String clinicName;
  String specialty;
  String address;
  String workingHours;
  int nbrOfPatients;
  List<Patient> queue;
  List<Request> requests;
  List<String> userEmails;
  List<Patient> patients;

  Clinic(
      {required this.clinicName,
      required this.specialty,
      required this.address,
      required this.workingHours,
      required this.userEmails,
      required this.patients,
      required this.nbrOfPatients,
      required this.queue,
      required this.requests});

  bool checkFields() {
    if (clinicName.isEmpty || specialty.isEmpty || address.isEmpty) return true;
    return false;
  }

  Clinic.fromJson(Map<String, dynamic> clinicJson)
      : this(
          clinicName: clinicJson['clinicName'],
          specialty: clinicJson['specialty'],
          address: clinicJson['address'],
          workingHours: clinicJson['workingHours'],
          userEmails: clinicJson['userEmails'],
          patients: clinicJson['patients'],
          nbrOfPatients: clinicJson['nbrOfPatients'],
          queue: clinicJson['queue'],
          requests: clinicJson['requests'],
        );

  Map<String, Object?> toJson() {
    return {
      'clinicName': clinicName,
      'specialty': specialty,
      'address': address,
      'workingHours': workingHours,
      'userEmails': userEmails,
      'patients': patients,
      'nbrOfPatients': nbrOfPatients,
      'queue': queue,
      'requests': requests,
    };
  }

  //reference to collection
  static CollectionReference<Map<String, dynamic>> clinic =
      FirebaseFirestore.instance.collection('clinics');

  static CollectionReference<Clinic> clinicsRef = clinic.withConverter<Clinic>(
    fromFirestore: ((snapshot, options) => Clinic.fromJson(snapshot.data()!)),
    toFirestore: (clinic, options) => clinic.toJson(),
  );

  //reordering Patient List by MRN Number (Not Functioning)
  static List<Patient> kPatientList = [];

  static Future<List<Patient>> reorderClinicPatients(String clinicID) async {
    kPatientList.sort((a, b) => a.MRN
        .toString()
        .toLowerCase()
        .compareTo(b.MRN.toString().toLowerCase())); //sort by MRN

    //convert List<Patient> to List<Map>
    List<Map> patientsMap = [];
    kPatientList.forEach((Patient patient) {
      Map step = patient.toJson();
      patientsMap.add(step);
    });

    //overwrite the array but sorted now
    FirebaseFirestore.instance
        .collection('clinics')
        .doc(clinicID)
        .set({'patients': patientsMap}, SetOptions(merge: true)).then((value) {
      //Do your stuff.
    });
    // print("SORTED:" + kPatientList.toString());

    return kPatientList;
  }
}
