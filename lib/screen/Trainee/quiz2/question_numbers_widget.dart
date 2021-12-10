import 'package:flutter/material.dart';
import 'package:meras/screen/Trainee/quiz2/question.dart';

class QuestionNumbersWidget extends StatelessWidget {
  final List<Question> questions;
  final Question question;
  final ValueChanged<int> onClickedNumber;

  const QuestionNumbersWidget({
    // Key key,
    required this.questions,
    required this.question,
    required this.onClickedNumber,
  }); //: super(key: key);

  @override
  Widget build(BuildContext context) {
    final double padding = 16;

    return Container(
      height: 50,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: padding),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => Container(width: padding),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final isSelected = question == questions[index];
          final isanswered = questions[index].isLocked;

          return buildNumber(
              index: index, isSelected: isSelected, isAnswered: isanswered);
        },
      ),
    );
  }

  Widget buildNumber({
    required int index,
    required bool isSelected,
    required bool isAnswered,
  }) {
    return GestureDetector(
      onTap: () => onClickedNumber(index),
      child: CircleAvatar(
        backgroundColor: isAnswered
            ? isSelected
                ? Colors.orange.shade300
                : Colors.green.shade300
            : isSelected
                ? Colors.orange.shade300
                : Colors.white,
        child: Text(
          '${index + 1}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
