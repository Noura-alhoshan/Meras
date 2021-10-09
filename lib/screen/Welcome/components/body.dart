import 'package:flutter/material.dart';
//import 'package:meras/screen/Login/login_screen.dart';
import 'package:meras/screen/Signup/signup_screen.dart';
import 'package:meras/screen/Welcome/components/background.dart';
import 'package:meras/components/rounded_button.dart';
import 'package:meras/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meras/screen/authenticate/sign_in.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "مِرَاس حيث تعلم القيادة أسهل",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            SizedBox(height: size.height * 0.02),
            Image.asset(
              "assets/images/logo.png",
              width: size.width * 0.7,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "تسجيل دخول",
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
            RoundedButton(
              text: "إنشاء حساب مدرب",
              color: kPrimaryLightColor,
              textColor: Colors.black,
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
            RoundedButton(
              text: "إنشاء حساب متعلم",
              color: kPrimaryLightColor,
              textColor: Colors.black,
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
