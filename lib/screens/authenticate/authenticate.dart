import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/screens/authenticate/sign_in.dart';
import 'package:meras/screens/authenticate/sign_up_as_coach.dart';
import 'package:meras/screens/authenticate/sign_up_as_trainee.dart';
import 'package:meras/services/auth.dart';

class authenticate extends StatefulWidget {
  //const authenticate({Key? key}) : super(key: key);

  @override
  _authenticateState createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {
  bool showSignIn = true;
  //bool showSignUpAsTrainee = false;

  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }
  //AuthService firebaseAuth = AuthService();
  @override
  Widget build(BuildContext context) {

    if(showSignIn){
      return SignIn(toggleView:  toggleView);
    } else{
      return RegisterAsTrainee(toggleView:  toggleView);
    }
    }
  }
