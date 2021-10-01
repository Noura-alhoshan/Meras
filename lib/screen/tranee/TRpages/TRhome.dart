import 'package:flutter/material.dart';
import 'package:meras1/screen/home/navDrawer.dart';

class TRhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('الصفحة الرئيسية'),
        backgroundColor: Colors.deepPurple[100],
      ),
    );
  }
}
