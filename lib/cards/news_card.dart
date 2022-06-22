import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone_project/error_widgets/network_error_message.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../classes/news.dart';
import '../constants/constants.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({Key? key, this.futureNews, required this.errWidget})
      : super(key: key);
  final Future<MedicalNews>? futureNews;
  final Widget errWidget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MedicalNews>(
      future: futureNews,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: setWidth(context, 0.9),
            height: setHeight(context, 0.1),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: setHeight(context, 0.4),
                    child: Card(
                      elevation: 20,
                      color: kBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              child: Text(
                                '\nOpen Article',
                                style: kTextTextStyleRedColor14Underline,
                              ),
                              onTap: () => launch(snapshot.data!.websiteURL),
                            ),
                            SizedBox(
                              height: setHeight(context, 0.04),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: setWidth(context, 0.3),
                                  child: AutoSizeText(
                                    '\n' + snapshot.data!.title,
                                    style: kTextTextStyleBlack9,
                                    textAlign: TextAlign.center,
                                    maxLines: 7,
                                    minFontSize: 7,
                                    maxFontSize: 9,
                                  ),
                                ),
                                SizedBox(
                                  width: setWidth(context, 0.05),
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: SizedBox(
                                    width: setWidth(context, 0.25),
                                    height: setHeight(context, 0.15),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Image(
                                        fit: BoxFit.fitHeight,
                                        image:
                                            NetworkImage(snapshot.data!.imgURL),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AutoSizeText(
                              '\n' + snapshot.data!.author + '\n\n',
                              style: kTextTextStyleRedColor12,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              minFontSize: 11,
                              maxFontSize: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: setHeight(context, 0.2),
                  //   width: setWidth(context, 0.8),
                  //   child: Image(
                  //     image: AssetImage('images/bg/medical_characters.png'),
                  //   ),
                  // )
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return errWidget;
        }
        // return Text('');
        return SizedBox(
            width: setWidth(context, 0.1),
            height: setHeight(context, 0.1),
            child: const CircularProgressIndicator());
      },
    );
  }
}
