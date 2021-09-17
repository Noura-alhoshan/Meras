import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meras1/Dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => LoginScreen(),
      '/dashboard': (context) => DashboardScreen(),
    },
  ));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  child: Text('nav'),
                  onPressed: () {
                    nav();
                  },
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void nav() async {
    Navigator.pushNamed(context, '/dashboard'); //nn
  }
}
//
