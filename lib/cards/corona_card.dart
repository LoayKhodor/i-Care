import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone_project/classes/corona.dart';
import 'package:capstone_project/constants/constants.dart';
import 'package:flutter/material.dart';

class CoronaCard extends StatelessWidget {
  CoronaCard({
    Key? key,
    this.futureCorona,
    required this.errWidget,
  }) : super(key: key);

  Future<Corona>? futureCorona;
  final Widget errWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomStatCard(
          futureCorona: futureCorona!,
          errWidget: errWidget,
        ),
      ],
    );
  }
}

class CustomStatCard extends StatelessWidget {
  const CustomStatCard({
    Key? key,
    required this.futureCorona,
    required this.errWidget,
  }) : super(key: key);

  final Future<Corona> futureCorona;
  final Widget errWidget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Corona>(
      future: futureCorona,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: setWidth(context, 0.4),
                height: setHeight(context, 0.1),
                child: Card(
                  elevation: 20,
                  color: kBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('icons/custom_coronavirus.png'),
                            SizedBox(
                              width: setWidth(context, 0.04),
                            ),
                            Image.network(
                              snapshot.data!.flagURL,
                              scale: 10,
                            ),
                            SizedBox(
                              width: setWidth(context, 0.04),
                            ),
                            Image.asset('icons/custom_coronavirus.png'),
                          ],
                        ),
                        SizedBox(
                          height: setHeight(context, 0.01),
                        ),
                        Text(
                          // snapshot.data!.country,
                          'Corona Stats',
                          style: kTextTextStyleBlack11Bold,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CustomRowCoronaStats(
                title1: 'Total Cases',
                datum1: snapshot.data!.cases,
                title2: 'Total Deaths',
                datum2: snapshot.data!.deaths,
              ),
              CustomRowCoronaStats(
                title1: 'Active Cases',
                datum1: snapshot.data!.active,
                title2: 'Recovered',
                datum2: snapshot.data!.recovered,
              ),
              CustomRowCoronaStats(
                title1: 'Cases Today',
                datum1: snapshot.data!.casesToday,
                title2: 'Deaths Today',
                datum2: snapshot.data!.deathsToday,
              ),
              // SizedBox(
              //   height: setHeight(context, 0.2),
              //   width: setWidth(context, 0.8),
              //   child: Image(
              //     image: AssetImage('images/bg/medical_characters.png'),
              //   ),
              // ),
            ],
          );
        } else if (snapshot.hasError) {
          return errWidget;
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

//2 Cards in 1 row - pass their titles and data
class CustomRowCoronaStats extends StatelessWidget {
  const CustomRowCoronaStats({
    Key? key,
    required this.title1,
    required this.datum1,
    required this.title2,
    required this.datum2,
  }) : super(key: key);
  final String title1;
  final int datum1;
  final String title2;
  final int datum2;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CoronaStats(
          title1: title1,
          datum1: datum1,
        ),
        CoronaStats(
          title1: title2,
          datum1: datum2,
        ),
      ],
    );
  }
}

//Card with title and stat in a Column
class CoronaStats extends StatelessWidget {
  const CoronaStats({
    Key? key,
    required this.title1,
    required this.datum1,
  }) : super(key: key);
  final String title1;

  final int datum1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: setWidth(context, 0.4),
      height: setHeight(context, 0.1),
      child: Card(
        elevation: 20,
        color: kBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AutoSizeText(
                title1,
                style: kTextTextStyleBlack11,
                textAlign: TextAlign.center,
                maxLines: 1,
                minFontSize: 9,
                maxFontSize: 14,
              ),
              AutoSizeText(
                datum1.toString(),
                style: kCoronaCardTextStyleBold14,
                textAlign: TextAlign.center,
                maxLines: 1,
                minFontSize: 9,
                maxFontSize: 14,
              )
            ],
          ),
        ),
      ),
    );
  }
}
