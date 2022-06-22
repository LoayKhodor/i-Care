import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone_project/screens/general_screen.dart';
import 'package:capstone_project/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../widgets/loading_bar.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  static const String id = 'loading_screen';

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  double val = 0.0;
  late String quote;
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    //random quote from Quotes list in constants.dart
    setState(() {
      int r = Random().nextInt(10);
      kNewsIndex = (r % 2 == 0) ? r : r * 2; //only even indexes are articles
    });
    quote = selectRandomQuote(kQuotes);
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.pushNamed(context, LoginScreen.id);
            }
          });
    controller.animateTo(1);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //used for media queries - images...
    //preload some large images
    // TODO: implement didChangeDependencies
    precacheImage(const AssetImage('images/bg/medical_equipment.png'), context);
    precacheImage(
        const AssetImage('images/bg/medical_characters.png'), context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScreen(
      screenTitle: 'i-Care',
      widget: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: setHeight(context, 0.05)),
            const Image(
              image: AssetImage('images/bg/medical_equipment.png'),
            ),
            AutoSizeText(
              quote,
              style: kTextTextStyleBlack14,
              maxFontSize: 14,
              minFontSize: 12,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: setHeight(context, 0.1),
            ),
            LoadingBar(
              controller: controller,
              BorderWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
