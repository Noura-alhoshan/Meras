//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:meras/screen/home/home.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart'; 
import 'package:auto_direction/auto_direction.dart';
import 'package:meras/screen/authenticate/reset.dart'; 


 dynamic glovar=0 ;
 bool glovar2= true;
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
  
   //
  
  // text field state
  String email = '';
  String password = '';
  String sp='                              ';

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      
      backgroundColor: Colors.purple[30],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
        elevation: 0.0,
        //title: Text('مراس'),
        actions: <Widget>[
         // FlatButton.icon(
            //icon: Icon(Icons.person),
           // label: Text('إنشاء حساب'),
            //onPressed: () => widget.toggleView(),
         // ),
        ],
      ),
      
      
      body: 
      SingleChildScrollView( child: 
      Container(
   
        padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 50.0),
        child: Form( 
          
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Image.asset('assets/images/logo.png', height: 230,),
              TextFormField(
               textAlign: TextAlign.center,
               decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 2 ,color: Colors.deepPurple),
              ),
              hintText: "البريد الإلكتروني"

            ),
                validator: (val) => val!.isEmpty? sp+'الرجاء إدخال البريد الإلكتروني' : null,//added ! to val
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 2 ,color: Colors.deepPurple),
              ),
              
              hintText: "كلمة المرور"
               ),
                obscureText: true,
                validator: (val) => val!.length < 1 ? sp+'   الرجاء إدخال كلمة المرور' : null,//added ! to val
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              SizedBox(height: 10.0),

              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Text('هل نسيت كلمة المرور؟'),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ResetScreen()),
                ),
              )
            ],
          ),
               ElevatedButton(
                //color: Colors.pink[400],
                child: Text('دخول'),
                  style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple[50],
                  onPrimary: Colors.deepPurple[900],
                ),
                onPressed:  () async {
                  //glovar=0;
                  if(_formKey.currentState!.validate()){//added a ! check
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password,context);
                    //dynamic er =   _auth.showError();
                    //print(glovar);
                    //if (glovar != null)
                    if(result == null) {
                       setState(() {
                        error = 'لا يمكن تسجيل الدخول بالمعلومات المعطاة';
                        //print('damn here again');
                      });
                      }
                     
                      //glovar=0;
                     //dynamic er =   _auth.showError();
                    //   if( _auth.showError() == null ) {
                    //    setState( ()  {
                    //     error = 'لا يمكن تسجيل الدخول بالمعلومات المعطاة';
                    //   });
                    //   }
                     }

                     
                  }
                
              ),
              
              // Text(
              //   ermsg,
              //   style: TextStyle(color: Colors.red, fontSize: 14.0),
              // ),
              // SizedBox(height: 10.0),
              
            ],
          ),
        ),
      ),
      ),
    );
    
  }


  
}