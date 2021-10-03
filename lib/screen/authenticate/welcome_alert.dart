import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meras/screen/authenticate/background.dart';
import 'package:meras/screen/authenticate/register_coach.dart';
import 'package:meras/screen/authenticate/register_trainee.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/screen/authenticate/sign_in.dart';

class WelcomeAlert extends StatefulWidget {


  @override
  _WelcomeAlertState createState() => _WelcomeAlertState();
}

class _WelcomeAlertState extends State<WelcomeAlert> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(

        body: Background( child:
        SingleChildScrollView(
          padding: EdgeInsets.only(top: 7.0),
          child:


          Container(

            padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 50.0),
            child: Form(

                key: _formKey,
                child: Column(
                  children: <Widget>[


                    Text(
                      '',
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    SizedBox(height: 40.0),


                    AlertDialog(
                      title: const Text('عزيزي المتعلم',textAlign: TextAlign.center,),
                      content: SingleChildScrollView(

                        child: ListBody(
                          children: const <Widget>[

                            //Text('عزيزي المدرب',textAlign: TextAlign.center,),
                            //Text(''),
                            Text('!يَسعد مِرَاس بانضمامك',textAlign: TextAlign.center,),
                            Text('يمكنك الآن تسجيل الدخول في صفحة تسجيل الدخول',textAlign: TextAlign.center,),
                            Text(''),
                            Text('فريق مِرَاس',textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                      //backgroundColor: Colors.deepPurple[50],
                      actions: <Widget>[
                        TextButton(
                          child: const Text('إغلاق', style:TextStyle(color: Colors.deepPurple, fontSize: 16.0) , ),
                          onPressed: () async {
                            Navigator.push( context,
                              MaterialPageRoute(builder: (context) => SignIn()),);
                            // MaterialPageRoute(builder: (context) => SignIn());
                          },
                        ),
                      ],

                    )],
                )
            ),
          ),
        ),
        ),
      ),);
  }
}
