import 'package:firebase_auth/firebase_auth.dart';
import 'package:meras/components/rounded_button.dart';
import 'package:meras/components/rounded_input_field.dart';
import 'package:meras/constants.dart';
import 'package:meras/screen/authenticate/background.dart';
import 'package:meras/screen/home/BaseAlertDialog.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:auto_direction/auto_direction.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  late String _email; //late
  late String space = '';
  final auth = FirebaseAuth.instance;
  String sp = '      ';
  String eror = '';
  bool valid = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
        elevation: 0.0,

        //title: Text('إعادة تعيين كلمة المرور', style: TextStyle(color: Colors.deepPurple,),),
      ),
      body: SingleChildScrollView(
        child: Background(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo1.png',
                height: 230,
              ),
              Text(
                space,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                'الرجاء إدخال بريدك الإلكتروني ليصلك رابط إعادة تعيين كلمة المرور  ',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[800], fontSize: 16.0),
              ),
              SizedBox(height: 10.0),
              RoundedInputField(
                //textAlign: TextAlign.center,
                hintText: sp + "      البريد الإلكتروني",
                validator: (val) => val!.isEmpty
                    ? '         الرجاء إدخال البريد الإلكتروني'
                    : null, //added ! to val
                onChanged: (val) {
                  setState(() => _email = val.trim());
                },
              ),
              Text(
                eror,
                style: TextStyle(color: Colors.red, fontSize: 15.0),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RoundedButton(
                    text: 'إرسال',
                    press: () async {
                      try {
                        await auth.sendPasswordResetEmail(email: _email);
                        valid = true;
                      } catch (error) {
                         print(error.toString());
                        if (error.toString()=='[firebase_auth/unknown] Given String is empty or null'
                        || error.toString()=="LateInitializationError: Field '_email@89216385' has not been initialized.")
                        setState(() {
                          eror = 'الرجاء إدخال البريد الإلكتروني';
                        });
                        else if(error.toString()=='[firebase_auth/invalid-email] The email address is badly formatted.')
                        setState(() {
                          eror = 'الرجاء التحقق من صلاحية البريد الإلكتروني';
                        });
                        else  
                        setState(() {
                          eror = ' البريد الإلكتروني المدخل غير موجود';
                        });

                        valid = false;
                      }
                      if (valid) {
                        var baseDialog = BaseAlertDialog(
                            title: "",
                            content:
                                "تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني   ",
                            yesOnPressed: () async {
                              Navigator.of(context).pop();
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              // Navigator.pop( context,
                              //   MaterialPageRoute(builder: (context) => SignIn()),);
                            },
                            noOnPressed: () {
                              //Navigator.of(context, rootNavigator: true).pop('dialog');
                            },
                            yes: "إغلاق",
                            no: "");
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => baseDialog);
                        //Navigator.of(context).pop();
                      }
                    },
//                  try{
                    //               auth.sendPasswordResetEmail(email: _email);
                    //             }

                    //             catch(error){
                    //               switch (error.toString()) {
                    // case "[firebase_auth/user-not-found]":
                    // case "invalid-email":
                    //   //errorMessage = "Your email address appears to be malformed."
                    //   print("go away");
                    //               setState(() {
                    //                   eror = 'البريد الإلكتروني غير موجود';
                    //                 });
                    //                  break;
                    //  }
                    //                 }
                    // Navigator.of(context).pop();

                    //color: Theme.of(context).accentColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}





