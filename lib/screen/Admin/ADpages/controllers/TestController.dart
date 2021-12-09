// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:meras/components/SingleBaseAlert.dart';
// import 'package:meras/screen/Admin/services/BaseAlertDialog.dart';
// import 'package:random_string/random_string.dart';

// import '../../../../constants.dart';

// class TestController extends GetxController {
//   final TextEditingController testNameController = TextEditingController();

//   final formKey = GlobalKey<FormState>();
//   void clearForm() {
//     testNameController.text = '';
//   }

//   void initEditQuestionPage(dynamic testData) {
//     testNameController.text = testData.data()['title'];
//   }

//   Future<void>? deleteTest(String testId, BuildContext context) async {
//     var baseDialog = BaseAlertDialog(
//         title: "",
//         content: "هل أنت متأكد من حذف الاختبار؟",
//         yesOnPressed: () async {
//           await FirebaseFirestore.instance
//               .collection('Tests')
//               .doc(testId)
//               .collection('Questions')
//               .get()
//               .then((snapshot) async {
//             if (snapshot.docs.isNotEmpty) {
//               for (final question in snapshot.docs) {
//                 await FirebaseFirestore.instance
//                     .collection('Tests')
//                     .doc(testId)
//                     .collection('Questions')
//                     .doc(question.id)
//                     .delete();
//               }
//             }
//           });
//           await FirebaseFirestore.instance
//               .collection('Tests')
//               .doc(testId)
//               .delete();
//           Navigator.of(context, rootNavigator: true).pop('dialog');
//           var baseDialog = SignleBaseAlertDialog(
//             title: "",
//             content: "تم حذف الاختبار بنجاح",
//             yesOnPressed: () async {
//               Navigator.of(context, rootNavigator: true).pop('dialog');
//             },
//             yes: "إغلاق",
//           );
//           showDialog(
//               context: context, builder: (BuildContext context) => baseDialog);
//         },
//         noOnPressed: () {
//           Navigator.of(context, rootNavigator: true).pop('dialog');
//         },
//         yes: "نعم",
//         no: "لا");
//     showDialog(context: context, builder: (BuildContext context) => baseDialog);
//   }

//   Future<bool> checkIfTestExists(String testName) async {
//     return await FirebaseFirestore.instance
//         .collection('Tests')
//         .where('title', isEqualTo: testName)
//         .get()
//         .then((snapshot) => snapshot.docs.isNotEmpty ? true : false);
//   }

//   Future<void>? addTest(BuildContext context, bool isEditPage,
//       [String? testId]) async {
//     if (!isEditPage) clearForm();
//     await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(32.0))),
//         contentPadding: EdgeInsets.only(top: 14.0, right: 23, left: 23),
//         title: Text(isEditPage ? 'تعديل العنوان' : 'إضافة عنوان ',
//             textAlign: TextAlign.center),
//         content: Container(
//             height: 150,
//             child: Column(
//               children: [
//                 Form(
//                   key: formKey,
//                   child: TextFormField(
//                     cursorColor: kPrimaryColor,
//                     controller: testNameController,
//                     textAlign: TextAlign.right,
//                     maxLines: null,
//                     textDirection: TextDirection.rtl,
//                     inputFormatters: [LengthLimitingTextInputFormatter(41)],
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return '                           الرجاء إدخال العنوان';
//                       }
//                     },
//                     decoration: InputDecoration(
//                         hintText: 'أدخل العنوان',
//                         focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: kPrimaryColor)),
//                         enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: kPrimaryColor))),
//                   ),
//                 )
//               ],
//             )),
//         actionsAlignment: MainAxisAlignment.center,
//         actions: [
//           FlatButton(
//             child: Text(
//               'إلغاء',
//               style: TextStyle(fontSize: 15.3),
//               textAlign: TextAlign.center,
//             ),
//             textColor: Colors.deepPurple[900],
//             onPressed: () {
//               Get.back();
//             },
//           ),
//           FlatButton(
//             child: new Text(
//               isEditPage ? 'حفظ' : 'إضافة',
//               style: TextStyle(fontSize: 15.3),
//               textAlign: TextAlign.center,
//             ),
//             textColor: Colors.deepPurple[900],
//             onPressed: () async {
//               if (formKey.currentState!.validate()) {
//                 bool isError = false;
//                 final String id = randomAlpha(20);
//                 if (!isEditPage) {
//                   if (await checkIfTestExists(testNameController.text)) {
//                     isError = true;
//                   } else
//                     await FirebaseFirestore.instance
//                         .collection('Tests')
//                         .doc(id)
//                         .set({
//                       'id': id,
//                       'title': testNameController.text,
//                       'numberOfQuestions': 0,
//                       'createdAt': FieldValue.serverTimestamp(),
//                     });
//                 } else {
//                   await FirebaseFirestore.instance
//                       .collection('Tests')
//                       .doc(testId)
//                       .update({
//                     'title': testNameController.text,
//                   });
//                 }
//                 Get.back();

//                 var baseDialog = SignleBaseAlertDialog(
//                   title: "",
//                   content: isEditPage
//                       ? 'تم تعديل عنوان الاختبار بنجاح'
//                       : isError
//                           ? 'يوجد اختبار بهذا العنوان'
//                           : 'تم إضافة الاختبار بنجاح',
//                   yesOnPressed: () async {
//                     Get.back();
//                   },
//                   yes: "إغلاق",
//                 );
//                 showDialog(
//                     context: context,
//                     builder: (BuildContext context) => baseDialog);
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
