//import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meras/components/already_have_an_account_acheck.dart';
import 'package:meras/components/rounded_button.dart';
import 'package:meras/components/rounded_input_field.dart';
import 'package:meras/components/rounded_password_field.dart';
import 'package:meras/screen/Signup/signup_screen.dart';
import 'package:meras/screen/authenticate/NotApproaved.dart';
import 'package:meras/screen/authenticate/background.dart';
import 'package:meras/screen/authenticate/register_coach.dart';
import 'package:meras/screen/authenticate/register_trainee.dart';
import 'package:meras/screen/home/home.dart';
import 'package:meras/screen/wrapper.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:meras/screen/authenticate/reset.dart';

import '../../constants.dart';
//import 'package:meras/components/text_field_container.dart';

class SignIn extends StatefulWidget {
  //final Function toggleView;
  //SignIn({ required this.toggleView });//added required

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool _passwordVisible = true;
  //dynamic glovar = 0;
  bool glovar2 = true;
  //

  // text field state
  String email = '';
  String password = '';
  String sp = '      ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[30],
      body: SingleChildScrollView(
        //  physics: const NeverScrollableScrollPhysics(), //<--here

        child: Background(
          //padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 40.0),
                //    SizedBox(height: 40.0),  //update
                Image.asset(
                  'assets/images/logo1.png',
                  height: 230,
                ),
                RoundedInputField(
                  //textAlign: TextAlign.center,
                  hintText: sp + "      البريد الإلكتروني",
                  validator: (val) => val!.isEmpty
                      ? '         الرجاء إدخال البريد الإلكتروني'
                      : null, //added ! to val
                  onChanged: (val) {
                    setState(() => email = val.trim());
                  },
                ),
                SizedBox(height: 20.0),
                RoundedPasswordField(
                  obscure: _passwordVisible,
                  validator: (val) => val!.length < 1
                      ? '             الرجاء إدخال كلمة المرور'
                      : null, //added ! to val
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  icons: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: kPrimaryColor,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 15.0),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text(
                        'هل نسيت كلمة المرور؟',
                        style: TextStyle(fontSize: 15.8),
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ResetScreen()),
                      ),
                    )
                  ],
                ),
                RoundedButton(
                    text: 'دخول',
                    press: () async {
                      //glovar=0;
                      if (_formKey.currentState!.validate()) {
                        //added a ! check
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password, context);
                        //dynamic er =   _auth.showError();
                        //print(glovar);
                        //if (glovar != null)
                        // if (result != null &&
                        //     result.email == "DefaultEmail@gmail.com")
                        //   await _auth.signOut();
                        // else
                        if (result == null) {
                          setState(() {
                            error = 'لا يمكن تسجيل الدخول بالمعلومات المعطاة';
                            glovar2 = false;
                            //print('damn here again');
                          });
                        } else
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Wrapper()), //CHANGE IT
                          );
                        //glovar=0;
                        //dynamic er =   _auth.showError();
                        //   if( _auth.showError() == null ) {
                        //    setState( ()  {
                        //     error = 'لا يمكن تسجيل الدخول بالمعلومات المعطاة';
                        //   });
                        //   }
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text(
                        'أو حساب مدرب',
                        style: TextStyle(
                            fontSize: 15.5,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterAsCoatch()), //CHANGE IT
                      ),
                    ),
                    TextButton(
                      child: Text(
                        '  حساب متعلم',
                        style: TextStyle(
                            fontSize: 15.5,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => RegisterAsTrainee()),
                      ),
                    ),
                    Text(' ليس لديك حساب؟ قم بإنشاء',
                        style: TextStyle(fontSize: 15.5, color: kPrimaryColor)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
