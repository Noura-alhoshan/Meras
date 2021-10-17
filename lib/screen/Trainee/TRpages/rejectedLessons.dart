import 'package:flutter/material.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';

class RejectedLessons extends StatefulWidget {
  //const RejectedLessons({ Key? key }) : super(key: key);

  @override
  _RejectedLessonsState createState() => _RejectedLessonsState();
}

class _RejectedLessonsState extends State<RejectedLessons> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            child: BackgroundA(
      child: Center(
        child: Text('Rejected lessons page'),
      ),
    )));
  }
}
