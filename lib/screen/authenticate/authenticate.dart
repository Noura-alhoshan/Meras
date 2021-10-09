import 'package:flutter/material.dart';
import 'package:meras/screen/authenticate/register_trainee.dart';
import 'package:meras/screen/authenticate/sign_in.dart'; 



class  authenticate extends StatefulWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  _authenticateState createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {

  bool showSignIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn();
    } else {
      return RegisterAsTrainee();
    }
  }
}