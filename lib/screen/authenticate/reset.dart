import 'package:firebase_auth/firebase_auth.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart'; 
import 'package:auto_direction/auto_direction.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  late String _email;//late
  late String space='';
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
        elevation: 0.0,
        
        //title: Text('إعادة تعيين كلمة المرور', style: TextStyle(color: Colors.deepPurple,),),
      ),

      body: Column(
        
        children: [
          
            Image.asset('assets/images/logo.png', height: 230,),
            Text(
                space,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              SizedBox(height: 10.0),
            Text(
                 'الرجاء إدخال بريدك الإلكتروني ليصلك رابط إعادة تعيين كلمة المرور',
                style: TextStyle(color: Colors.grey[800], fontSize: 16.0),
              ),
              SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: 
            
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
               decoration: InputDecoration(
                 //'الرجاء إدخال بريدك الإلكتروني ليصلك رابط إعاد تعيين كلمة المرور'
                focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 2 ,color: Colors.deepPurple),
              ),
              hintText: "البريد الإلكتروني"  ),
               onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),


           Text(
                space,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            
            children: [
              ElevatedButton(
                //color: Colors.pink[400],
                 child: Text('إرسال'),
                  style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple[50],
                  onPrimary: Colors.deepPurple[900],
                ),
                onPressed: () {
                  auth.sendPasswordResetEmail(email: _email);
                  Navigator.of(context).pop();
                },
                //color: Theme.of(context).accentColor,
              ),

            ],
          ),

        ],),
    );
  }
}