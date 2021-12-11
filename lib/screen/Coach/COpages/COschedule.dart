import 'package:flutter/material.dart';
import 'package:meras/screen/home/CnavDrawer.dart';
import 'package:meras/screen/home/navDrawer.dart';

class COschedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: CNavDrawer(),
      appBar: AppBar(
        title: Text('المواعيد'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade100, Colors.deepPurple.shade200],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
      ),
    );
  }
}
