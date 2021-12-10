import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meras/screen/Trainee/quiz2/category_page.dart';
import 'package:meras/screen/Trainee/quiz2/option.dart';
import 'package:meras/screen/Trainee/quiz2/question.dart';
import 'package:meras/screen/Trainee/quiz2/questionModel.dart';
import 'package:meras/screen/Trainee/quiz2/startPage.dart';

final questions = [
  Question(
    text: test.fromSnapshot(test2.allResults[1]).q,
    textQ: test.fromSnapshot(test2.allResults[1]).textQ,

    options: [
      Option(
          code: '.أ',
          text: test.fromSnapshot(test2.allResults[1]).mm['0'] == 'True'
              ? 'صح'
              : test.fromSnapshot(test2.allResults[1]).mm['0'] == 'False'
                  ? 'خطأ'
                  : test.fromSnapshot(test2.allResults[1]).mm['0'],
          isCorrect: test.fromSnapshot(test2.allResults[1]).mm['0'] ==
              test.fromSnapshot(test2.allResults[1]).o5),
      Option(
          code: '.ب',
          text: test.fromSnapshot(test2.allResults[1]).mm['1'] == 'True'
              ? 'صح'
              : test.fromSnapshot(test2.allResults[1]).mm['1'] == 'False'
                  ? 'خطأ'
                  : test.fromSnapshot(test2.allResults[1]).mm['1'],
          isCorrect: test.fromSnapshot(test2.allResults[1]).mm['1'] ==
              test.fromSnapshot(test2.allResults[1]).o5),
      Option(
          code: '.ج',
          text: test.fromSnapshot(test2.allResults[1]).mm['2'],
          isCorrect: test.fromSnapshot(test2.allResults[1]).mm['2'] ==
              test.fromSnapshot(test2.allResults[1]).o5),
      Option(
          code: '.د',
          text: test.fromSnapshot(test2.allResults[1]).mm['3'],
          isCorrect: test.fromSnapshot(test2.allResults[1]).mm['3'] ==
              test.fromSnapshot(test2.allResults[1]).o5),
    ],
    // solution: 'Venus is the hottest planet in the solar system',
    selectedOption: Option(code: 'A', text: '', isCorrect: false),
  ),
  Question(
      text: test.fromSnapshot(test2.allResults[0]).q,
      textQ: test.fromSnapshot(test2.allResults[0]).textQ,
      options: [
        Option(
            code: '.أ',
            text: test.fromSnapshot(test2.allResults[0]).mm['0'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[0]).mm['0'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[0]).mm['0'],
            isCorrect: test.fromSnapshot(test2.allResults[0]).mm['0'] ==
                test.fromSnapshot(test2.allResults[0]).o5),
        Option(
            code: '.ب',
            text: test.fromSnapshot(test2.allResults[0]).mm['1'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[0]).mm['1'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[0]).mm['1'],
            isCorrect: test.fromSnapshot(test2.allResults[0]).mm['1'] ==
                test.fromSnapshot(test2.allResults[0]).o5),
        Option(
            code: '.ج',
            text: test.fromSnapshot(test2.allResults[0]).mm['2'],
            isCorrect: test.fromSnapshot(test2.allResults[0]).mm['2'] ==
                test.fromSnapshot(test2.allResults[0]).o5),
        Option(
            code: '.د',
            text: test.fromSnapshot(test2.allResults[0]).mm['3'],
            isCorrect: test.fromSnapshot(test2.allResults[0]).mm['3'] ==
                test.fromSnapshot(test2.allResults[0]).o5),
      ],
      //solution: 'Ozone have 3 molecules of oxygen',
      selectedOption: Option(code: 'A', text: '', isCorrect: false)),
  Question(
      text: test.fromSnapshot(test2.allResults[2]).q,
      textQ: test.fromSnapshot(test2.allResults[2]).textQ,
      options: [
        Option(
            code: '.أ',
            text: test.fromSnapshot(test2.allResults[2]).mm['0'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[2]).mm['0'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[2]).mm['0'],
            isCorrect: test.fromSnapshot(test2.allResults[2]).mm['0'] ==
                test.fromSnapshot(test2.allResults[2]).o5),
        Option(
            code: '.ب',
            text: test.fromSnapshot(test2.allResults[2]).mm['1'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[2]).mm['1'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[2]).mm['1'],
            isCorrect: test.fromSnapshot(test2.allResults[2]).mm['1'] ==
                test.fromSnapshot(test2.allResults[2]).o5),
        Option(
            code: '.ج',
            text: test.fromSnapshot(test2.allResults[2]).mm['2'],
            isCorrect: test.fromSnapshot(test2.allResults[2]).mm['2'] ==
                test.fromSnapshot(test2.allResults[2]).o5),
        Option(
            code: '.د',
            text: test.fromSnapshot(test2.allResults[2]).mm['3'],
            isCorrect: test.fromSnapshot(test2.allResults[2]).mm['3'] ==
                test.fromSnapshot(test2.allResults[2]).o5),
      ],
      //solution: 'Ozone have 3 molecules of oxygen',
      selectedOption: Option(code: 'A', text: '', isCorrect: false)),
  Question(
      text: test.fromSnapshot(test2.allResults[3]).q,
      textQ: test.fromSnapshot(test2.allResults[3]).textQ,
      options: [
        Option(
            code: '.أ',
            text: test.fromSnapshot(test2.allResults[3]).mm['0'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[3]).mm['0'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[3]).mm['0'],
            isCorrect: test.fromSnapshot(test2.allResults[3]).mm['0'] ==
                test.fromSnapshot(test2.allResults[3]).o5),
        Option(
            code: '.ب',
            text: test.fromSnapshot(test2.allResults[3]).mm['1'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[3]).mm['1'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[3]).mm['1'],
            isCorrect: test.fromSnapshot(test2.allResults[3]).mm['1'] ==
                test.fromSnapshot(test2.allResults[3]).o5),
        Option(
            code: '.ج',
            text: test.fromSnapshot(test2.allResults[3]).mm['2'],
            isCorrect: test.fromSnapshot(test2.allResults[3]).mm['2'] ==
                test.fromSnapshot(test2.allResults[3]).o5),
        Option(
            code: '.د',
            text: test.fromSnapshot(test2.allResults[3]).mm['3'],
            isCorrect: test.fromSnapshot(test2.allResults[3]).mm['3'] ==
                test.fromSnapshot(test2.allResults[3]).o5),
      ],
      //solution: 'Ozone have 3 molecules of oxygen',
      selectedOption: Option(code: 'A', text: '', isCorrect: false)),
  Question(
      text: test.fromSnapshot(test2.allResults[4]).q,
      textQ: test.fromSnapshot(test2.allResults[4]).textQ,
      options: [
        Option(
            code: '.أ',
            text: test.fromSnapshot(test2.allResults[4]).mm['0'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[4]).mm['0'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[4]).mm['0'],
            isCorrect: test.fromSnapshot(test2.allResults[4]).mm['0'] ==
                test.fromSnapshot(test2.allResults[4]).o5),
        Option(
            code: '.ب',
            text: test.fromSnapshot(test2.allResults[4]).mm['1'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[4]).mm['1'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[4]).mm['1'],
            isCorrect: test.fromSnapshot(test2.allResults[4]).mm['1'] ==
                test.fromSnapshot(test2.allResults[4]).o5),
        Option(
            code: '.ج',
            text: test.fromSnapshot(test2.allResults[4]).mm['2'],
            isCorrect: test.fromSnapshot(test2.allResults[4]).mm['2'] ==
                test.fromSnapshot(test2.allResults[4]).o5),
        Option(
            code: '.د',
            text: test.fromSnapshot(test2.allResults[4]).mm['3'],
            isCorrect: test.fromSnapshot(test2.allResults[4]).mm['3'] ==
                test.fromSnapshot(test2.allResults[4]).o5),
      ],
      //solution: 'Ozone have 3 molecules of oxygen',
      selectedOption: Option(code: 'A', text: '', isCorrect: false)),
  Question(
      text: test.fromSnapshot(test2.allResults[5]).q,
      textQ: test.fromSnapshot(test2.allResults[5]).textQ,
      options: [
        Option(
            code: '.أ',
            text: test.fromSnapshot(test2.allResults[5]).mm['0'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[5]).mm['0'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[5]).mm['0'],
            isCorrect: test.fromSnapshot(test2.allResults[5]).mm['0'] ==
                test.fromSnapshot(test2.allResults[5]).o5),
        Option(
            code: '.ب',
            text: test.fromSnapshot(test2.allResults[5]).mm['1'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[5]).mm['1'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[5]).mm['1'],
            isCorrect: test.fromSnapshot(test2.allResults[5]).mm['1'] ==
                test.fromSnapshot(test2.allResults[5]).o5),
        Option(
            code: '.ج',
            text: test.fromSnapshot(test2.allResults[5]).mm['2'],
            isCorrect: test.fromSnapshot(test2.allResults[5]).mm['2'] ==
                test.fromSnapshot(test2.allResults[5]).o5),
        Option(
            code: '.د',
            text: test.fromSnapshot(test2.allResults[5]).mm['3'],
            isCorrect: test.fromSnapshot(test2.allResults[5]).mm['3'] ==
                test.fromSnapshot(test2.allResults[5]).o5),
      ],
      //solution: 'Ozone have 3 molecules of oxygen',
      selectedOption: Option(code: 'A', text: '', isCorrect: false)),
  Question(
      text: test.fromSnapshot(test2.allResults[6]).q,
      textQ: test.fromSnapshot(test2.allResults[6]).textQ,
      options: [
        Option(
            code: '.أ',
            text: test.fromSnapshot(test2.allResults[6]).mm['0'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[6]).mm['0'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[6]).mm['0'],
            isCorrect: test.fromSnapshot(test2.allResults[6]).mm['0'] ==
                test.fromSnapshot(test2.allResults[6]).o5),
        Option(
            code: '.ب',
            text: test.fromSnapshot(test2.allResults[6]).mm['1'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[6]).mm['1'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[6]).mm['1'],
            isCorrect: test.fromSnapshot(test2.allResults[6]).mm['1'] ==
                test.fromSnapshot(test2.allResults[6]).o5),
        Option(
            code: '.ج',
            text: test.fromSnapshot(test2.allResults[6]).mm['2'],
            isCorrect: test.fromSnapshot(test2.allResults[6]).mm['2'] ==
                test.fromSnapshot(test2.allResults[6]).o5),
        Option(
            code: '.د',
            text: test.fromSnapshot(test2.allResults[6]).mm['3'],
            isCorrect: test.fromSnapshot(test2.allResults[6]).mm['3'] ==
                test.fromSnapshot(test2.allResults[6]).o5),
      ],
      //solution: 'Ozone have 3 molecules of oxygen',
      selectedOption: Option(code: 'A', text: '', isCorrect: false)),
  Question(
      text: test.fromSnapshot(test2.allResults[7]).q,
      textQ: test.fromSnapshot(test2.allResults[7]).textQ,
      options: [
        Option(
            code: '.أ',
            text: test.fromSnapshot(test2.allResults[7]).mm['0'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[7]).mm['0'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[7]).mm['0'],
            isCorrect: test.fromSnapshot(test2.allResults[7]).mm['0'] ==
                test.fromSnapshot(test2.allResults[7]).o5),
        Option(
            code: '.ب',
            text: test.fromSnapshot(test2.allResults[7]).mm['1'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[7]).mm['1'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[7]).mm['1'],
            isCorrect: test.fromSnapshot(test2.allResults[7]).mm['1'] ==
                test.fromSnapshot(test2.allResults[7]).o5),
        Option(
            code: '.ج',
            text: test.fromSnapshot(test2.allResults[7]).mm['2'],
            isCorrect: test.fromSnapshot(test2.allResults[7]).mm['2'] ==
                test.fromSnapshot(test2.allResults[7]).o5),
        Option(
            code: '.د',
            text: test.fromSnapshot(test2.allResults[7]).mm['3'],
            isCorrect: test.fromSnapshot(test2.allResults[7]).mm['3'] ==
                test.fromSnapshot(test2.allResults[7]).o5),
      ],
      //solution: 'Ozone have 3 molecules of oxygen',
      selectedOption: Option(code: 'A', text: '', isCorrect: false)),
  Question(
      text: test.fromSnapshot(test2.allResults[8]).q,
      textQ: test.fromSnapshot(test2.allResults[8]).textQ,
      options: [
        Option(
            code: '.أ',
            text: test.fromSnapshot(test2.allResults[8]).mm['0'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[8]).mm['0'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[8]).mm['0'],
            isCorrect: test.fromSnapshot(test2.allResults[8]).mm['0'] ==
                test.fromSnapshot(test2.allResults[8]).o5),
        Option(
            code: '.ب',
            text: test.fromSnapshot(test2.allResults[8]).mm['1'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[8]).mm['1'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[8]).mm['1'],
            isCorrect: test.fromSnapshot(test2.allResults[8]).mm['1'] ==
                test.fromSnapshot(test2.allResults[8]).o5),
        Option(
            code: '.ج',
            text: test.fromSnapshot(test2.allResults[8]).mm['2'],
            isCorrect: test.fromSnapshot(test2.allResults[8]).mm['2'] ==
                test.fromSnapshot(test2.allResults[8]).o5),
        Option(
            code: '.د',
            text: test.fromSnapshot(test2.allResults[8]).mm['3'],
            isCorrect: test.fromSnapshot(test2.allResults[8]).mm['3'] ==
                test.fromSnapshot(test2.allResults[8]).o5),
      ],
      //solution: 'Ozone have 3 molecules of oxygen',
      selectedOption: Option(code: 'A', text: '', isCorrect: false)),
];
/*
  Question(
      text: test.fromSnapshot(test2.allResults[9]).q,
      textQ: test.fromSnapshot(test2.allResults[9]).textQ,
      options: [
        Option(
            code: '.أ',
            text: test.fromSnapshot(test2.allResults[9]).mm['0'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[9]).mm['0'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[9]).mm['0'],
            isCorrect: test.fromSnapshot(test2.allResults[9]).mm['0'] ==
                test.fromSnapshot(test2.allResults[9]).o5),
        Option(
            code: '.ب',
            text: test.fromSnapshot(test2.allResults[9]).mm['1'] == 'True'
                ? 'صح'
                : test.fromSnapshot(test2.allResults[9]).mm['1'] == 'False'
                    ? 'خطأ'
                    : test.fromSnapshot(test2.allResults[9]).mm['1'],
            isCorrect: test.fromSnapshot(test2.allResults[9]).mm['1'] ==
                test.fromSnapshot(test2.allResults[9]).o5),
        Option(
            code: '.ج',
            text: test.fromSnapshot(test2.allResults[9]).mm['2'],
            isCorrect: test.fromSnapshot(test2.allResults[9]).mm['2'] ==
                test.fromSnapshot(test2.allResults[9]).o5),
        Option(
            code: '.د',
            text: test.fromSnapshot(test2.allResults[9]).mm['3'],
            isCorrect: test.fromSnapshot(test2.allResults[9]).mm['3'] ==
                test.fromSnapshot(test2.allResults[9]).o5),
      ],
      //solution: 'Ozone have 3 molecules of oxygen',
      selectedOption: Option(code: 'A', text: '', isCorrect: false)),
];
*/