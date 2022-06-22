import 'package:capstone_project/classes/clinic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomDropdownSearch extends StatefulWidget {
  CustomDropdownSearch({Key? key, required this.index, this.clinicID})
      : super(key: key);
  final int index;
  final String? clinicID;

  @override
  State<CustomDropdownSearch> createState() => _CustomDropdownSearchState();
}

class _CustomDropdownSearchState extends State<CustomDropdownSearch> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenuItem(
      child: SizedBox(
        width: setWidth(context, 0.35),
        height: setHeight(context, 0.05),
        child: DropdownSearch<String>(
          popupBackgroundColor: kBackgroundColor,
          showSelectedItems: true,
          dropdownSearchBaseStyle: kTextTextStyleBlack11,
          dropdownSearchTextAlign: TextAlign.center,
          popupSafeArea: PopupSafeAreaProps(minimum: EdgeInsets.all(10)),
          popupElevation: 20,
          mode: Mode.BOTTOM_SHEET,
          showSearchBox: true,
          dropdownSearchDecoration: InputDecoration(
            floatingLabelStyle: kTextTextStyleBlack11,
            labelStyle: kTextTextStyleBlack11,
            labelText: "Select Patient",
            contentPadding: EdgeInsets.fromLTRB(6, 12, 0, 0),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: kRedColor),
            ),
          ),
          // showClearButton: true,
          // popupItemDisabled: (String s) => s.startsWith('I'),
          items: kPatients,
          onChanged: (data) {
            setState(() {

              if(kQueue.isNotEmpty) {
                FirebaseFirestore.instance
                    .collection('clinics')
                    .doc(widget.clinicID)
                    .update({"queue": FieldValue.arrayRemove(kQueue)});
                //remove '' and insert data to queue
                //remove the added data from kPatients so you cannot add it again
                //kPatients is the list of all patients names+MRN
                kQueue.removeAt(widget.index);
                kQueue.insert(widget.index, data!);
                kPatients.removeWhere((element) => element.contains(data));
                FirebaseFirestore.instance
                    .collection('clinics')
                    .doc(widget.clinicID)
                    .update({"queue": FieldValue.arrayUnion(kQueue)});
              }
              if (kPatients.length == 0) {
                kPatients.add('');
              }
            });
            print("kQUEUE:" + kQueue.toString());
          },
          selectedItem: kQueue[widget.index],
          popupTitle: Text(
            'Select Patient',
            style: kTextTextStyleRedColor20,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
