import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone_project/constants/constants.dart';
import 'package:capstone_project/dialogs/medical_record_dialog.dart';
import 'package:capstone_project/dialogs/pulse_dialog.dart';
import 'package:capstone_project/widgets/custom_dropdown_search.dart';
import 'package:capstone_project/widgets/custom_icon_button.dart';
import 'package:capstone_project/screens/general_screen2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../classes/clinic.dart';
import '../classes/patient.dart';

class QueueScreen extends StatefulWidget {
  QueueScreen({
    Key? key,
    this.selectedPath,
    this.tipText,
    this.clinicID,
    this.specialty,
    this.MRN,
  }) : super(key: key);
  final String? selectedPath;
  final String? tipText;
  final String? clinicID;
  final String? specialty;
  String? MRN;
  static const id = 'queue_screen';

  @override
  _QueueScreenState createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> {
  //for ListView Scrolling
  ScrollController controller = ScrollController();
  bool isCelsius = false;
  int time = 900;
  int counter = 0;
  bool pressed = false;
  late StreamController<int> events;
  late Timer timer;
  int selectedTime = 0;
  int dbIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    events = StreamController<int>.broadcast();
    fetchPatientsNames();
    events.add(time);
    counter = time;
    super.initState();
  }

  void fetchPatientsNames() {
    kPatients.clear();
    var stream = Clinic.clinic.doc(widget.clinicID).snapshots();
    stream.listen((snapshot) {
      Clinic.kPatientList.clear();
      for (int i = 0; i < snapshot.data()!['patients'].length; i++) {
        Patient p = Patient(
            MRN: snapshot.data()!['patients'][i]['MRN'],
            firstName: snapshot.data()!['patients'][i]['firstName'],
            lastName: snapshot.data()!['patients'][i]['lastName'],
            middleName: snapshot.data()!['patients'][i]['middleName'],
            dob: snapshot.data()!['patients'][i]['dob'],
            phoneNbr: snapshot.data()!['patients'][i]['phoneNbr'],
            occupation: snapshot.data()!['patients'][i]['occupation'],
            address: snapshot.data()!['patients'][i]['address'],
            bloodType: snapshot.data()!['patients'][i]['bloodType'],
            selectedGender: snapshot.data()!['patients'][i]['selectedGender'],
            status: snapshot.data()!['patients'][i]['status'],
            startingDate: snapshot.data()!['patients'][i]['startingDate'],
            medicalRecords: snapshot.data()!['patients'][i]['medicalRecords'],
            nbrOfVisits: snapshot.data()!['patients'][i]['nbrOfVisits']);

        //for reordering

        Clinic.kPatientList.add(p);
        Clinic.kPatientList.toSet(); //remove duplicates in case
        // print(Clinic.kPatientList);

        //used in Queue List
        kPatients.add(snapshot.data()!['patients'][i]['firstName'] +
            ' ' +
            snapshot.data()!['patients'][i]['lastName'] +
            ' - ' +
            snapshot.data()!['patients'][i]['MRN']);
      }
      // print(kPatients);
      kPatients.removeWhere((element) => kQueue.contains(element));
      kPatients = kPatients.toSet().toList();
    });
  }

  void startTimer() async {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (counter == 0) {
        setState(() {
          timer.cancel();
          counter = (selectedTime != 0) ? selectedTime : 900;
          events.add(0);
          pressed = false;
        });
      } else {
        setState(() {
          counter--;
          // print(counter);
          //add to stream then fetch it in Text
          events.add(counter);
        });
      }
    });
  }

  @override
  void dispose() {
    events.close();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fetchPatientsNames();
    return WillPopScope(
      onWillPop: () async => false,
      child: GeneralScreen2(
        screenTitle: 'Queue',
        clinicID: widget.clinicID!,
        width: 1,
        widget: Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: Axis.vertical,
            children: <Widget>[
              StreamBuilder<DocumentSnapshot>(
                  stream: Clinic.clinic.doc(widget.clinicID).snapshots(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      controller: controller,
                      shrinkWrap: true,
                      //in doctor UI fetch from db the queue length edited by the nurse
                      //in the nurse UI change local queue and update db
                      itemCount: (widget.specialty == "doctor")
                          ? (snapshot.hasData)
                              ? snapshot.data!['queue'].length
                              : 0
                          : kQueue.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            (widget.specialty == 'nurse')
                                ? CustomDropdownSearch(
                                    index: index,
                                    clinicID: widget.clinicID,
                                  )
                                : SizedBox(
                                    width: setWidth(context, 0.6),
                                    child: AutoSizeText(
                                      snapshot.data!['queue'].elementAt(index),
                                      maxLines: 1,
                                      style: kTextTextStyleBlack14Bold,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                            (widget.specialty == 'nurse')
                                ? CustomIconButton(
                                    path: 'icons/custom_add.png',
                                    tipText: 'Add to Queue',
                                    onPressed: () {
                                      setState(() {
                                        kQueue.add('');
                                        // print('QUEUE' + kQueue.toString());
                                      });
                                    },
                                  )
                                : SizedBox(),
                            CustomIconButton(
                              tipText: 'Remove from Queue',
                              path: 'icons/custom_remove.png',
                              onPressed: () {
                                setState(() {
                                  List tempQueue = snapshot.data!['queue'];
                                  if (widget.specialty == 'nurse') {
                                    if (kQueue.elementAt(0) == '') {
                                      kPatients.removeAt(0);
                                      kPatients.add(kQueue.removeAt(index));
                                    } else {
                                      kPatients.add(kQueue.removeAt(index));
                                    }
                                  }
                                  //read queue, remove locally, rewrite to db

                                  Clinic.clinic.doc(widget.clinicID).update({
                                    'queue': FieldValue.arrayRemove(tempQueue)
                                  });
                                  //remove the patient at the index then rewrite new queue
                                  if (tempQueue.isNotEmpty) {
                                    tempQueue.removeAt(index);
                                  }
                                  Clinic.clinic.doc(widget.clinicID).update({
                                    'queue': FieldValue.arrayUnion(tempQueue)
                                  });

                                  // print("QUEUE AFTER DELETE" + kQueue.toString());
                                  if (kQueue.isEmpty) {
                                    kQueue.add('');
                                  }
                                });
                              },
                            ),
                            StatefulBuilder(builder: (context, setState) {
                              return (widget.specialty == 'nurse')
                                  ? CustomIconButton(
                                      tipText: 'Timer for Patient',
                                      path: 'icons/custom_timer.png',
                                      onPressed: () => showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: Text(
                                                  'Timer',
                                                  style:
                                                      kTextTextStyleRedColor20,
                                                  textAlign: TextAlign.center,
                                                ),
                                                backgroundColor:
                                                    kBackgroundColor,
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      // setState(() {
                                                      counter = 0;
                                                      pressed = false;
                                                      // });
                                                      //lock the timer - only starts once
                                                    },
                                                    child: const Text('Stop'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      // setState(() {
                                                      if (!pressed)
                                                        startTimer();
                                                      pressed = true;
                                                      // });
                                                      //lock the timer - only starts once
                                                    },
                                                    child: const Text('Start'),
                                                  ),
                                                ],
                                                content: StreamBuilder<int>(
                                                  stream: events.stream
                                                      .asBroadcastStream(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<int>
                                                              snapshot) {
                                                    return GestureDetector(
                                                      onTap: () => showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              true,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              backgroundColor:
                                                                  kBackgroundColor,
                                                              title: SizedBox(
                                                                width: setWidth(
                                                                    context,
                                                                    0.4),
                                                                height:
                                                                    setHeight(
                                                                        context,
                                                                        0.2),
                                                                child:
                                                                    CupertinoTimerPicker(
                                                                  mode:
                                                                      CupertinoTimerPickerMode
                                                                          .ms,
                                                                  onTimerDurationChanged:
                                                                      (value) {
                                                                    // setState(() {
                                                                    selectedTime =
                                                                        value
                                                                            .inSeconds;
                                                                    // counter =
                                                                    //     value.inSeconds;
                                                                    // });
                                                                    // print(value.inSeconds.toString());
                                                                  },
                                                                ),
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      "Cancel"),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    counter =
                                                                        selectedTime;
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      "Set"),
                                                                ),
                                                              ],
                                                            );
                                                          }),
                                                      child: Text(
                                                        (snapshot.hasData &&
                                                                pressed == true)
                                                            ? ((snapshot.data)! /
                                                                        60)
                                                                    .floor()
                                                                    .toString() +
                                                                " : " +
                                                                ((snapshot.data)! %
                                                                        60)
                                                                    .toString()
                                                            : '00:00',
                                                        style:
                                                            kTextTextStyleBlack20,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    );
                                                  },
                                                ));
                                          }),
                                    )
                                  : SizedBox();
                            }),
                            // this widget is specified in navigator screen - one for nurses one for doctors
                            CustomIconButton(
                                tipText: (widget.specialty == 'nurse')
                                    ? 'Enter Vitals'
                                    : 'Create Med Record',
                                path: widget.selectedPath!,
                                onPressed: () {
                                  if (snapshot.data!['queue']
                                      .elementAt(index)
                                      .isNotEmpty) {
                                    widget.MRN = snapshot.data!['queue']
                                        .elementAt(index)
                                        .split('-')[1];

                                    // print(
                                    //   widget.MRN!
                                    //       .substring(4, 8)
                                    //       .replaceAll(RegExp(r'^0+'), ''),
                                    // );
                                  }

                                  (widget.MRN != null)
                                      ? showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            //statefulBuilder to change the state of the alertDialog
                                            //update the date instantly once selected - Differs for nurse or doctor
                                            return (widget.specialty ==
                                                    'doctor')
                                                ? MedicalRecordDialogBuilder(
                                                    clinicID: widget.clinicID!,
                                                    MRN: widget.MRN,
                                                    index: index,
                                                    tempQueue:
                                                        snapshot.data!['queue'],
                                                    snapshot: snapshot
                                                        .data!['patients']
                                                        .elementAt(
                                                      int.parse(
                                                            widget.MRN!
                                                                .substring(4, 8)
                                                                .replaceAll(
                                                                    RegExp(
                                                                        r'^0+'),
                                                                    ''),
                                                          ) -
                                                          1, //subtract 1 since MRN's start with MRN0001
                                                    ),
                                                  )
                                                : PulseDialogBuilder(
                                                    clinicID: widget.clinicID!,
                                                    MRN: widget.MRN,
                                                    snapshot: snapshot
                                                        .data!['patients']
                                                        .elementAt(
                                                      int.parse(
                                                            widget.MRN!
                                                                .substring(4, 8)
                                                                .replaceAll(
                                                                    RegExp(
                                                                        r'^0+'),
                                                                    ''),
                                                          ) -
                                                          1,
                                                    ), //remove leading zeros from MRN[0001] - 0001 - 1 = index in db
                                                  );
                                          },
                                        )
                                      : null;
                                }),
                            SizedBox(
                              height: setHeight(context, 0.1),
                            ),
                          ],
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
