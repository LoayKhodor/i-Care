import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/constants.dart';

//used in login/registration screens
class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    Key? key,
    required this.hintTxt,
    required this.stringType,
    required this.labelText,
    required this.maxLength,
    required this.textfieldSize,
    this.capitalize,
    this.onChanged,
    this.fmt,
  }) : super(key: key);
  final String hintTxt;
  final String stringType;
  final String textfieldSize;
  final String labelText;
  final int maxLength;
  final bool? capitalize;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? fmt;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: (textfieldSize == 'small')
            ? setWidth(context, 0.35)
            : setWidth(context, 1),
        maxHeight: setHeight(context, 0.09),
        minWidth: (textfieldSize == 'small')
            ? setWidth(context, 0.35)
            : setWidth(context, 1),
        minHeight: setHeight(context, 0.09),
      ),
      child: TextField(
        // maxFontSize: 14,
        // minFontSize: 9,
        maxLines: 1,
        textCapitalization: (capitalize == null)
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        onChanged: onChanged,
        // keyboardType: TextInputType.emailAddress,
        // fullwidth: false,
        textAlign: TextAlign.left,
        obscureText: (stringType == 'password') ? true : false,
        enableSuggestions: (stringType == 'd') ? true : false,
        autocorrect: (stringType == 'password') ? true : false,
        maxLength: maxLength,
        inputFormatters: fmt,
        style: kTextTextStyleBlack11,
        decoration: InputDecoration(
          hintText: hintTxt,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kRedColor, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          labelText: labelText,
          labelStyle: kTextTextStyleBlack11,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kRedColor, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          contentPadding:
              const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
        ),
      ),
    );
  }
}

//used once in Patients Screen
class CustomSearchField extends StatelessWidget {
  CustomSearchField(
      {Key? key,
      required this.hintTxt,
      required this.width,
      required this.labelTxt,
      required this.onChanged,
      this.onEditingComplete})
      : super(key: key);
  final String hintTxt;
  final String labelTxt;
  final double width;
  final Function(String?) onChanged;
  final Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: setHeight(context, 0.09),
      child: TextField(
        textAlign: TextAlign.left,
        autocorrect: true,
        enableSuggestions: true,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@.!\$_-]"))
        ],
        style: kTextTextStyleBlack14,
        decoration: InputDecoration(
          hintText: hintTxt,
          hintStyle: kTextTextStyleBlack14,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kRedColor, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          labelText: labelTxt,
          labelStyle: kTextTextStyleBlack14,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kRedColor, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          contentPadding:
              const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
        ),
      ),
    );
  }
}

//used in Patients Screen - can take in Patient Name - Top red search field with white font
class PatientSearchField extends StatefulWidget {
  PatientSearchField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);
  final Function(String?) onChanged;

  @override
  State<PatientSearchField> createState() => _PatientSearchFieldState();
}

class _PatientSearchFieldState extends State<PatientSearchField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: setHeight(context, 0.06),
      width: setWidth(context, 0.5),
      child: TextField(
        maxLines: 1,
        onChanged: widget.onChanged,
        textCapitalization: TextCapitalization.sentences,
        textAlign: TextAlign.left,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z-]"))
        ],
        style: kTextTextStyleWhite14,
        decoration: InputDecoration(
          hintStyle: kTextTextStyleWhite14,
          filled: true,
          fillColor: kRedColor,
          hintText: 'Search...',
          contentPadding: EdgeInsets.all(10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kRedColor, width: 1.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kRedColor, width: 1.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}

//used in Patients Screens
class PatientTextField extends StatefulWidget {
  PatientTextField({
    required this.hintTxt,
    required this.labelText,
    this.maxLength,
    required this.width,
    this.onPressed,
    this.units,
    this.fmt,
    this.textToShow,
    this.onComplete,
    this.maxLines,
    this.height,
    this.capitalize,
    required this.onChanged,
  });

  final Function(String?) onChanged;
  final String hintTxt;
  String? textToShow;
  final double width;
  final String labelText;
  final int? maxLength;
  final VoidCallback? onPressed;
  final String? units;
  final List<TextInputFormatter>? fmt;
  final VoidCallback? onComplete;
  final int? maxLines;
  final double? height;
  final bool? capitalize;

  @override
  State<PatientTextField> createState() => _PatientTextFieldState();
}

class _PatientTextFieldState extends State<PatientTextField> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    controller.text = widget.textToShow ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: setWidth(context, widget.width),
      height: setHeight(context, 0.09),
      child: AutoSizeTextField(
        onEditingComplete: widget.onComplete,
        maxFontSize: 14,
        minFontSize: 9,
        textCapitalization: (widget.capitalize == true)
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        // fullwidth: false,
        onTap: widget.onPressed,
        onChanged: widget.onChanged,
        controller: controller,
        textAlign: TextAlign.left,
        obscureText: false,
        autocorrect: false,
        enableSuggestions: true,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines ?? 1,
        textInputAction: TextInputAction.newline,
        minLines: 1,
        inputFormatters: (widget.fmt != null)
            ? widget.fmt
            : [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9+-]"))],
        style: kTextTextStyleBlack11,
        decoration: InputDecoration(
          hintText: widget.hintTxt,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kRedColor, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          labelText: widget.labelText,
          labelStyle: kTextTextStyleBlack9,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kRedColor, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          contentPadding:
              const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
        ),
      ),
    );
  }
}
