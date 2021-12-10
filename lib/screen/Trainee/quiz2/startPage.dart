import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meras/constants.dart';
import 'package:meras/screen/Trainee/quiz2/category_page.dart';
import 'package:meras/screen/Trainee/quiz2/questions.dart';
import 'package:meras/screen/Trainee/quiz2/questionModel.dart';
import 'package:meras/screen/authenticate/background.dart';

class test2 extends StatefulWidget {
  static List allResults = [];

  @override
  test2State createState() => test2State();
}

class test2State extends State<test2> {
  late Future resultsLoaded;
  //static List _allResults = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getUsersPastTripsStreamSnapshots();
  }

  getUsersPastTripsStreamSnapshots() async {
    var data = await FirebaseFirestore.instance.collection("Questions").get();
    setState(() {
      test2.allResults = data.docs;
    });
    return "complete";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("               صفحة الأختبار"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.shade100,
                  Colors.deepPurple.shade200
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
        ),
        body: Container(
          child: Background(
            child: Column(
              children: <Widget>[
                if (test2.allResults.length ==
                    9) ///////////////////////////////////////////
                  Container(
                      child: Column(children: <Widget>[
                    //////////////// here to manage the minumm limit
                    SizedBox(height: 90.0),
                    Image.asset(
                      "assets/images/Quiz1.png",
                      height: 250,
                    ),
                    /*
                   Text('أهلًا بك ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: kPrimaryColor,
                    )),*/

                    SizedBox(height: 20.0),
                    Text(
                      ' الأختبار يتكون من 10 اسئلة ولا يمكنك تغيير الأجابة ',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17, color: Colors.black),
                    ),

                    //  SizedBox(height: 20.0),
                    /*
                    Text(
                    'مِرَاس حيث سهولة التعلّم',
                   textAlign: TextAlign.right,
                   style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black),
                  ),*/
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      child: Column(
                        children: [
                          //   if (test2.allResults.length < 9) //////////////// here to manage the minumm limit
                          TextButton(
                              onPressed: () {
                                //CategoryPage.score = 0;
                                //

                                // test2.allResults = [];
                                Get.to(CategoryPage(questions: questions));
                              },
                              style: ButtonStyle(
                                  minimumSize:
                                      MaterialStateProperty.all(Size(120, 60)),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(29))),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.deepPurple[50])),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '         بدء الأختبار',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 30),
                                  //  Image.asset('assets/icons/SteeringWheel1.png',
                                  //        width: 60, height: 60)
                                ],
                              )),
                        ],
                      ),
                    ),
                  ]))
                else
                  Container(
                      child: Column(children: <Widget>[
                    //////////////// here to manage the minumm limit
                    SizedBox(height: 150.0),
                    Image.asset(
                      "assets/images/Quiz2.png",
                      height: 250,
                    ),
                    /*
                   Text('أهلًا بك ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: kPrimaryColor,
                    )),*/

                    SizedBox(height: 20.0),
                    Text(
                      'الأختبار غير متوفر حالياً، سيتم إضافته قريباً ',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                    ),
                  ])), //   SizedBox(height: 40.0),
                SizedBox(height: 50.0),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ));
  }
}
