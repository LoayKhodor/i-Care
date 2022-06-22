import 'dart:math';

import 'package:capstone_project/classes/corona.dart';
import 'package:capstone_project/classes/news.dart';
import 'package:capstone_project/constants/constants.dart';
import 'package:capstone_project/error_widgets/network_error_message.dart';
import 'package:capstone_project/screens/loading_screen.dart';
import 'package:capstone_project/screens/login_screen.dart';
import 'package:capstone_project/cards/news_card.dart';
import 'package:capstone_project/cards/corona_card.dart';
import 'package:capstone_project/screens/general_screen2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen(
      {Key? key,
      this.futureCorona,
      this.futureNews,
      medicalNews,
      this.clinicID})
      : super(key: key);
  static const String id = 'welcome_screen';
  Future<Corona>? futureCorona;
  Future<MedicalNews>? futureNews;
  final String? clinicID;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // var parser = EmojiParser();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScreen2(
      screenTitle: 'Welcome!',
      clinicID: widget.clinicID,
      widthToMenuIcon: 0.2,
      width: 1,
      widget: Column(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: setHeight(context, 0.5),
              enableInfiniteScroll: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 15),
              autoPlayCurve: Curves.easeInToLinear,
              initialPage: 0,
              enlargeCenterPage: true,
            ),
            items: [
              SizedBox(
                  child: CoronaCard(
                futureCorona: widget.futureCorona!,
                errWidget: NetworkErrorMessage(
                  onPressed: () async {
                    setState(() {
                      widget.futureCorona = fetchCoronaData();
                    });
                  },
                ),
              )),
              SizedBox(
                  child: NewsCard(
                futureNews: widget.futureNews!,
                errWidget: NetworkErrorMessage(
                  onPressed: () async {
                    setState(() {
                      int r = Random().nextInt(20);
                      kNewsIndex = (r % 2 == 0) ? r : r * 2;
                      widget.futureNews = fetchNews();
                    });
                  },
                ),
              )),
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return i;
                },
              );
            }).toList(),
          ),
          SizedBox(
            width: setWidth(context, 0.8),
            child: Image(
              image: AssetImage('images/bg/medical_characters.png'),
            ),
          )
        ],
      ),
    );
  }
}
