import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meras/screen/authenticate/background.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
      //color: Colors.deepPurple[50],
      
      Scaffold(
        body:Background(child: SpinKitChasingDots(
          color: Colors.deepPurple[100],
          size: 50.0,
        ),
      ),
    )
    ;
  }
}