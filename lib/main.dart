import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meras1/Coachlist.dart';
import 'package:meras1/Dashboard.dart';
import 'package:meras1/Test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => LoginScreen(),
      '/dashboard': (context) => DashboardScreen(),
      '/Test': (context) => TestScreen(),
      '/coachlist': (context) => CoachlistScreen(),
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
                  child: Text('PENDING CHOACH LIST'),
                  onPressed: () {
                    nav();
                  },
                  color: Colors.white,
                ),
                FlatButton(
                  child: Text('ACCEPTED CHACH LIST'),
                  onPressed: () {
                    nav2();
                  },
                  color: Colors.white,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  child: Text('TEST'),
                  onPressed: () {
                    nav1();
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

  void nav1() async {
    Navigator.pushNamed(context, '/Test'); //nn
  }

  void nav() async {
    Navigator.pushNamed(context, '/dashboard'); //nn
  }

  void nav2() async {
    Navigator.pushNamed(context, '/coachlist'); //nn
  }
}
//
