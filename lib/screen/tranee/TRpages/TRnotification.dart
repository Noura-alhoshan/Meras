import 'package:flutter/material.dart';
import 'package:meras1/screen/tranee/navDrawertranee.dart';

class TRnotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawertranee(),
      appBar: AppBar(
        title: Text('التنبيهات'),
        backgroundColor: Colors.deepPurple[100],
      ),
    );
  }
}
