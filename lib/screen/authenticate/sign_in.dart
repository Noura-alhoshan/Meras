import 'package:firebase_auth/firebase_auth.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart'; 
import 'package:auto_direction/auto_direction.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ required this.toggleView });//added required

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[30],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        title: Text('مراس'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('إنشاء حساب'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      
      
      body: Container(
       
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form( 
          
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
              decoration: InputDecoration(
              hintText: "البريد الإلكتروني"

            ),
                validator: (val) => val!.isEmpty? 'الرجاء إدخال البريد الإلكتروني' : null,//added ! to val
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
              decoration: InputDecoration(
              hintText: "الرمز السري"
            ),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'الرجاء إدخال الرمز السري' : null,//added ! to val
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                //color: Colors.pink[400],
                child: Text('دخول'),
                  style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple[800],
                  textStyle: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){//added a ! check
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        error = 'لا يمكن تسجيل الدخول بالمعلومات المعطاة';
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}