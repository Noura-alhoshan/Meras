import 'package:flutter/material.dart';
import 'package:meras/screen/home/navDrawer.dart';

class COschedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('المواعيد'),
        backgroundColor: Colors.deepPurple[100],
      ),
    );
  }
}
