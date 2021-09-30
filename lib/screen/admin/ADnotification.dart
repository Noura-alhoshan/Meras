import 'package:flutter/material.dart';
import 'package:meras1/screen/admin/navDraweradmin.dart';

class ADnotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDraweradmin(),
      appBar: AppBar(
        title: Text('التنبيهات'),
        backgroundColor: Colors.deepPurple[100],
      ),
    );
  }
}
