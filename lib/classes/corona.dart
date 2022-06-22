import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

//Constructor for Specific Country API
class Corona {
  String country;
  int cases;
  int casesToday;
  int recovered;
  int active;
  int deaths;
  int deathsToday;
  String flagURL;

  Corona(this.flagURL, this.country, this.cases, this.casesToday,
      this.recovered, this.active, this.deaths, this.deathsToday);

  //constructor from JSON
  factory Corona.fromJson(Map<String, dynamic> json) {
    return Corona(
        json['countryInfo']['flag'],
        json['country'],
        json['cases'],
        json['todayCases'],
        json['recovered'],
        json['active'],
        json['deaths'],
        json['todayDeaths']);
  }
}

//NovelCOVID API
Future<Corona> fetchCoronaData() async {
  //Uri is a superset of Url
  final response = await http.get(Uri.parse(
      'https://corona.lmao.ninja/v2/countries/Lebanon?yesterday&strict&query%20'));

  if (response.statusCode == 200) {
    // print(response.body);
    return Corona.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

//
// Future<Corona2> fetchCoronaData2() async {
//   final response =
//       await http.get(Uri.parse('https://corona.lmao.ninja/v2/all?yesterday'));
//
//   if (response.statusCode == 200) {
//     print(response.body);
//     return Corona2.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load data');
//   }
// }
//
//
// //Constructor for Total Corona Data
// class Corona2 {
//   int cases;
//   int casesToday;
//   int recovered;
//   int active;
//   int deaths;
//   int deathsToday;
//
//   Corona2(this.cases, this.casesToday, this.recovered, this.active, this.deaths,
//       this.deathsToday);
//
// //constructor from JSON
//   factory Corona2.fromJson(Map<String, dynamic> json) {
//     return Corona2(json['cases'], json['todayCases'], json['recovered'],
//         json['active'], json['deaths'], json['todayDeaths']);
//   }
// }
