import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomDropdownList extends StatefulWidget {
  CustomDropdownList({
    Key? key,
    required this.dropDownItemSelected,
    required this.l,
    required this.onChanged,
  }) : super(key: key);
  String dropDownItemSelected;
  final List<String> l;
  final Function(String?) onChanged;

  @override
  State<CustomDropdownList> createState() => _CustomDropdownListState();
}

class _CustomDropdownListState extends State<CustomDropdownList> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: widget.dropDownItemSelected,
      elevation: 16,
      style: const TextStyle(color: kRedColor),
      underline: Container(
        height: 2,
        color: kRedColor,
      ),
      onChanged: widget.onChanged,
      //     (String? newValue) {
      //   setState(() {
      //     widget.dropDownItemSelected = newValue!;
      //   });
      // },
      items: widget.l.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: SizedBox(
            width: setWidth(context, 0.08),
            child: AutoSizeText(
              value,
              style: kTextTextStyleBlack11,
              textAlign: TextAlign.center,
              minFontSize: 9,
              maxFontSize: 11,
              maxLines: 1,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CustomDropDownItems extends StatelessWidget {
  const CustomDropDownItems({
    Key? key,
    required this.title,
    required this.item,
    required this.list,
    required this.height,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final String item;
  final List<String> list;
  final double height;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: setHeight(context, height),
      width: setWidth(context, 0.18),
      child: Column(
        children: <Widget>[
          AutoSizeText(
            title,
            style: kTextTextStyleRedColor11,
            textAlign: TextAlign.center,
            maxFontSize: 11,
            minFontSize: 9,
            maxLines: 2,
          ),
          CustomDropdownList(
            dropDownItemSelected: item,
            l: list,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
