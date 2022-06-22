// import '../classes/patient.dart';

//USED FOR TESTING

// class FetchPatientList {
//   //singleton of this class - only one instance can exist
//   static final FetchPatientList patientInstance = FetchPatientList._internal();
//
//   factory FetchPatientList() {
//     return patientInstance;
//   }
//
//   FetchPatientList._internal();
//
// //yyyy-mm-dd
//   List<Patient> patientList = <Patient>[];
//   Patient p1 = Patient('MRN0001', 'Loay', 'Khodor', 'Yacoub', '2001-09-12',
//       '81816583', 'Intern', 'Beirut', 'AB+', 'F', 'W', '18/02/2022', []);
//   Patient p2 = Patient('MRN0001', 'Lou', 'Khodor', 'Yacoub', '2001-09-12',
//       '81816583', 'Intern', 'Beirut', 'AB+', 'F', 'W', '18/02/2022', []);
//   Patient p3 = Patient('MRN0001', 'Ali', 'Khodor', 'Yacoub', '2001-09-12',
//       '81816583', 'Intern', 'Beirut', 'AB+', 'F', 'W', '18/02/2022', []);
//   Patient p4 = Patient('MRN0001', 'Nour', 'Khodor', 'Yacoub', '2001-09-12',
//       '81816583', 'Intern', 'Beirut', 'AB+', 'F', 'W', '18/02/2022', []);
//
//   void fillPatientsList(List<Patient> l, List<Patient> p) {
//     for (int i = 0; i < p.length; i++) {
//       l.add(p.elementAt(i));
//     }
//   }
//
//   List get getPatientList {
//     fillPatientsList(patientList, [p1, p2, p3, p4]);
//     return patientList;
//   }
// }
