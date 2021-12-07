import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:quiz_app/constants.dart';
//import 'package:quiz_app/controllers/question_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meras/screen/Trainee/TRpages/TRhome.dart';
import 'package:meras/screen/Trainee/quiz2/category_page.dart';
import 'package:meras/screen/Trainee/quiz2/options_widget.dart';

//import 'question_controller.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  OptionsWidget _qnController = Get.put(OptionsWidget());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          //  SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.blue),
              ),
              Spacer(),
              Text(
                CategoryPage.score.toString(),
                //  "${_qnController.correctAns * 10}/${_qnController.questions.length * 10}",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.amber),
              ),
              Spacer(flex: 3),
              TextButton(
                  onPressed: () {
                    Get.to(TRhome());
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
                      Text('العودة لصفحة الرئيسية',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w500)),
                      SizedBox(width: 30),
                      Image.asset('assets/icons/Test1.png',
                          width: 60, height: 60)
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
