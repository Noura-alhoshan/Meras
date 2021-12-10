import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:quiz_app/constants.dart';
//import 'package:quiz_app/controllers/question_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meras/constants.dart';
import 'package:meras/screen/Trainee/TRcategory.dart';
import 'package:meras/screen/Trainee/TRpages/TRhome.dart';
import 'package:meras/screen/Trainee/quiz2/category_page.dart';
import 'package:meras/screen/Trainee/quiz2/options_widget.dart';
import 'package:meras/screen/Trainee/quiz2/question.dart';
import 'package:meras/screen/Trainee/quiz2/questions.dart';
import 'package:meras/screen/Trainee/quiz2/startPage.dart';
import 'package:meras/screen/authenticate/background.dart';

//import 'question_controller.dart';

class ScoreScreen extends StatefulWidget {
  State<StatefulWidget> createState() => new _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Background(
        child: Column(
          children: <Widget>[
            //      SizedBox(height: 200.0),
            SizedBox(height: 150.0),
            Image.asset(
              "assets/images/score.png",
              height: 250,
            ),
            SizedBox(height: 10.0),

            Text('نتيجة الأختبار ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: kPrimaryColor,
                )),
            SizedBox(height: 10.0),
            // SizedBox(height: 20.0),
            Text(
              CategoryPage.score.toString() + '0' + '/' + '100',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      //       CategoryPage.restart = true;
                      //  Question.restart = true;
                      //     OptionsWidget.re = false;
                      //  CategoryPage.score = 0;
                      //
                      //  test2.allResults = [];
                      //   option.
                    });
                    Get.to(TRcategory(
                      traineeId: '',
                    ));
                  },
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(120, 60)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(29))),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepPurple[50])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' العودة الى الصفحة الرئيسية',
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
            ),
            SizedBox(height: 40.0),
            SizedBox(height: 50.0),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    ));
  }
}
