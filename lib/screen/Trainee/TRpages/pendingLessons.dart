import 'package:flutter/material.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';

class PendingLessons extends StatefulWidget {
  //const PendingLessons({ Key? key }) : super(key: key);

  @override
  _PendingLessonsState createState() => _PendingLessonsState();
}

class _PendingLessonsState extends State<PendingLessons> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            child: BackgroundA(
      child: Center(
        child: Text('Pending lessons page'),
      ),
    )));
  }
}
