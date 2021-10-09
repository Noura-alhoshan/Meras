import 'package:flutter/material.dart';
import 'package:meras/screen/Admin/services/navDraweradmin.dart';

class ADhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDraweradmin(),
      appBar: AppBar(
        title: Text('الصفحة الرئيسية'),
        backgroundColor: Colors.deepPurple[100],
      ),
    );
  }
}
