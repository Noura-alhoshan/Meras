import 'package:flutter/material.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';

class AcceptedLessons extends StatefulWidget {
  //const AcceptedLessons({ Key? key }) : super(key: key);

  @override
  _AcceptedLessonsState createState() => _AcceptedLessonsState();
}

class _AcceptedLessonsState extends State<AcceptedLessons> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            child: BackgroundA(
      child: Center(
        child: Text('Accepted lessons page'),
      ),
    )));
  }
}
