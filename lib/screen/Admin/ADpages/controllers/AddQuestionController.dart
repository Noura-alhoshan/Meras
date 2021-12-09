import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meras/components/SingleBaseAlert.dart';
import 'package:meras/screen/Admin/services/BaseAlertDialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:random_string/random_string.dart';
import 'package:path/path.dart';

class AddQuestionController extends GetxController {
  final TextEditingController testNameController = TextEditingController();
  final TextEditingController answerOneController = TextEditingController();
  final TextEditingController answerTwoController = TextEditingController();
  final TextEditingController answerThreeController = TextEditingController();
  final TextEditingController answerFourController = TextEditingController();
  RxString currentImageUrl = ''.obs;
  RxBool isTnFType = false.obs;
  RxInt selectedTnFAnswer = 0.obs;
  RxInt selectedAnswerIndex = 0.obs;
  RxString errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();

  RxString selectedImageName = ''.obs;
  Rx<XFile> selectedFile = XFile('').obs;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    if (pickedFile != null) {
      selectedFile.value = pickedFile;
      selectedImageName.value = basename(pickedFile.path);
    } else {
      selectedFile.value = XFile('');
      selectedImageName.value = '';
    }
  }

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

  Future<void>? addQuestion(bool isEditPage, BuildContext context,
      [String? questionId]) async {
    final String id = randomAlpha(20);
    Map<String, dynamic> data = {};

    String imageUrl = '';

    if (selectedFile.value.path != '') {
      imageUrl = await uploadImage(selectedFile.value) ?? '';
    }

    if (!isEditPage) {
      data = {
        'id': id,
        'question': testNameController.text,
        'isTnFType': isTnFType.value,
        'options': isTnFType.value
            ? {
                '0': 'True',
                '1': 'False',
                '2': ' ',
                '3': ' ',
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
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      };
    } else {
      data = {
        'question': testNameController.text,
        'isTnFType': isTnFType.value,
        'options': isTnFType.value
            ? {
                '0': 'True',
                '1': 'False',
                '2': ' ',
                '3': ' ',
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
        'imageUrl': imageUrl,
      };
    }
    if (isEditPage) {
      await FirebaseFirestore.instance
          .collection('Questions')
          .doc(questionId)
          .update(data);
    } else {
      await FirebaseFirestore.instance
          .collection('Questions')
          .doc(id)
          .set(data);
      await FirebaseFirestore.instance
          .collection('Global')
          .doc('questions')
          .update({
        'numberOfQuestions': FieldValue.increment(1),
      });
    }
    Get.back();
    var baseDialog = SignleBaseAlertDialog(
      title: "",
      content: isEditPage ? 'تم تعديل السؤال بنجاح' : 'تم إضافة السؤال بنجاح',
      yesOnPressed: () async {
        Get.back();
      },
      yes: "إغلاق",
    );
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  Future<String?> uploadImage(XFile file) async {
    final _storage = FirebaseStorage.instance;

    var snapshot = await _storage
        .ref()
        .child('Questions/${file.path}')
        .putFile(File(file.path));

    return await snapshot.ref.getDownloadURL();
  }

  Future<void>? deleteQuestion(String questionId, BuildContext context) async {
    var baseDialog = BaseAlertDialog(
        title: "",
        content: "هل أنت متأكد من حذف السؤال؟",
        yesOnPressed: () async {
          await FirebaseFirestore.instance
              .collection('Questions')
              .doc(questionId)
              .delete();
          await FirebaseFirestore.instance
              .collection('Global')
              .doc('questions')
              .update({
            'numberOfQuestions': FieldValue.increment(-1),
          });
          Navigator.of(context, rootNavigator: true).pop('dialog');
          var baseDialog = SignleBaseAlertDialog(
            title: "",
            content: "تم حذف السؤال بنجاح",
            yesOnPressed: () async {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
            yes: "إغلاق",
          );
          showDialog(
              context: context, builder: (BuildContext context) => baseDialog);
        },
        noOnPressed: () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
        },
        yes: "نعم",
        no: "لا");
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  void clearData() {
    testNameController.text = '';
    answerOneController.text = '';
    answerTwoController.text = '';
    answerThreeController.text = '';
    answerFourController.text = '';
    currentImageUrl.value = '';
    isTnFType.value = false;
    selectedAnswerIndex.value = 0;
  }

  void initEditQuestionPage(dynamic questionData) {
    testNameController.text = questionData.data()['question'];
    currentImageUrl.value = questionData.data()['imageUrl'] ?? '';
    if (!questionData.data()['isTnFType']) {
      answerOneController.text = questionData.data()['options']['0'];
      answerTwoController.text = questionData.data()['options']['1'];
      answerThreeController.text = questionData.data()['options']['2'];
      answerFourController.text = questionData.data()['options']['3'];
    } else {
      isTnFType.value = questionData.data()['isTnFType'];
    }
    selectedAnswerIndex.value = questionData.data()['isTnFType']
        ? questionData.data()['answer'] == 'True'
            ? 0
            : 1
        : questionData.data()['answer'] == answerOneController.text
            ? 0
            : questionData.data()['answer'] == answerTwoController.text
                ? 1
                : questionData.data()['answer'] == answerThreeController.text
                    ? 2
                    : 3;
  }
}
