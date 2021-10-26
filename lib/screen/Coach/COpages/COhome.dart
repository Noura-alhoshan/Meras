import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meras/constants.dart';
import 'package:meras/controllers/MyUser.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/services/auth.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'package:provider/provider.dart';
import 'package:meras/screen/authenticate/background2.dart';

//this home page will be edited to fit our app, this one is just for testing ^_^

// CollectionReference firevar = FirebaseFirestore.instance.collection('users');

class COhome extends StatefulWidget {
  COhome();

  AuthService aut = AuthService();
  //final String? userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<COhome> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    // FirebaseAuth auth = FirebaseAuth.instance;
    // User? user = auth.currentUser;
    // dynamic userid = user!.uid;

    //print(userid+" hello there");//first user only

    //print(widget.userId);//updated
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        //title: Text('Side menu'),
        backgroundColor: Colors.deepPurple[100],
        //backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Background(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50.0),
              Text(
                'أهلًا بك في مِـرَاس',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'مِرَاس يقدم لك تجربة فريدة من نوعها في تعلّم وتعليم القيادة' +
                    '!',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
              Text(
                ' يتيح مِرَاس للمتعلمين سهولة اختيار مدرّبيهم في اليوم والوقت الذي' +
                    ' يريدونه، ويتيح للمدرّبين سهولة الوصول للمتعلمين  ',
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
              SizedBox(height: 20.0),
              Text(
                'مِرَاس حيث سهولة التعلّم',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black),
              ),
              //SizedBox(height: 20.0),
              // RoundedHomeButton(
              //     text: 'إشارات السير',
              //     press: (){}
              //     ),
              // SizedBox(height: 10.0),
              // RoundedHomeButton(
              //     text: 'text',
              //     press: (){}
              // ),
              // IconButton(
              //   icon: Image.asset('assets/images/trafficsigns.png'),
              //   iconSize: 350,
              //   onPressed: () {},
              // ),
              SizedBox(height: 50.0),
              SizedBox(height: 20.0),
              SizedBox(height: 20.0),
              Transform.scale(
                scale: 11.0,
                child: IconButton(
                  onPressed: () {},
                  icon: new Image.asset('assets/images/trafficsigns.png'),
                ),
              ),
              SizedBox(height: 40.0),
              SizedBox(height: 40.0),
              SizedBox(height: 40.0),
              SizedBox(height: 40.0),
              SizedBox(height: 20.0),
              Transform.scale(
                scale: 11.0,
                child: IconButton(
                  onPressed: () {},
                  icon: new Image.asset('assets/images/test2.png'),
                ),
              ),
              // IconButton(
              //   icon: Image.asset('assets/images/test2.png'),
              //   iconSize: 350,
              //   onPressed: () {},
              // ),
              SizedBox(height: 40.0),
              SizedBox(height: 50.0),
              SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
