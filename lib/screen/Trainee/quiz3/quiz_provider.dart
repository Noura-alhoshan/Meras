import 'package:flutter/material.dart';
import 'package:meras/screen/Trainee/quiz3/question.dart';
import 'package:meras/screen/Trainee/quiz3/quiz_service.dart';
import 'package:meras/screen/Trainee/quiz3/quiz_user.dart';

class QuizProvider extends ChangeNotifier {
  int totalTime = 0;
  List<Question> questions = [];
  //List<QuizUser> users = [];

  QuizProvider() {
    QuizService.getAllQuestions().then((value) {
      questions = value;
      notifyListeners();
    });

    QuizService.getTotalTime().then((value) {
      totalTime = value;
      notifyListeners();
    });
  }

  //Future<void> getAllUsers() async {
  //  users = await QuizService.getAllUsers();
  //  notifyListeners();
  //}

  //Future<void> updateHighscore(int currentScore) async {
  //  await QuizService.updateHighscore(currentScore);
  //}
}
