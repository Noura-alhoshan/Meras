import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:meras/components/adminRounded_button.dart';
import 'package:meras/constants.dart';
import 'package:meras/controllers/MyUser.dart';
import 'package:meras/screen/Trainee/TRpages/TRgeneral.dart';
import 'package:meras/screen/Trainee/TRpages/TRny.dart';
import 'package:meras/screen/Trainee/TRpages/TRwarning.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/services/auth.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'package:provider/provider.dart';
import 'package:meras/screen/authenticate/background2.dart';

class TRguidelines extends StatefulWidget {
  AuthService aut = AuthService();
  //final String? userId;
  @override
  State<StatefulWidget> createState() => new _TRguidelines();
}

class _TRguidelines extends State<TRguidelines> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('إرشادات القيادة')),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: SingleChildScrollView(
        child: Background(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Get.to(TRgeneral());
                },
                child: Container(
                  height: 120,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Card(
                    elevation: 6,
                    shadowColor: Colors.deepPurple[500],
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: Colors.white, width: 1)),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 8,
                            child: SizedBox.expand(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "الإشارات العامة",
                                    style: TextStyle(height: 2.5, fontSize: 25),
                                    // maxLines: 1,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Image.asset(
                                  'assets/icons/TrafficLight.png',
                                  width: 70,
                                  height: 70),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(TRwarning());
                },
                child: Container(
                  height: 120,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Card(
                    elevation: 6,
                    shadowColor: Colors.deepPurple[500],
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: Colors.white, width: 1)),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 8,
                            child: SizedBox.expand(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "الإشارات التحذيرية",
                                    style: TextStyle(height: 2.5, fontSize: 25),
                                    // maxLines: 1,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Image.asset('assets/icons/Warning.png',
                                  width: 70, height: 70),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(TRny());
                },
                child: Container(
                  height: 120,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Card(
                    elevation: 6,
                    shadowColor: Colors.deepPurple[500],
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: Colors.white, width: 1)),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 8,
                            child: SizedBox.expand(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "الإشارات التنظيمية",
                                    style: TextStyle(height: 2.5, fontSize: 25),
                                    // maxLines: 1,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Image.asset('assets/icons/X.png',
                                  width: 70, height: 70),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
