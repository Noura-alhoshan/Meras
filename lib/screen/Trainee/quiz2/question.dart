import 'package:flutter/cupertino.dart';

import 'option.dart';

class Question {
  final String text;
  final String textQ;
  final List<Option> options;
  // final String solution;
  bool isLocked;
  //bool restart;

  Option selectedOption;

  Question({
    required this.text,
    required this.textQ,
    required this.options,
    //  required this.solution,
    this.isLocked = false,
    // this.restart = false,
    required this.selectedOption,
  });
}
