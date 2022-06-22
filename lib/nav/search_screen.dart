import 'package:capstone_project/classes/request.dart';
import 'package:capstone_project/constants/constants.dart';
import 'package:capstone_project/screens/general_screen.dart';
import 'package:capstone_project/widgets/custom_icon_button.dart';
import 'package:capstone_project/widgets/text_fields.dart';
import 'package:capstone_project/widgets/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screens/general_screen2.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key, required this.email}) : super(key: key);
  static const String id = 'search_screen';
  final String email;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ScrollController controller = ScrollController();
  String searchedEmail = '';
  String clinicID = ' ';
  String clinicName = '-';
  Request request = Request(toEmail: '', fromEmail: '', status: '');

  @override
  void initState() {
    request.fromEmail = widget.email;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScreen2(
        screenTitle: 'Clinic',
        width: 1,
        //Positioned.fill to overlay --> StackFit.expand to expand Stack width
        widget: Expanded(
          child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.topCenter,
              children: <Widget>[
                Positioned(
                  width: setWidth(context, 0.5),
                  height: setHeight(context, 0.5),
                  top: setHeight(context, 0.15),
                  child: DecoratedBox(
                    position: DecorationPosition.background,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        opacity: 0.3,
                        alignment: Alignment.topCenter,
                        fit: BoxFit.contain,
                        // alignment: Alignment.center,
                        image: AssetImage(
                          'images/bg/hospital.png',
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: setHeight(context, 0.02),
                  height: setHeight(context, 0.07),
                  width: setWidth(context, 0.6),
                  child: CustomSearchField(
                    hintTxt: 'e.g. john@gmail.com',
                    width: 0.6,
                    onChanged: (newValue) {
                      searchedEmail = newValue!;
                    },
                    onEditingComplete: () async => {
                      await FirebaseFirestore.instance
                          .collection('clinics')
                          .where('userEmails', arrayContains: searchedEmail)
                          .get()
                          .then((snapshot) async => {
                                if (snapshot.docs.isNotEmpty)
                                  {
                                    request.toEmail = searchedEmail,
                                    request.status = Status.pending.name,
                                    //pending
                                    clinicID = snapshot.docs[0].id.toString(),
                                    await FirebaseFirestore.instance
                                        .collection('clinics')
                                        .doc(clinicID)
                                        .get()
                                        .then((snapshot) => {
                                              setState(() {
                                                clinicName = snapshot
                                                    .data()!['clinicName'];
                                              }),
                                              print(clinicName),
                                            }),
                                  }
                                else
                                  {
                                    FToast().init(context),
                                    showCustomToast(
                                        'Email Not Found', Icons.warning),
                                    setState(() {
                                      clinicName = '-';
                                    }),
                                  }
                              })
                          .onError((error, stackTrace) => {}),
                      FocusScope.of(context).unfocus(),
                    },
                    labelTxt: 'Send Request',
                  ),
                ),
                Positioned(
                  top: setHeight(context, 0.15),
                  width: setWidth(context, 0.8),
                  height: setHeight(context, 0.8),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      // ListView.builder(itemBuilder: itemBuilder),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(8),
                          border: Border(
                            bottom: BorderSide(color: kRedColor, width: 2.0),
                          ),
                        ),
                        child: ListTile(
                          leading:
                              Text(clinicName, style: kTextTextStyleRedColor14),
                          trailing: CustomIconButton(
                            tipText: 'Send Request',
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('clinics')
                                  .doc(clinicID)
                                  .update({
                                "requests":
                                    FieldValue.arrayUnion([request.toJson()])
                              });
                              FToast().init(context);
                              showCustomToast(
                                'Request Sent Successfully',
                                Icons.send_to_mobile,
                              );
                            },
                            iconData: Icons.add_alert_rounded,
                            size: 0.05,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ));
  }
}
