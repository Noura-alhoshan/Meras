import 'package:meras/screen/Signup/components/background.dart';
import 'package:meras/components/already_have_an_account_acheck.dart';
import 'package:meras/components/rounded_button.dart';
import 'package:meras/components/rounded_input_field.dart';
import 'package:meras/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:meras/screen/Signup/signup_screen.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart'; 
import 'package:auto_direction/auto_direction.dart';
import 'package:meras/screen/authenticate/reset.dart'; 




class Body extends StatelessWidget {
  // const Body({
  //   Key? key,
  // }) : super(key: key);

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  
   //
  
  // text field state
  String email = '';
  String password = '';
  String sp='                              ';




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "تسجيل دخول",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: size.height * 0.1),
            // SvgPicture.asset(
            //   "assets/icons/login.svg",
            //   height: size.height * 0.35,
            // ),
            SizedBox(height: size.height * 0.1),
            TextFormField(
              decoration: InputDecoration(hintText: "البريد الاكتروني"),
              validator: (val) => val!.isEmpty? sp+'الرجاء إدخال البريد الإلكتروني' : null,//added ! to val
                onChanged: (val) {
                 // setState(() => email = val);
                },
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "دخول",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
