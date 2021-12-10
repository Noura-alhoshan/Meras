import 'package:flutter/material.dart';
import 'package:meras/screen/Trainee/quiz2/option.dart';
import 'package:meras/screen/Trainee/quiz2/question.dart';
import 'package:meras/screen/Trainee/quiz2/utils.dart';

class OptionsWidget extends StatefulWidget {
  final Question question;
  final ValueChanged<Option> onClickedOption;
  static bool isSelected = false;
/////*
  const OptionsWidget({
    //Key key,

    required this.question,
    required this.onClickedOption,
  }); // : super(key: key);
//*/
  _OptionsWidgetState createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
  @override
  Widget build(BuildContext context) => ListView(
        physics: BouncingScrollPhysics(),
        children: Utils.heightBetween(
          widget.question.options
              .map((option) => buildOption(context, option))
              .toList(),
          height: 8,
        ),
      );

  Widget buildOption(BuildContext context, Option option) {
    final color = getColorForOption(option, widget.question);

    return GestureDetector(
      onTap: () => widget.onClickedOption(option),
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
          new Spacer(),
          Text(
            option.text,
            style: TextStyle(fontSize: 17),
          ),
          Text(
            '   ',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(width: 12),
          Text(
            option.code,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
          ),
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
    setState(() {
      OptionsWidget.isSelected = option == question.selectedOption;
    });
    if (!question.isLocked) return Colors.grey.shade200;
    if (!OptionsWidget.isSelected) {
      return Colors.grey.shade200;
    } else {
      return option.isCorrect ? Colors.green : Colors.red;
    }
  }
}
