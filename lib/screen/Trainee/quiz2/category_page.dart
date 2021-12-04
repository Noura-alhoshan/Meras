import 'package:flutter/material.dart';
import 'package:meras/screen/Trainee/quiz/welcome_screen.dart';
import 'package:meras/screen/Trainee/quiz2/Score.dart';
import 'package:meras/screen/Trainee/quiz2/category.dart';
import 'package:meras/screen/Trainee/quiz2/option.dart';
import 'package:meras/screen/Trainee/quiz2/question.dart';
import 'package:meras/screen/Trainee/quiz2/question_numbers_widget.dart';
import 'package:meras/screen/Trainee/quiz2/questions_widget.dart';
import 'package:get/get.dart';

class CategoryPage extends StatefulWidget {
  //  static int score = 0;
  static int score = 0;

  final Category category;

  const CategoryPage({required this.category});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  //static int score = 0;

  late PageController controller;
  late Question question;

  @override
  void initState() {
    super.initState();

    controller = PageController();
    question = widget.category.questions.first;
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
                questions: widget.category.questions,
                question: question,
                onClickedNumber: (index) =>
                    nextQuestion(index: index, jump: true),
              ),
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                color: Colors.white,
                onPressed: () {
                  Get.to(ScoreScreen());
                }),
            SizedBox(width: 16),
          ],
        ),
        body: QuestionsWidget(
          category: widget.category,
          controller: controller,
          onChangedPage: (index) => nextQuestion(index: index),
          onClickedOption: selectOption,
        ),
      );

/*
  Widget buildAppBar(context) => AppBar(
        title: Text(widget.category.categoryName),
        actions: [
          Icon(Icons.filter_alt_outlined),
          SizedBox(width: 16),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.purple],
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
              questions: widget.category.questions,
              question: question,
              onClickedNumber: (index) =>
                  nextQuestion(index: index, jump: true),
            ),
          ),
        ),
      );
*/
  void selectOption(Option option) {
    if (question.isLocked) {
      return;
    } else {
      setState(() {
        question.isLocked = true;
        question.selectedOption = option;
        if (option == question.selectedOption) {
          CategoryPage.score++;
        }
      });
    }
  }

  void nextQuestion({required int index, bool jump = false}) {
    final nextPage = controller.page! + 1;
    final indexPage = index;

    setState(() {
      question = widget.category.questions[indexPage];
    });

    if (jump) {
      controller.jumpToPage(indexPage);
    }
  }
}
