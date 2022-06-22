import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

//Colors
const kRedColor = Color((0xFFFA4659));
const kBackgroundColor = Color(0xFFF0FAFF);
const kTextColor = Color(0xFF000000);
const kWhiteTextColor = Color(0xFFFFFFFF);
const kLightBlueColor = Color(0xFFCFF1FF);
const kDarkBlueColor = Color(0xFF364dc5);

//TextStyles
TextStyle kTitleTextStyle = const TextStyle(
    fontSize: 45.0,
    color: kRedColor,
    letterSpacing: 2,
    fontFamily: 'IndieFlower',
    shadows: [
      Shadow(color: Colors.grey, offset: Offset(0, 4), blurRadius: 10)
    ]);

TextStyle kTextTextStyleBlack14 = const TextStyle(
  fontSize: 14.0,
  color: kTextColor,
  letterSpacing: 2,
  fontFamily: 'IndieFlower',
);
TextStyle kTextTextStyleBlack14Bold = const TextStyle(
  fontSize: 14.0,
  color: kTextColor,
  letterSpacing: 2,
  fontFamily: 'IndieFlower',
  fontWeight: FontWeight.bold,
);
TextStyle kTextTextStyleBlack11 = const TextStyle(
  fontSize: 11.0,
  color: kTextColor,
  letterSpacing: 2,
  fontFamily: 'IndieFlower',
);
TextStyle kTextTextStyleBlack11Bold = const TextStyle(
    fontSize: 11.0,
    color: kTextColor,
    letterSpacing: 2,
    fontFamily: 'IndieFlower',
    fontWeight: FontWeight.bold);
TextStyle kTextTextStyleBlack9 = const TextStyle(
  fontSize: 9.0,
  color: kTextColor,
  letterSpacing: 2,
  fontFamily: 'IndieFlower',
);
TextStyle kCoronaCardTextStyleBold14 = const TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  color: kRedColor,
  letterSpacing: 2,
  fontFamily: 'IndieFlower',
);
TextStyle kTextTextStyleBlack20 = const TextStyle(
  fontSize: 20.0,
  color: kTextColor,
  decoration: TextDecoration.underline,
  letterSpacing: 2,
  fontFamily: 'IndieFlower',
);
TextStyle kTextTextStyleBlue14 = const TextStyle(
  fontSize: 14.0,
  color: kBackgroundColor,
  letterSpacing: 2,
  fontFamily: 'IndieFlower',
);
TextStyle kTextTextStyleBlue11 = const TextStyle(
  fontSize: 11.0,
  color: kBackgroundColor,
  letterSpacing: 2,
  fontFamily: 'IndieFlower',
);
TextStyle kTextTextStyleRedColor20 = const TextStyle(
  fontSize: 20.0,
  color: kRedColor,
  letterSpacing: 2,
  fontFamily: 'IndieFlower',
);
TextStyle kTextTextStyleRedColor14 = const TextStyle(
  fontSize: 14.0,
  color: kRedColor,
  letterSpacing: 2,
  fontFamily: 'IndieFlower',
);
TextStyle kTextTextStyleRedColor14Bold = const TextStyle(
  fontSize: 14.0,
  color: kRedColor,
  letterSpacing: 2,
  fontFamily: 'IndieFlower',
  fontWeight: FontWeight.bold,
);
TextStyle kTextTextStyleRedColor14Underline = const TextStyle(
    fontSize: 14.0,
    color: kRedColor,
    decoration: TextDecoration.underline,
    letterSpacing: 2,
    fontFamily: 'IndieFlower',
    fontWeight: FontWeight.bold);
TextStyle kTextTextStyleRedColor12Underline = const TextStyle(
    fontSize: 12.0,
    color: kRedColor,
    decoration: TextDecoration.underline,
    letterSpacing: 2,
    fontFamily: 'IndieFlower',
    fontWeight: FontWeight.bold);
TextStyle kTextTextStyleRedColor12 = const TextStyle(
  fontSize: 12.0,
  color: kRedColor,
  letterSpacing: 2,
  fontFamily: 'IndieFlower',
);
TextStyle kTextTextStyleRedColor9 = const TextStyle(
  fontSize: 9.0,
  color: kRedColor,
  letterSpacing: 2,
  fontFamily: 'IndieFlower',
);
TextStyle kTextTextStyleRedColor11 = const TextStyle(
  fontSize: 11.0,
  color: kRedColor,
  letterSpacing: 2,
  fontFamily: 'IndieFlower',
);
TextStyle kTextTextStyleWhite14 = const TextStyle(
  fontSize: 14.0,
  color: kWhiteTextColor,
  letterSpacing: 2,
  fontFamily: 'IndieFlower',
);

double setHeight(context, double percent) {
  return MediaQuery.of(context).size.height * percent;
}

double setWidth(context, double percent) {
  return MediaQuery.of(context).size.width * percent;
}

//==============================================================
//==============================================================
//==============================================================
//formatters
List<TextInputFormatter> kTxtFmt = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(
    RegExp(r'([a-zA-Z0-9-(),\s])'),
  ),
];

List<TextInputFormatter> kNamesFmt = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(
    RegExp(r'([a-zA-Z])'),
  ),
];

List<TextInputFormatter> kWordsFmt = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(
    RegExp(r'([a-zA-Z\s])'),
  ),
];

List<TextInputFormatter> kDigitsFmt = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(
    RegExp(r'([0-9])'),
  ),
];

List<TextInputFormatter> kAlphaNumSpecialFmt = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(
    RegExp(r'([0-9a-zA-z! #$%@&*+-/=? ^_`{|}~\.])'),
  ),
];

//Temp List for Testing
List<String> kPatients = <String>[
  '',
];
//Lists for Queue
List<String> temperatureDegrees = <String>['C°', 'F°'];
List<String> kPulseUnit = <String>[
  'BPM',
];
List<String> kRespirationUnit = <String>[
  'BPM',
];
List<String> kBloodPressureUnit = <String>[
  'mmHg',
];
//Lists for Patients
List<String> kBloodTypes = <String>[
  'A+',
  'A-',
  'B+',
  'B-',
  'O+',
  'O-',
  'AB+',
  'AB-'
];
List<String> kGenderTypes = <String>[
  'M',
  'F',
  'O',
];
List<String> kMaritalStatus = <String>[
  'M',
  'S',
  'W',
  'D',
  'L.S.',
];
//Queue List
List<dynamic> kQueue = <dynamic>[
  '',
];
//QUOTES
const List<String> kQuotes = <String>[
  "\“Wherever the art of Medicine is loved, there is also a love of Humanity. \” ― Hippocrates",
  "\“Always laugh when you can, it is cheap medicine.\” ― Lord Byron",
  "\“Wherever the art of Medicine is loved, there is also a love of Humanity. \” ― Hippocrates",
  "\“Two blood vessels fell in love but alas, it was all in vein.\“ Ba Dum Tss",
  "\“I went to the library to get a medical book on abdominal pain. Somebody had ripped the appendix out.\“",
  "\“For years I was against organ transplants. Then I had a change of heart\“",
  "\“When you get a bladder infection, urine trouble!\“",
  "\“When neurons commit a crime, they are put in a nerve cell\“",
  "\“If you steal someone’s heart, do you get cardiac arrested?\“",
  "\“I asked a surgeon if he could give me something for my liver, he gave me half a pound of onions\“",
  "\“What sickness does a martial artist have? Kung FLU!\“",
  "\“Not only do I have short-term memory loss! But I have short-term memory loss too\“",
  "\“Doctors get mad when they run out of patients!\“",
  "\“Never lie to an X-ray technician. They can see right through you\“",
  "\“The banana went to the hospital because it was not peeling well\“",
  "\“I don’t find medical puns funny anymore since I began suffering from an irony deficiency\“",
  "\“A chiropractor\'s favorite music genre is Hip Pop!\“",
  "\“Be quiet inside a pharmacy, you might wake the sleeping pills\“!",
  "\“Why did they take paracetamol to prison? It's a pain killer\“"
];

String selectRandomQuote(List<String> quotes) {
  int idx = Random().nextInt(quotes.length);
  String quote = quotes[idx];
  return quote;
}

int kNewsIndex = 0;

NumberFormat kMRNFormatter = NumberFormat("0000");
