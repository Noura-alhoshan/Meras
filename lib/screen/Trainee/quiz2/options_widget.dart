import 'package:flutter/material.dart';
import 'package:meras/screen/Trainee/quiz2/option.dart';
import 'package:meras/screen/Trainee/quiz2/question.dart';
import 'package:meras/screen/Trainee/quiz2/utils.dart';

class OptionsWidget extends StatelessWidget {
  static int score = 0;
  final Question question;
  final ValueChanged<Option> onClickedOption;

  OptionsWidget({
    //Key key,

    required this.question,
    required this.onClickedOption,
  }); // : super(key: key);
  @override
  Widget build(BuildContext context) => ListView(
        physics: BouncingScrollPhysics(),
        children: Utils.heightBetween(
          question.options
              .map((option) => buildOption(context, option))
              .toList(),
          height: 8,
        ),
      );

  Widget buildOption(BuildContext context, Option option) {
    final color = getColorForOption(option, question);
    getscore(option, question);

    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            buildAnswer(option),
            // buildSolution(question.selectedOption, option),
          ],
        ),
      ),
    );
  }

  Widget buildAnswer(Option option) => Container(
        height: 50,
        child: Row(children: [
          Text(
            option.code,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(width: 12),
          Text(
            option.text,
            style: TextStyle(fontSize: 20),
          )
        ]),
      );

  //Widget buildSolution(Option solution, Option answer) {
  //   if (solution == answer) {
  //   return Text(
  ///       question.solution,
  //     style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
  //   );
  //  } else {
  //   return Container();
  // }
  /// }

  Color getColorForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;

    if (!isSelected) {
      return Colors.grey.shade200;
    } else {
      return option.isCorrect ? Colors.green : Colors.red;
    }
  }

  void getscore(Option option, Question question) {
    print(" score is   " + score.toString());
    final isSelected = option == question.selectedOption;
    if (question.isLocked == false) {
      if (!isSelected) {
        score++;
      } else {}
    }
  }
}
