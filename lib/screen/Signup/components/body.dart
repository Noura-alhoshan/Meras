import 'package:flutter/material.dart';
//import 'package:meras/Screens/Login/login_screen.dart';
import 'package:meras/screen/Signup/components/background.dart';
import 'package:meras/components/already_have_an_account_acheck.dart';
import 'package:meras/components/rounded_button.dart';
import 'package:meras/components/rounded_input_field.dart';
import 'package:meras/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meras/screen/authenticate/sign_in.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "إنشاء حساب مدرب جديد",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: size.height * 0.03),
            // SvgPicture.asset(
            //   "assets/icons/signup.svg",
            //   height: size.height * 0.35,
            // ),
            RoundedInputField(
              hintText: "الأسم الأول",
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "الأسم الاخير",
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "العمر",
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "البريد الاكتروني",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "رقم الجوال",
              onChanged: (value) {},
            ),
            // RoundedInputField(
            //   hintText: "نبذة تعريفية",
            //   onChanged: (value) {},
            // ),
            // RoundedInputField(
            //   hintText: "المدينة",
            //   onChanged: (value) {},
            // ),
            RoundedButton(
              text: "إنشاء حساب",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignIn();
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
