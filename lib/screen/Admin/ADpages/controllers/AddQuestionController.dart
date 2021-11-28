import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';

class AddQuestionController extends GetxController {
  final TextEditingController testNameController = TextEditingController();
  final TextEditingController answerOneController = TextEditingController();
  final TextEditingController answerTwoController = TextEditingController();
  final TextEditingController answerThreeController = TextEditingController();
  final TextEditingController answerFourController = TextEditingController();
  RxBool isTnFType = false.obs;
  RxInt selectedTnFAnswer = 0.obs;
  RxInt selectedAnswerIndex = 0.obs;
  RxString errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();

  bool validateForm() {
    if (isTnFType.value) {
      errorMessage.value = '';
      return true;
    } else if (answerOneController.text == answerTwoController.text ||
        answerOneController.text == answerThreeController.text ||
        answerOneController.text == answerFourController.text ||
        answerTwoController.text == answerThreeController.text ||
        answerTwoController.text == answerFourController.text ||
        answerThreeController.text == answerFourController.text) {
      errorMessage.value = '    لا يمكن أن تكون الإجابة متطابقة';
      // errorMessage.value = 'Two answers cannot be same';
      return false;
    }
    errorMessage.value = '';
    return true;
  }

  Future<void>? addQuestion(String testId) async {
    final Map<String, dynamic> data = {
      'id': randomAlpha(20),
      'question': testNameController.text,
      'options': isTnFType.value
          ? {
              '0': 'True',
              '1': 'False',
            }
          : {
              '0': answerOneController.text,
              '1': answerTwoController.text,
              '2': answerThreeController.text,
              '3': answerFourController.text,
            },
      'answer': isTnFType.value
          ? selectedTnFAnswer.value == 0
              ? 'True'
              : 'False'
          : selectedAnswerIndex.value == 0
              ? answerOneController.text
              : selectedAnswerIndex.value == 1
                  ? answerTwoController.text
                  : selectedAnswerIndex.value == 2
                      ? answerThreeController.text
                      : answerFourController.text,
      'createdAt': FieldValue.serverTimestamp(),
    };
    await FirebaseFirestore.instance
        .collection('Tests')
        .doc(testId)
        .collection('Questions')
        .doc()
        .set(data);
    Get.back();
  }
}
