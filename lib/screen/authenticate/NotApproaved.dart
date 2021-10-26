import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meras/screen/authenticate/background.dart';
import 'package:meras/screen/authenticate/register_coach.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/screen/authenticate/sign_in.dart';

class notApproaved extends StatefulWidget {
  @override
  _notapproavedState createState() => _notapproavedState();
}

class _notapproavedState extends State<notApproaved> {
  // const home({ Key? key }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  // final AuthService _auth = AuthService();

  @override
  //  bool showSignIn = true;
  // void toggleView(){
  //   //print(showSignIn.toString());
  //   setState(() => showSignIn = !showSignIn);
  // }

  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Background(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 7.0),
            child: Container(
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
                        title: const Text(
                          'عزيزي المدرب',
                          textAlign: TextAlign.center,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0))),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: const <Widget>[
                              //Text('عزيزي المدرب',textAlign: TextAlign.center,),
                              //Text(''),
                              Text(
                                'يَسعد مِرَاس بانضمامك' + '!',
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                              ),
                              Text(
                                'يمكنك تسجيل الدخول بعد توثيق حسابك',
                                textAlign: TextAlign.center,
                              ),
                              Text('ملاحظة: يتم التوثيق حسب صلاحية رخصة قيادتك',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.0)),
                              Text(''),
                              Text(
                                'فريق مِرَاس',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        //backgroundColor: Colors.deepPurple[50],
                        actions: <Widget>[
                          Center( child:
                          TextButton(
                            child: const Text(
                              'إغلاق',
                              style: TextStyle(
                                  color: Colors.deepPurple, fontSize: 16.0),
                            ),
                            onPressed: () async {
                              final FirebaseAuth _auth = FirebaseAuth.instance;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()),
                              );
                              return await _auth.signOut();
                              //SystemNavigator.pop();
                              // glovar=1;
                            },
                          ),)
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
