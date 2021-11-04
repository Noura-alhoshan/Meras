import 'package:flutter/material.dart';

class AddGuidlines extends StatefulWidget {
  //const AddGuidlines({ Key? key }) : super(key: key);

  @override
  _AddGuidlinesState createState() => _AddGuidlinesState();
}

class _AddGuidlinesState extends State<AddGuidlines> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //drawer: NavDraweradmin(),
      appBar: AppBar(
        title: Text('إضافة إشارات سير جديدة'),
        backgroundColor: Colors.deepPurple[100],
      ),
    );
  }
}
