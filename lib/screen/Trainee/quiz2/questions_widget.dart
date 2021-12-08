import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meras/constants.dart';
import 'package:meras/screen/Trainee/quiz2/Score.dart';
import 'package:meras/screen/Trainee/quiz2/challenge_controller.dart';
import 'package:meras/screen/Trainee/quiz2/option.dart';
import 'package:meras/screen/Trainee/quiz2/options_widget.dart';
import 'package:meras/screen/Trainee/quiz2/question.dart';
import 'package:meras/screen/Trainee/quiz2/questions.dart';

class QuestionsWidget extends StatelessWidget {
  // final Category category;
  final PageController controller;
  final ValueChanged<int> onChangedPage;
  final ValueChanged<Option> onClickedOption;
  final challengeController = ChallengeController();

  void initState() {
    controller.addListener(() {
      challengeController.currentPage = controller.page!.toInt() + 1;
    });

    initState();
  }

  QuestionsWidget({
    // Key key,
    //  required this.category,
    required this.controller,
    required this.onChangedPage,
    required this.onClickedOption,
  }); // : super(key: key);

  @override
  Widget build(BuildContext context) => PageView.builder(
        onPageChanged: onChangedPage,
        controller: controller,
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];

          return buildQuestion(question: question);
        },
      );

  Widget buildQuestion({
    required Question question,
  }) =>
      Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 32),
            Container(
              alignment: Alignment.center,
              child: Image.network(
                question.text,
                height: 120.0,
                width: 120.0,
              ),
            ),
            //
            //
            //   Text(
            //  question.text,
            //    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            //  ),
            SizedBox(height: 8),
            Container(
              alignment: Alignment.topRight,
              child: Text(
                'أختر معنى الصورة الصحيح',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: OptionsWidget(
                question: question,
                onClickedOption: onClickedOption,
              ),
            ),
            // /*
            if (controller.page!.toInt() + 1 < questions.length)
              // if (challengeController.currentPage < questions.length)
              TextButton(
                  onPressed: () {
                    controller.jumpToPage(controller.page!.toInt() + 1);
                    //Get.to(ScoreScreen());
                  },
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(100, 50)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(29))),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepPurple[50])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'السؤال التالي' + controller.page!.toInt().toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      //    SizedBox(width: 30),
                      //  Image.asset('assets/icons/SteeringWheel1.png',
                      //       width: 60, height: 60)
                    ],
                  ))
            else
              TextButton(
                  onPressed: () {
                    controller.jumpToPage(controller.page!.toInt() + 1);
                    Get.to(ScoreScreen());
                    //   controller.dispose();
                  },
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(100, 50)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(29))),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepPurple[50])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'إنهاء الأختبار ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      //    SizedBox(width: 30),
                      //  Image.asset('assets/icons/SteeringWheel1.png',
                      //       width: 60, height: 60)
                    ],
                  ))
            // */
          ],
        ),
      );
}
