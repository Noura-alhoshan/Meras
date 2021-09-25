//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TEST PAGE'),
        backgroundColor: Colors.deepPurple[400],
      ),
      body: Container(
        color: Colors.purple[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(
              ' TEST TEST',
              style: TextStyle(fontSize: 35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ],
        ),
      ),
    );
  }
}
