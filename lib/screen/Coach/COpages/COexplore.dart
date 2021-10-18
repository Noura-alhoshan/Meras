import 'package:flutter/material.dart';
import 'package:meras/screen/home/navDrawer.dart';

class COexplore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('صفحة البحث'),
        backgroundColor: Colors.deepPurple[100],
      ),
    );
  }
}
