import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/home/BaseAlertDialog.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'SendRequest.dart';

class RequestLessonPage extends StatefulWidget {
  RequestLessonPage(String icd);

  //const RequestLessonPage({ Key? key }) : super(key: key);

  @override
  _RequestLessonPageState createState() => _RequestLessonPageState();
}

class _RequestLessonPageState extends State<RequestLessonPage> {
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // CollectionReference req = FirebaseFirestore.instance.collection('Requests');

  @override
  Widget build(BuildContext context) {
    // final User? user = auth.currentUser;
    // final uid = user!.uid;

    return Scaffold(
      //extendBodyBehindAppBar: true,
      //drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('حجز درس جديد'
            // textAlign: TextAlign.center,
            ),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Container(
        child: BackgroundA(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5)),

                //coach information

                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5)),

                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'المواعيد المتاحة خلال الأسبوع القادم',
                    style: TextStyle(height: 2, fontSize: 13),
                    textAlign: TextAlign.right,
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
