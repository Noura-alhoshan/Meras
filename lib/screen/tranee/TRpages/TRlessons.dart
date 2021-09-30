import 'package:flutter/material.dart';
import 'package:meras1/screen/tranee/navDrawertranee.dart';

class TRlessons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawertranee(),
      appBar: AppBar(
        title: Text('قائمة الدروس الحالية'),
        backgroundColor: Colors.deepPurple[100],
      ),
    );
  }
}
