import 'package:flutter/material.dart';
import 'package:meras1/screen/tranee/navDrawertranee.dart';

class TRhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawertranee(),
      appBar: AppBar(
        title: Text('الصفحة الرئيسية'),
        backgroundColor: Colors.deepPurple[100],
      ),
    );
  }
}
