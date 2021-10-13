import 'package:flutter/material.dart';
//import 'package:flutter_auth/constants.dart';
import 'package:meras/constants.dart';

class RoundedButtonAdmin extends StatelessWidget {
  //final VoidCallback onPressed;
  final String text;
  final VoidCallback press; //changed funtion to VoidCallback
  final Color color, textColor;
  const RoundedButtonAdmin({
    Key? key,
    required this.text,
    required this.press,
    this.color = Colors.white54,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 350,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 19
            //shadowColor: Colors.deepPurple[500],
            ),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
          primary: Colors.deepPurple[50],
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          textStyle: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}
