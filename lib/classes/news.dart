import 'dart:math';

import 'package:capstone_project/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
//Convert the response body into a JSON Map with the dart:convert package

class MedicalNews {
  String title;
  String author;
  String description;
  String websiteURL;
  String imgURL;


  MedicalNews(
      this.title, this.author, this.description, this.imgURL, this.websiteURL);



  factory MedicalNews.fromJson(Map<String, dynamic> json) {
    return MedicalNews(
      json['articles'][kNewsIndex]['title'],
      json['articles'][kNewsIndex]['author'],
      json['articles'][kNewsIndex]['description'],
      json['articles'][kNewsIndex]['urlToImage'],
      json['articles'][kNewsIndex]['url'],
    );
  }
}



Future<MedicalNews> fetchNews() async {
  final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/everything?q=medicine&apiKey=562cf45e3f0443398957b734375ceaab'));

  if (response.statusCode == 200) {
    // print('\n\n\n'+response.body);
    return MedicalNews.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

//562cf45e3f0443398957b734375ceaab
// https://newsapi.org/v2/everything?q=medicine&apiKey=562cf45e3f0443398957b734375ceaab
