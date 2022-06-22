// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../constants/constants.dart';
//
// class TimerDialog extends StatefulWidget {
//   TimerDialog(
//       {Key? key,
//       required this.time,
//       required this.counter,
//       required this.pressed, required this.events})
//       : super(key: key);
//
//   // final StreamController<int> events;
//   int time;
//   int counter;
//   bool pressed;
//   StreamController<int> events;
//   @override
//   _TimerDialogState createState() => _TimerDialogState();
// }
//
// class _TimerDialogState extends State<TimerDialog> {
//   //Once Timer Icon is Pressed you can start a 15 minute Timer
//   late Timer timer;
//   @override
//   void initState() {
//     // TODO: implement initState
//     setState(() {
//       widget.events.add(widget.time);
//       widget.counter = widget.time;
//     });
//     super.initState();
//   }
//
//   void startTimer() async {
//     const oneSec = const Duration(seconds: 1);
//     timer = Timer.periodic(oneSec, (Timer timer) {
//       if (widget.counter == 0) {
//         setState(() {
//           timer.cancel();
//           widget.counter = 180;
//           widget.pressed = false;
//         });
//       } else {
//         setState(() {
//           widget.counter--;
//           print(widget.counter);
//           //add to stream then fetch it in Text
//           widget.events.add(widget.counter);
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//         title: Text(
//           'Timer',
//           style: kTextTextStyleRedColor20,
//           textAlign: TextAlign.center,
//         ),
//         backgroundColor: kBackgroundColor,
//         actions: <Widget>[
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               widget.counter = 0;
//               widget.pressed = false; //lock the timer - only starts once
//             },
//             child: const Text('Stop'),
//           ),
//           TextButton(
//             onPressed: () {
//               if (!widget.pressed) startTimer();
//               widget.pressed = true; //lock the timer - only starts once
//             },
//             child: const Text('Start'),
//           ),
//         ],
//         content: StreamBuilder<int>(
//           stream: widget.events.stream.asBroadcastStream(),
//           builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//             return GestureDetector(
//               onTap: () => showDialog(
//                   context: context,
//                   barrierDismissible: true,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       backgroundColor: kBackgroundColor,
//                       title: SizedBox(
//                         width: setWidth(context, 0.4),
//                         height: setHeight(context, 0.2),
//                         child: CupertinoTimerPicker(
//                           mode: CupertinoTimerPickerMode.ms,
//                           onTimerDurationChanged: (value) {
//                             setState(() {
//                               widget.counter = value.inSeconds;
//                             });
//                             // print(value.inSeconds.toString());
//                           },
//                         ),
//                       ),
//                     );
//                   }),
//               child: Text(
//                 snapshot.hasData
//                     ? ((snapshot.data)! / 60).floor().toString() +
//                         " : " +
//                         ((snapshot.data)! % 60).toString()
//                     : '00:00',
//                 style: kTextTextStyleBlack20,
//                 textAlign: TextAlign.center,
//               ),
//             );
//           },
//         ));
//   }
// }
