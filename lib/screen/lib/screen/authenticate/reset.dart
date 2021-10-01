import 'package:firebase_auth/firebase_auth.dart';
import 'package:meras/components/rounded_button.dart';
import 'package:meras/components/rounded_input_field.dart';
import 'package:meras/constants.dart';
import 'package:meras/screen/authenticate/background.dart';
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
  String sp='      ';
  String eror = '';
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(  
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        elevation: 0.0,
        
        //title: Text('إعادة تعيين كلمة المرور', style: TextStyle(color: Colors.deepPurple,),),
      ),

      body:
       SingleChildScrollView( 
         
child: Background( 
      child:
      Column(
        
        children: [
          
            Image.asset('assets/images/logo1.png', height: 230,),
            Text(
              
                space,
                style: TextStyle(color: Colors.red, fontSize: 14.0, ),
              ),
              SizedBox(height: 5.0),
            Text(
                 'الرجاء إدخال بريدك الإلكتروني ليصلك رابط إعادة تعيين كلمة المرور',
                style: TextStyle(color: Colors.grey[800], fontSize: 16.0),
              ),
              SizedBox(height: 10.0),
       
            
           RoundedInputField(
               //textAlign: TextAlign.center,
               hintText: sp+"      البريد الإلكتروني",
                validator: (val) => val!.isEmpty? '         الرجاء إدخال البريد الإلكتروني' : null,//added ! to val
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
                press: ()  {
                  try{
                    auth.sendPasswordResetEmail(email: _email);
                    Navigator.of(context).pop();
                   }
                  catch(error){
                    setState(() {
                        eror = 'لا يمكن تسجيل الدخول بالمعلومات المعطاة';  
                      });
                      }
                },
                //color: Theme.of(context).accentColor,
              ),

            ],
          ),
        ],),
       ),
    ),);
  }
}