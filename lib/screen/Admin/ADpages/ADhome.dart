import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meras/components/adminRounded_button.dart';
import 'package:meras/screen/Admin/ADpages/manageGuidlines.dart';
import 'package:meras/screen/Admin/services/navDraweradmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/authenticate/background.dart';

import '../../../constants.dart';
import 'ManageTest.dart';

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
        body: SingleChildScrollView(
            child: Background(
          child: Column(
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
                child: Container(
                  width: 350,
                  height: 90,
                  padding: EdgeInsets.all(10),
                  decoration: new BoxDecoration(
                    color: Colors.deepPurple[50],
                    border: Border.all(color: Colors.white, width: 0.0),
                    borderRadius: new BorderRadius.all(Radius.circular(29.0)),
                  ),
                  child: Center(
                    child: FlatButton(
                      onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ManageGuidlines()))
                      },
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "إدارة معلومات إشارات السير     ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.directions_car_rounded,
                              color: kPrimaryColor,
                              size: 23,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Container(
                  width: 350,
                  height: 90,
                  padding: EdgeInsets.all(10),
                  decoration: new BoxDecoration(
                    color: Colors.deepPurple[50],
                    border: Border.all(color: Colors.white, width: 0.0),
                    borderRadius: new BorderRadius.all(Radius.circular(29.0)),
                  ),
                  child: Center(
                    child: FlatButton(
                      onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ManageTest()))
                      },
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "إدارة الاختبار القصير  ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.text_snippet,
                              color: kPrimaryColor,
                              size: 23,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
