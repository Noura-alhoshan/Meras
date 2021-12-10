import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:meras/screen/Trainee/quiz2/option.dart';
import 'package:meras/screen/Trainee/quiz2/question.dart';
import 'package:meras/screen/Trainee/quiz2/question_numbers_widget.dart';
import 'package:meras/screen/Trainee/quiz2/questions_widget.dart';
import 'package:get/get.dart';

class CategoryPage extends StatefulWidget {
  //static bool restart = false;

  static int score = 0;
  final List<Question> questions;

  const CategoryPage({required this.questions});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  //static int score = 0;

  late PageController controller;
  late Question question;
  late Future resultsLoaded;

  @override
  void initState() {
    super.initState();

    controller = PageController();
    question = widget.questions.first;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('            اختبار القيادة النظري     '),
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: QuestionNumbersWidget(
                questions: widget.questions,
                question: question,
                onClickedNumber: (index) =>
                    nextQuestion(index: index, jump: true),
              ),
            ),
          ),
          actions: [
            //  TextButton(
            //        icon: Icon(Icons.settings),
            //       color: Colors.white,
            //       onPressed: () {
            //       Get.to(ScoreScreen());
            //      }),
            SizedBox(width: 16),
          ],
        ),
        body: QuestionsWidget(
//category: widget.category,
          controller: controller,
          onChangedPage: (index) => nextQuestion(index: index),
          onClickedOption: selectOption,
        ),
        /*
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[300],
          onPressed: () {
            // go to next page
            QuestionsWidget(
              category: widget.category,
              controller: controller,
              onChangedPage: (index) => nextQuestion1(index: index),
              onClickedOption: selectOption,
            );
          },
          tooltip: 'Next Page',
          child: const Icon(Icons.skip_next_rounded),
        ),
        */
      );

  void selectOption(Option option) {
    if (question.isLocked) {
      return;
    } else {
      setState(() {
        question.isLocked = true;
        question.selectedOption = option;
        if (option.isCorrect) {
          CategoryPage.score++;
        }
      });
    }
    // if (CategoryPage.restart) {
    //   setState(() {
    //     question.isLocked = false;
    //    question.selectedOption = option;
    // CategoryPage.restart = false;
    //  });
    //}
  }

  void nextQuestion({required int index, bool jump = false}) {
    final nextPage = controller.page! + 1;
    final indexPage = index;

    setState(() {
      question = widget.questions[indexPage];
    });

    if (jump) {
      controller.jumpToPage(indexPage);
    }
  }

  void nextQuestion1({required int index, bool jump = false}) {
    final nextPage = controller.page!.toInt() + 1;
    final indexPage = index;

    setState(() {
      question = widget.questions[nextPage];
    });

    if (jump) {
      controller.jumpToPage(indexPage);
    }
  }
}
