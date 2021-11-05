import 'package:flutter/material.dart';
import 'package:meras/components/adminRounded_button.dart';
import 'package:meras/screen/Admin/services/navDraweradmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../constants.dart';

class ADhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDraweradmin(),
      appBar: AppBar(
        title: Center(child: Text('الصفحة الرئيسية')),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 50.0),
          SizedBox(height: 50.0),
          SizedBox(height: 40.0),
          Text(
            '                       ،أهلاً بك',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: kPrimaryColor,
            ),
          ),
          Center(
            child:
                RoundedButtonAdmin(text: 'إدارة الإختبار القصير', press: () {}),
          ),
          RoundedButtonAdmin(text: 'إدارة معلومات إشارات السير', press: () {}),
          // RoundedButtonAdmin(
          //     text: 'إضافة اختبار قصير',
          //     press: (){}
          // ),
        ],
      ),
    );
  }
}
