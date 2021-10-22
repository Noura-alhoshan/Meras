import 'package:flutter/material.dart';
import 'package:meras/screen/home/navDrawer.dart';

class COlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('الطلبات'),
        backgroundColor: Colors.deepPurple[100],
      ),
    );
  }
}
