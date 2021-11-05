import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
//import 'package:flutter_auth/components/text_field_container.dart';
//import 'package:flutter_auth/constants.dart';
import 'package:meras/components/text_field_container.dart';
import 'package:meras/constants.dart';

class ADroundedTitle extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final FormFieldValidator validator;
  final ValueChanged<String> onChanged;
  const ADroundedTitle({
    Key? key,
    required this.hintText,
    this.icon = Icons.article_rounded,
    required this.onChanged,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        maxLines: null,
        // textAlign: TextAlign.center,
        onChanged: onChanged,
        //obscureText: true,
        validator: validator,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
        //maxLength: 8,
        inputFormatters: [
          new LengthLimitingTextInputFormatter(150),
        ],
      ),
    );
  }
}
