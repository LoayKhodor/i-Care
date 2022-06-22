import 'package:capstone_project/classes/vitals.dart';

class MedicalRecord {
  String chiefComplaint;
  String hpi;
  String pmh;
  String labs;
  String imaging;
  Map<String, dynamic> vitals;

  MedicalRecord(
      {required this.chiefComplaint,
      required this.hpi,
      required this.pmh,
      required this.labs,
      required this.imaging,
      required this.vitals});

  bool checkFields() {
    if (chiefComplaint.isEmpty || hpi.isEmpty || pmh.isEmpty) return true;
    return false;
  }

  @override
  String toString() {
    return 'MedicalRecord{chiefComplaint: $chiefComplaint, hpi: $hpi, pmh: $pmh, labs: $labs, imaging: $imaging, vitals: $vitals}';
  }

  MedicalRecord.fromJson(Map<String, dynamic> json)
      : this(
          chiefComplaint: json['chiefComplaint'],
          hpi: json['hpi'],
          pmh: json['pmh'],
          labs: json['labs'],
          imaging: json['imaging'],
          vitals: json['vitals'],
        );

  Map<String, dynamic> toJson() {
    return {
      'chiefComplaint': chiefComplaint,
      'hpi': hpi,
      'pmh': pmh,
      'labs': labs,
      'imaging': imaging,
      'vitals': vitals,
    };
  }

//insert in existing patient (list of MRs) where ID's match

// static CollectionReference<Patient> patientsRef =
// FirebaseFirestore.instance.collection('Patient').withConverter<Patient>(
//   fromFirestore: ((snapshot, options) =>
//       Patient.fromJson(snapshot.data()!)),
//   toFirestore: (patient, options) => patient.toJson(),
// );
}
