class Patient {
  String firstName;
  String lastName;
  String selectedGender;
  String MRN;
  String middleName;
  String dob;
  String phoneNbr;
  String occupation;
  String address;
  String bloodType;
  String status;
  String startingDate;
  int nbrOfVisits;
  List<dynamic>? medicalRecords;

  Patient({
    required this.MRN,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.dob,
    required this.phoneNbr,
    required this.occupation,
    required this.address,
    required this.bloodType,
    required this.selectedGender,
    required this.status,
    required this.startingDate,
    this.medicalRecords,
    required this.nbrOfVisits,
  });

  @override
  String toString() {
    return 'Patient{firstName: $firstName, lastName: $lastName, selectedGender: $selectedGender, MRN: $MRN, middleName: $middleName, dob: $dob, phoneNbr: $phoneNbr, occupation: $occupation, address: $address, bloodType: $bloodType, status: $status, startingDate: $startingDate, nbrOfVisits: $nbrOfVisits, medicalRecords: $medicalRecords}';
  }

  bool checkFields() {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        middleName.isEmpty ||
        phoneNbr.isEmpty ||
        occupation.isEmpty ||
        address.isEmpty ||
        dob.isEmpty) return true;
    return false;
  }

  Patient.fromJson(Map<String, dynamic> patientJson)
      : this(
          firstName: patientJson['firstName'],
          lastName: patientJson['lastName'],
          middleName: patientJson['middleName'],
          selectedGender: patientJson['selectedGender'],
          dob: patientJson['dob'],
          MRN: patientJson['MRN'],
          phoneNbr: patientJson['phoneNbr'],
          occupation: patientJson['occupation'],
          address: patientJson['address'],
          bloodType: patientJson['bloodType'],
          status: patientJson['status'],
          startingDate: patientJson['startingDate'],
          medicalRecords: patientJson['medicalRecords'],
          nbrOfVisits: patientJson['nbrOfVisits'],
        );

  Map<String, Object?> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'selectedGender': selectedGender,
      'dob': dob,
      'MRN': MRN,
      'phoneNbr': phoneNbr,
      'occupation': occupation,
      'address': address,
      'bloodType': bloodType,
      'status': status,
      'startingDate': startingDate,
      'medicalRecords': medicalRecords,
      'nbrOfVisits': nbrOfVisits,
    };
  }
}
