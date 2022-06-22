import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone_project/widgets/custom_icon_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class NotificationsDialog extends StatefulWidget {
  const NotificationsDialog({Key? key, this.clinicID}) : super(key: key);
  final String? clinicID;

  @override
  State<NotificationsDialog> createState() => _NotificationsDialogState();
}

class _NotificationsDialogState extends State<NotificationsDialog> {

  ScrollController controller = ScrollController();
  @override
  void initState() {
    print(widget.clinicID);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: setWidth(context, 0.8),
      height: setHeight(context, 0.7),
      child: AlertDialog(
        backgroundColor: kBackgroundColor,
        title: (widget.clinicID == null)
            ? Text(
                "Notifications",
                style: kTextTextStyleRedColor14Bold,
                textAlign: TextAlign.center,
              )
            : StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('clinics')
                    .doc(widget.clinicID)
                    .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        Text(
                          "Notifications",
                          style: kTextTextStyleRedColor14Bold,
                          textAlign: TextAlign.center,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          controller: controller,
                          itemCount: snapshot.data!["requests"].length,
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: setHeight(context, 0.1),
                              width: setWidth(context, 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: setWidth(context, 0.3),
                                    child: AutoSizeText(
                                      snapshot.data!['requests'][index]
                                          ['fromEmail'],
                                      style: kTextTextStyleBlack11Bold,
                                      minFontSize: 7,
                                      maxFontSize: 11,
                                      maxLines: 1,
                                      softWrap: true,
                                    ),
                                  ),
                                  CustomIconButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('clinics')
                                          .doc(widget.clinicID)
                                          .update({
                                        "requests":
                                            FieldValue.arrayRemove([snapshot]),
                                      });
                                    },
                                    tipText: 'reject',
                                    iconData: Icons.close,
                                    size: 0.04,
                                  ),
                                  CustomIconButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('clinics')
                                          .doc(widget.clinicID)
                                          .update({
                                        "userEmails": FieldValue.arrayUnion([
                                          snapshot.data!['requests'][index]
                                              ['fromEmail']
                                        ]),
                                      });
                                      await FirebaseFirestore.instance
                                          .collection('clinics')
                                          .doc(widget.clinicID)
                                          .update({
                                        "requests": FieldValue.arrayRemove([
                                          snapshot.data!['requests'][index]
                                        ]),
                                      });
                                    },
                                    tipText: 'accept',
                                    iconData: Icons.check,
                                    color: Colors.green,
                                    size: 0.04,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                }),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
