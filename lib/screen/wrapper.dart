import 'package:flutter/material.dart';
import 'package:meras/screen/Welcome/welcome_screen.dart';
import 'package:meras/screen/home/home.dart'; 
import 'package:meras/screen/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:meras/models/MyUser.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

   //signed in or not? 2 options
    final user = Provider.of<MyUser?>(context);// i added ? even tho there was no error 
    //print(user);//////////////////////////////////////////////////

    if (user == null){
      return WelcomeScreen();
    } else {
      return home();
    }
  }
}