import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_auth/components/text_field_container.dart';
//import 'package:flutter_auth/constants.dart';
import 'package:meras/components/text_field_container.dart';
import 'package:meras/constants.dart';

class NameRoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final FormFieldValidator validator;
  final ValueChanged<String> onChanged;
  const NameRoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
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
        inputFormatters: [
          new LengthLimitingTextInputFormatter(10),
        ],
      ),
    );
  }
}
