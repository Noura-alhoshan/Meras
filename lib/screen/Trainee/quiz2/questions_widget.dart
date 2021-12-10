import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meras/constants.dart';
import 'package:meras/screen/Admin/services/BaseAlertDialog.dart';
import 'package:meras/screen/Admin/widget/FullScreen.dart';
import 'package:meras/screen/Trainee/quiz2/Score.dart';
import 'package:meras/screen/Trainee/quiz2/category_page.dart';
import 'package:meras/screen/Trainee/quiz2/challenge_controller.dart';
import 'package:meras/screen/Trainee/quiz2/option.dart';
import 'package:meras/screen/Trainee/quiz2/options_widget.dart';
import 'package:meras/screen/Trainee/quiz2/question.dart';
import 'package:meras/screen/Trainee/quiz2/questions.dart';

class QuestionsWidget extends StatefulWidget {
  final PageController controller;
  final ValueChanged<int> onChangedPage;
  final ValueChanged<Option> onClickedOption;
  final challengeController = ChallengeController();
  _QuestionsWidgetState createState() => new _QuestionsWidgetState();

  QuestionsWidget({
    // Key key,
    //  required this.category,
    required this.controller,
    required this.onChangedPage,
    required this.onClickedOption,
  }); // : super(key: key);
}
// void initState() {
//   controller.addListener(() {
//    challengeController.currentPage = controller.page!.toInt() + 1;
//  });

//  initState();
// }

class _QuestionsWidgetState extends State<QuestionsWidget> {
  int a = 0;

  @override
  Widget build(BuildContext context) => PageView.builder(
        onPageChanged: widget.onChangedPage,
        controller: widget.controller,
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
                child: ImageFullScreenWrapperWidget(
                  child: Image.network(
                    question.text,
                    height: 120.0,
                    width: 120.0,
                  ),
                  dark: false,
                )),

            SizedBox(height: 8),
            Container(
              alignment: Alignment.topRight,
              child: Text(
                question.textQ,
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: OptionsWidget(
                question: question,
                onClickedOption: widget.onClickedOption,
              ),
            ),
            // /*
            //  if (controller.page == 1)

            if (a != 0)
              if (widget.controller.page!.toInt() + 1 < questions.length)
                // if (challengeController.currentPage < questions.length)
                TextButton(
                    onPressed: () {
                      setState(() {
                        a = 200;
                      });

                      widget.controller
                          .jumpToPage(widget.controller.page!.toInt() + 1);
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
                          'السؤال التالي',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))
              else
                TextButton(
                    onPressed: () {
                      var baseDialog = BaseAlertDialog(
                          title: "",
                          content: "هل أنت متأكد من إنهاء الأختبار؟",
                          yesOnPressed: () async {
                            //
                            widget.controller.jumpToPage(
                                widget.controller.page!.toInt() + 1);
                            // controller.dispose();

                            Get.to(ScoreScreen());
                            //controller.dispose();
                            // Navigator.of(context, rootNavigator: true)
                            //     .pop('dialog');
                          },
                          noOnPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                          },
                          yes: "نعم",
                          no: "لا");
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => baseDialog);
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
                      ],
                    )),
            if (a == 0)
              TextButton(
                  onPressed: () {
                    setState(() {
                      a = 200;
                    });

                    widget.controller
                        .jumpToPage(widget.controller.page!.toInt() + 1);
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
                        'السؤال التالي',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ))

            // */
          ],
        ),
      );
}
