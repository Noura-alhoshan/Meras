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
          text: test.fromSnapshot(test2.allResults[1]).mm['0'],
          isCorrect: test.fromSnapshot(test2.allResults[1]).mm['0'] ==
              test.fromSnapshot(test2.allResults[1]).o5),
      Option(
          code: '.ب',
          text: test.fromSnapshot(test2.allResults[1]).mm['1'],
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
            text: test.fromSnapshot(test2.allResults[0]).mm['0'],
            isCorrect: test.fromSnapshot(test2.allResults[0]).mm['0'] ==
                test.fromSnapshot(test2.allResults[0]).o5),
        Option(
            code: '.ب',
            text: test.fromSnapshot(test2.allResults[0]).mm['1'],
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
];
/*
  Question(
      text: test.fromSnapshot(test2.allResults[2]).q,
      options: [
        Option(
            code: '.أ',
            text: test.fromSnapshot(test2.allResults[2]).o1,
            isCorrect: test.fromSnapshot(test2.allResults[2]).o1 ==
                test.fromSnapshot(test2.allResults[2]).o5),
        Option(
            code: '.ب',
            text: test.fromSnapshot(test2.allResults[2]).o2,
            isCorrect: test.fromSnapshot(test2.allResults[2]).o2 ==
                test.fromSnapshot(test2.allResults[2]).o5),
        Option(
            code: '.ج',
            text: test.fromSnapshot(test2.allResults[2]).o3,
            isCorrect: test.fromSnapshot(test2.allResults[2]).o3 ==
                test.fromSnapshot(test2.allResults[2]).o5),
        Option(
            code: '.د',
            text: test.fromSnapshot(test2.allResults[2]).o4,
            isCorrect: test.fromSnapshot(test2.allResults[2]).o4 ==
                test.fromSnapshot(test2.allResults[2]).o5),
      ],
      //  solution: 'The symbol for potassium is K',
      selectedOption: Option(code: 'A', text: 'N', isCorrect: false)),
  Question(
      text: test.fromSnapshot(test2.allResults[3]).q,
      options: [
        Option(
            code: '.أ',
            text: test.fromSnapshot(test2.allResults[3]).o1,
            isCorrect: test.fromSnapshot(test2.allResults[3]).o1 ==
                test.fromSnapshot(test2.allResults[3]).o5),
        Option(
            code: '.ب',
            text: test.fromSnapshot(test2.allResults[3]).o2,
            isCorrect: test.fromSnapshot(test2.allResults[3]).o2 ==
                test.fromSnapshot(test2.allResults[3]).o5),
        Option(
            code: '.ج',
            text: test.fromSnapshot(test2.allResults[3]).o3,
            isCorrect: test.fromSnapshot(test2.allResults[3]).o3 ==
                test.fromSnapshot(test2.allResults[3]).o5),
        Option(
            code: '.د',
            text: test.fromSnapshot(test2.allResults[3]).o4,
            isCorrect: test.fromSnapshot(test2.allResults[3]).o4 ==
                test.fromSnapshot(test2.allResults[3]).o5),
      ],
      //solution: '4.48 Psychosis is the correct answer for this question',
      selectedOption: Option(code: 'A', text: 'Psychosis', isCorrect: false)),
  Question(
      text: test.fromSnapshot(test2.allResults[4]).q,
      options: [
        Option(
            code: '.أ',
            text: test.fromSnapshot(test2.allResults[4]).o1,
            isCorrect: test.fromSnapshot(test2.allResults[4]).o1 ==
                test.fromSnapshot(test2.allResults[4]).o5),
        Option(
            code: '.ب',
            text: test.fromSnapshot(test2.allResults[4]).o2,
            isCorrect: test.fromSnapshot(test2.allResults[4]).o2 ==
                test.fromSnapshot(test2.allResults[4]).o5),
        Option(
            code: '.ج',
            text: test.fromSnapshot(test2.allResults[4]).o3,
            isCorrect: test.fromSnapshot(test2.allResults[4]).o3 ==
                test.fromSnapshot(test2.allResults[4]).o5),
        Option(
            code: '.د',
            text: test.fromSnapshot(test2.allResults[4]).o4,
            isCorrect: test.fromSnapshot(test2.allResults[4]).o4 ==
                test.fromSnapshot(test2.allResults[4]).o5),
      ],
      // solution: 'iPhone was first released in 2007',
      selectedOption: Option(code: 'A', text: '2005', isCorrect: false)),
  Question(
      text: test.fromSnapshot(test2.allResults[5]).q,
      options: [
        Option(
            code: '.أ',
            text: test.fromSnapshot(test2.allResults[5]).o1,
            isCorrect: test.fromSnapshot(test2.allResults[5]).o1 ==
                test.fromSnapshot(test2.allResults[5]).o5),
        Option(
            code: '.ب',
            text: test.fromSnapshot(test2.allResults[5]).o2,
            isCorrect: test.fromSnapshot(test2.allResults[5]).o2 ==
                test.fromSnapshot(test2.allResults[5]).o5),
        Option(
            code: '.ج',
            text: test.fromSnapshot(test2.allResults[5]).o3,
            isCorrect: test.fromSnapshot(test2.allResults[5]).o3 ==
                test.fromSnapshot(test2.allResults[5]).o5),
        Option(
            code: '.د',
            text: test.fromSnapshot(test2.allResults[5]).o4,
            isCorrect: test.fromSnapshot(test2.allResults[5]).o4 ==
                test.fromSnapshot(test2.allResults[5]).o5),
      ],
      // solution:
      //     'Calcium is the element responsible for keeping the bones strong',
      selectedOption: Option(code: 'A', text: 'Carbon', isCorrect: false)),
  Question(
      text: test.fromSnapshot(test2.allResults[6]).q,
      options: [
        Option(
            code: '.أ',
            text: test.fromSnapshot(test2.allResults[6]).o1,
            isCorrect: test.fromSnapshot(test2.allResults[6]).o1 ==
                test.fromSnapshot(test2.allResults[6]).o5),
        Option(
            code: '.ب',
            text: test.fromSnapshot(test2.allResults[6]).o2,
            isCorrect: test.fromSnapshot(test2.allResults[6]).o2 ==
                test.fromSnapshot(test2.allResults[6]).o5),
        Option(
            code: '.ج',
            text: test.fromSnapshot(test2.allResults[6]).o3,
            isCorrect: test.fromSnapshot(test2.allResults[6]).o3 ==
                test.fromSnapshot(test2.allResults[6]).o5),
        Option(
            code: '.د',
            text: test.fromSnapshot(test2.allResults[6]).o4,
            isCorrect: test.fromSnapshot(test2.allResults[6]).o4 ==
                test.fromSnapshot(test2.allResults[6]).o5),
      ],
      // solution: 'Uruguay was the first country to win world cup',
      selectedOption: Option(code: 'A', text: 'Brazil', isCorrect: false)),
  Question(
      text: test.fromSnapshot(test2.allResults[7]).q,
      options: [
        Option(
            code: '.أ',
            text: test.fromSnapshot(test2.allResults[7]).o1,
            isCorrect: test.fromSnapshot(test2.allResults[7]).o1 ==
                test.fromSnapshot(test2.allResults[7]).o5),
        Option(
            code: '.ب',
            text: test.fromSnapshot(test2.allResults[7]).o2,
            isCorrect: test.fromSnapshot(test2.allResults[7]).o2 ==
                test.fromSnapshot(test2.allResults[7]).o5),
        Option(
            code: '.ج',
            text: test.fromSnapshot(test2.allResults[7]).o3,
            isCorrect: test.fromSnapshot(test2.allResults[7]).o3 ==
                test.fromSnapshot(test2.allResults[7]).o5),
        Option(
            code: '.د',
            text: test.fromSnapshot(test2.allResults[7]).o4,
            isCorrect: test.fromSnapshot(test2.allResults[7]).o4 ==
                test.fromSnapshot(test2.allResults[7]).o5),
      ],
      //   solution: 'Uruguay was the first country to win world cup',
      selectedOption: Option(code: 'A', text: 'Brazil', isCorrect: false)),
];

 */ 
