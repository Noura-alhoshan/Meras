import 'package:flutter/material.dart';
import 'package:meras/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;//changed function to VoidCallback
  const AlreadyHaveAnAccountCheck({
     Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "اذا لم يكن لديك حساب " : " اذا كان لديك حساب",
          style: TextStyle(color: kPrimaryColor,fontSize: 16),
        ),
        GestureDetector(
          onTap : press,
          child: Text(
            login ? " سجل" : " ادخل ",
            style: TextStyle(
              fontSize: 16,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
