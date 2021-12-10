import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meras/components/rounded_button.dart';
import 'package:meras/constants.dart';
import 'package:meras/screen/Admin/ADpages/controllers/AddQuestionController.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';

//
class AddQuestion extends StatelessWidget {
  final bool isEditPage;
  final dynamic questionData;

  AddQuestion({required this.isEditPage, required this.questionData});
  final controller = Get.put(AddQuestionController());
  @override
  Widget build(BuildContext context) {
    controller.selectedFile.value = XFile('');
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(isEditPage ? 'تعديل السؤال' : 'إضافة سؤال'),
        centerTitle: true,
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
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Obx(
                          () => InkWell(
                            onTap: () {
                              controller.pickImage();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              height: 90,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/upload_file.png',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Row(
                                children: [
                                  if (isEditPage &&
                                      controller.currentImageUrl.value != '' &&
                                      controller.selectedFile.value.path == '')
                                    CachedNetworkImage(
                                        imageUrl:
                                            controller.currentImageUrl.value,
                                        width: 75,
                                        height: 75)
                                  else if (controller.selectedFile.value.path ==
                                          '' ||
                                      (isEditPage &&
                                          (questionData['imageUrl'] == '' ||
                                              questionData['imageUrl'] ==
                                                  null)))
                                    Icon(
                                      Icons.add_a_photo_outlined,
                                      color: kPrimaryColor,
                                    )
                                  else
                                    Image.file(
                                      File(controller.selectedFile.value.path),
                                      width: 75,
                                      height: 75,
                                    ),
                                  SizedBox(width: 15),
                                  SizedBox(
                                    width: 130,
                                    child: Text(
                                      controller.selectedFile.value.path == ''
                                          ? isEditPage
                                              ? ' تعديل الصورة'
                                              : 'إضافة صورة'
                                          : controller.selectedImageName.value,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (controller.selectedFile.value.path !=
                                          '' ||
                                      controller.currentImageUrl.value != '')
                                    IconButton(
                                      onPressed: () {
                                        controller.selectedFile.value =
                                            XFile('');
                                        controller.currentImageUrl.value = '';
                                      },
                                      icon: Icon(
                                        Icons.clear,
                                        size: 24,
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          cursorColor: kPrimaryColor,
                          controller: controller.testNameController,
                          maxLines: null,
                          textDirection: TextDirection.rtl,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(60)
                          ],
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
                        height: 15,
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
                        height: 10,
                      ),
                      if (controller.isTnFType.value)
                        SizedBox(
                          //      width: 200,
                          height: 50,
                          child: Obx(() => Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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
                                ],
                              )),
                        ),
                      if (!controller.isTnFType.value)
                        SizedBox(
                          width: 270,
                          height: 70,
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
                              maxLines: null,
                              textDirection: TextDirection.rtl,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(41)
                              ],
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
                          height: 70,
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
                              maxLines: null,
                              textDirection: TextDirection.rtl,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(41)
                              ],
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
                          height: 70,
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
                              maxLines: null,
                              textDirection: TextDirection.rtl,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(41)
                              ],
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
                          height: 70,
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
                              maxLines: null,
                              textDirection: TextDirection.rtl,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(41)
                              ],
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
                            text: isEditPage ? 'تعديل' : 'إضافة',
                            press: () async {
                              if (controller.formKey.currentState!.validate() &&
                                  controller.validateForm()) {
                                if (isEditPage) {
                                  await controller.addQuestion(
                                      isEditPage, context, questionData['id']);
                                } else {
                                  await controller.addQuestion(
                                      isEditPage, context);
                                }
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
