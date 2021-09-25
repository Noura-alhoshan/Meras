import 'package:flutter/material.dart';
import 'package:meras/screen/authenticate/register_coach.dart';
import 'package:meras/screen/authenticate/register_trainee.dart';
import 'package:meras/screen/authenticate/sign_in.dart'; 
import 'package:meras/screen/authenticate/register.dart';

import 'MyImagePicker.dart';


class  authenticate extends StatefulWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  _authenticateState createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {

  bool showSignIn = true;
  bool showRegisterTrainee = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView:  toggleView);
    }
    // else if (showRegisterTrainee){
    //   return RegisterAsTrainee(toggleView:  toggleView);
    // }else{
    //   return Register(toggleView: toggleView);
    // }
    else {
      return MyImagePicker(toggleView: toggleView);
    }
  }
}