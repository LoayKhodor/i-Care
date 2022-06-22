import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone_project/dialogs/logout_dialog.dart';
import 'package:capstone_project/dialogs/notifications_dialog.dart';
import 'package:capstone_project/widgets/custom_settings_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';

class GeneralScreen2 extends StatefulWidget {
  const GeneralScreen2({
    Key? key,
    required this.widget,
    required this.screenTitle,
    this.width,
    this.widthToMenuIcon,
    this.clinicID,
  }) : super(key: key);
  final String screenTitle;
  final Widget widget;
  final double? width;
  final double? widthToMenuIcon;
  final String? clinicID;

  @override
  State<GeneralScreen2> createState() => _GeneralScreen2State();
}

class _GeneralScreen2State extends State<GeneralScreen2> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //remove any overlays when clicking anywhere on the screen
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: kBackgroundColor,
        key: scaffoldKey,
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: (widget.width != null)
                  ? setWidth(context, widget.width!)
                  : setWidth(context, 0.9),
              height: double.infinity,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      // Positioned(
                      //   top: setHeight(context, 0.1),
                      //   child: SizedBox(
                      //     width: setWidth(context, 1),
                      //     child: Center(
                      //       child: Text(
                      //         'Miracle',
                      //         style: kTextTextStyleBlack14,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Positioned(
                        left: 0,
                        top: 8,
                        child: IconButton(
                          onPressed: () =>
                              scaffoldKey.currentState!.openDrawer(),
                          icon: Icon(
                            Icons.menu,
                            size: setWidth(context, 0.07),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: setWidth(context, 1),
                        child: Center(
                          child: AutoSizeText(
                            widget.screenTitle,
                            style: kTitleTextStyle,
                            maxFontSize: 45,
                            maxLines: 1,
                            minFontSize: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: setHeight(context, 0.06),
                  ),
                  Divider(),
                  widget.widget,
                ],
              ),
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: kBackgroundColor,
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: kBackgroundColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'i-Care',
                      style: kTitleTextStyle,
                    ),
                    Center(
                      child: SizedBox(
                        width: setWidth(context, 0.6),
                        height: setHeight(context, 0.08),
                        child: Image.asset('images/bg/medical_characters.png'),
                      ),
                    ),
                  ],
                ),
              ),
              CustomSettingsListTile(
                iconData: Icons.settings_rounded,
                txt: 'Settings',
                onPressed: () {},
              ),
              CustomSettingsListTile(
                iconData: Icons.language_rounded,
                txt: 'Language',
                onPressed: () {},
              ),
              CustomSettingsListTile(
                iconData: Icons.analytics_outlined,
                txt: 'Analytics',
                onPressed: () {},
              ),
              CustomSettingsListTile(
                iconData: Icons.color_lens_outlined,
                txt: 'Theme',
                onPressed: () {},
              ),
              CustomSettingsListTile(
                iconData: Icons.notifications_active_outlined,
                txt: 'Notifications',
                onPressed: () => showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return NotificationsDialog(clinicID: widget.clinicID);
                  },
                ),
              ),
              CustomSettingsListTile(
                iconData: Icons.logout_rounded,
                txt: 'Logout',
                onPressed: () => showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return LogoutDialog();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
