import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meras/components/rounded_button.dart';
import 'package:meras/constants.dart';
import 'package:meras/screen/Admin/ADpages/controllers/AddQuestionController.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';

class AddQuestion extends StatelessWidget {
  final String testId;

  AddQuestion({required this.testId});
  final controller = Get.put(AddQuestionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Center(child: Text('إضافة سؤال')),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: SingleChildScrollView(
        child: BackgroundA(
          child: Obx(() => Form(
                key: controller.formKey,
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          cursorColor: kPrimaryColor,
                          controller: controller.testNameController,
                          textAlign: TextAlign.right,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '                                                 الرجاء إدخال السؤال';
                            }
                          },
                          decoration: InputDecoration(
                              hintText: 'أدخل السؤال',
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kPrimaryColor)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: kPrimaryColor))),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: SizedBox(
                          child: CheckboxListTile(
                              title: Text(
                                'صح/خطأ؟',
                                textAlign: TextAlign.right,
                              ),
                              activeColor: kPrimaryColor,
                              value: controller.isTnFType.value,
                              onChanged: (value) {
                                controller.isTnFType.value = value!;
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      if (controller.isTnFType.value)
                        SizedBox(
                          //      width: 200,
                          height: 50,
                          child: Obx(() => Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 120,
                                    height: 50,
                                    child: RadioListTile(
                                      value: 0,
                                      activeColor: kPrimaryColor,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      groupValue:
                                          controller.selectedTnFAnswer.value,
                                      onChanged: (value) {
                                        controller.selectedTnFAnswer.value =
                                            value == 0 ? 0 : 1;
                                      },
                                      title: Text('صح'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 130,
                                    height: 50,
                                    child: RadioListTile(
                                      value: 1,
                                      activeColor: kPrimaryColor,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      groupValue:
                                          controller.selectedTnFAnswer.value,
                                      onChanged: (value) {
                                        controller.selectedTnFAnswer.value =
                                            value == 0 ? 0 : 1;
                                      },
                                      title: Text('خطأ',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      if (!controller.isTnFType.value)
                        SizedBox(
                          width: 270,
                          height: 50,
                          child: RadioListTile(
                            value: 0,
                            activeColor: kPrimaryColor,
                            controlAffinity: ListTileControlAffinity.trailing,
                            groupValue: controller.selectedAnswerIndex.value,
                            onChanged: (value) {
                              controller.selectedAnswerIndex.value = value == 0
                                  ? 0
                                  : value == 1
                                      ? 1
                                      : value == 2
                                          ? 2
                                          : 3;
                            },
                            title: TextFormField(
                              cursorColor: kPrimaryColor,
                              controller: controller.answerOneController,
                              textAlign: TextAlign.right,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '                                       الرجاء إدخال الإجابة';
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: 'أدخل الإجابة الأولى',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kPrimaryColor)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kPrimaryColor))),
                            ),
                          ),
                        ),
                      if (!controller.isTnFType.value)
                        SizedBox(
                          height: 45,
                        ),
                      if (!controller.isTnFType.value)
                        SizedBox(
                          width: 270,
                          height: 50,
                          child: RadioListTile(
                            value: 1,
                            activeColor: kPrimaryColor,
                            controlAffinity: ListTileControlAffinity.trailing,
                            groupValue: controller.selectedAnswerIndex.value,
                            onChanged: (value) {
                              controller.selectedAnswerIndex.value = value == 0
                                  ? 0
                                  : value == 1
                                      ? 1
                                      : value == 2
                                          ? 2
                                          : 3;
                            },
                            title: TextFormField(
                              cursorColor: kPrimaryColor,
                              controller: controller.answerTwoController,
                              textAlign: TextAlign.right,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '                                       الرجاء إدخال الإجابة';
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: 'أدخل الإجابة الثانية',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kPrimaryColor)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kPrimaryColor))),
                            ),
                          ),
                        ),
                      if (!controller.isTnFType.value)
                        SizedBox(
                          height: 45,
                        ),
                      if (!controller.isTnFType.value)
                        SizedBox(
                          width: 270,
                          height: 50,
                          child: RadioListTile(
                            value: 2,
                            activeColor: kPrimaryColor,
                            controlAffinity: ListTileControlAffinity.trailing,
                            groupValue: controller.selectedAnswerIndex.value,
                            onChanged: (value) {
                              controller.selectedAnswerIndex.value = value == 0
                                  ? 0
                                  : value == 1
                                      ? 1
                                      : value == 2
                                          ? 2
                                          : 3;
                            },
                            title: TextFormField(
                              cursorColor: kPrimaryColor,
                              controller: controller.answerThreeController,
                              textAlign: TextAlign.right,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '                                       الرجاء إدخال الإجابة';
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: 'أدخل الإجابة الثالثة',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kPrimaryColor)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kPrimaryColor))),
                            ),
                          ),
                        ),
                      if (!controller.isTnFType.value)
                        SizedBox(
                          height: 45,
                        ),
                      if (!controller.isTnFType.value)
                        SizedBox(
                          width: 270,
                          height: 50,
                          child: RadioListTile(
                            value: 3,
                            activeColor: kPrimaryColor,
                            controlAffinity: ListTileControlAffinity.trailing,
                            groupValue: controller.selectedAnswerIndex.value,
                            onChanged: (value) {
                              controller.selectedAnswerIndex.value = value == 0
                                  ? 0
                                  : value == 1
                                      ? 1
                                      : value == 2
                                          ? 2
                                          : 3;
                            },
                            title: TextFormField(
                              cursorColor: kPrimaryColor,
                              controller: controller.answerFourController,
                              textAlign: TextAlign.right,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '                                       الرجاء إدخال الإجابة';
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: 'أدخل الإجابة الرابعة',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kPrimaryColor)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kPrimaryColor))),
                            ),
                          ),
                        ),
                      if (controller.errorMessage.value.isNotEmpty)
                        SizedBox(height: 60),
                      if (controller.errorMessage.value.isNotEmpty)
                        Center(
                          child: Text(controller.errorMessage.value,
                              style: TextStyle(
                                color: Colors.red,
                              )),
                        ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 75.0),
                        child: RoundedButton(
                            text: 'إضافة',
                            press: () async {
                              if (controller.formKey.currentState!.validate() &&
                                  controller.validateForm()) {
                                await controller.addQuestion(testId);
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
