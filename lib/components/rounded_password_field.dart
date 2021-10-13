import 'package:flutter/material.dart';
//import 'package:flutter_auth/components/text_field_container.dart';
//import 'package:flutter_auth/constants.dart';
import 'package:meras/components/text_field_container.dart';
import '../constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final FormFieldValidator validator;
  final IconButton icons;
  final bool obscure;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.validator,
    required this.icons,
    required this.obscure,
    //String? Function(val) validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //String sp='  ';
    return TextFieldContainer(
      child: TextFormField(
        //validator: (val) => val!.length < 1 ? sp+'   الرجاء إدخال كلمة المرور' : null,
        // textAlign:TextAlign.center,

        validator: validator,
        obscureText: obscure,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "                كلمة المرور",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: icons,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
