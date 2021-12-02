import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:quiz_app/constants.dart';
//import 'package:quiz_app/controllers/question_controller.dart';
import 'package:flutter_svg/svg.dart';

import 'question_controller.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
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
                "${_qnController.correctAns * 10}/${_qnController.questions.length * 10}",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.amber),
              ),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}
