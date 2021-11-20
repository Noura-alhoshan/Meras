import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:meras/components/adminRounded_button.dart';
import 'package:meras/constants.dart';
import 'package:meras/controllers/MyUser.dart';
import 'package:meras/screen/Trainee/TRpages/TRguidelines.dart';
import 'package:meras/screen/Trainee/TRpages/TRny.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/services/auth.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'package:provider/provider.dart';
import 'package:meras/screen/authenticate/background2.dart';

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
        title: Text('                 الصفحة الرئيسية'),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: SingleChildScrollView(
        child: Background(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50.0),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('Coach')
                      .where('ID',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.data!.docs.isEmpty) return Container();
                    return Text(
                        'أهلًا بك ${snapshot.data!.docs[0].data()['Fname'] ?? ''} في مِـرَاس',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: kPrimaryColor,
                        ));
                  }),

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

              // SizedBox(height: 50.0),
              // SizedBox(height: 50.0),
              // SizedBox(height: 40.0),
              // Center(
              //   child:
              //       RoundedButtonAdmin(text: 'إرشادات القيادة', press: () {}),

              // ),
              // RoundedButtonAdmin(text: 'اختبر معلوماتك', press: () {}),

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
              SizedBox(height: 20.0),
              // SizedBox(height: 20.0),
              // SizedBox(height: 20.0),
              // Transform.scale(
              //   scale: 11.0,
              //   child: IconButton(
              //     onPressed: () {},
              //     icon: new Image.asset('assets/images/trafficsigns.png'),
              //   ),
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: TextButton(
                    onPressed: () {
                      Get.to(TRguidelines());
                    },
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(120, 80)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurple[50])),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'إشارات السير ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 30),
                        Image.asset('assets/icons/SteeringWheel1.png',
                            width: 60, height: 60)
                      ],
                    )),
              ),
              // SizedBox(height: 1),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(120, 80)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurple[50])),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('اختبر معلوماتك',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.w500)),
                        SizedBox(width: 30),
                        Image.asset('assets/icons/Test1.png',
                            width: 60, height: 60)
                      ],
                    )),
              ),

              // SizedBox(height: 40.0),
              // SizedBox(height: 40.0),
              // SizedBox(height: 40.0),
              // SizedBox(height: 40.0),
              // SizedBox(height: 20.0),
              // Transform.scale(
              //   scale: 11.0,
              //   child: IconButton(
              //     onPressed: () {},
              //     icon: new Image.asset('assets/images/test2.png'),
              //   ),
              // ),
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
