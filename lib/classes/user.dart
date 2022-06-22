import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class AppUser {
  String email;
  String firstName;
  String lastName;
  String? selectedGender;
  String? specialty;

  AppUser(
      {required this.email,
      required this.firstName,
      required this.lastName,
      this.selectedGender,
      this.specialty});

  bool checkFields() {
    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty) return true;
    return false;
  }

  @override
  String toString() {
    return '[' +
        'First Name: ' +
        firstName +
        ', Last Name: ' +
        lastName +
        ', Email: ' +
        email +
        ', Type: ' +
        specialty! +
        ', Gender: ' +
        selectedGender! +
        ']';
  }

  //Firestore references manipulate a Map<String, dynamic> object
  //Create JSON Constructor
  //<Key, Value> email: xxx@gmail.com
  //for insertion
  AppUser.fromJson(Map<String, Object?> json)
      : this(
          email: json['email'] as String,
          firstName: json['firstName'] as String,
          lastName: json['lastName'] as String,
          specialty: json['specialty'] as String,
          selectedGender: json['gender'] as String,
        );

  //return as Json Object
  //for retrieval
  Map<String, Object?> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'specialty': specialty,
      'gender': selectedGender,
    };
  }

  //withConverter will convert add and queries to be type-safe
  //it ensures that the variable's value always matches the variable's static type through a combination of static type checking and runtime checking)
  static CollectionReference<AppUser> usersRef =
      FirebaseFirestore.instance.collection('appUsers').withConverter<AppUser>(
            fromFirestore: ((snapshot, options) =>
                AppUser.fromJson(snapshot.data()!)),
            toFirestore: (appUser, options) => appUser.toJson(),
          );
}
