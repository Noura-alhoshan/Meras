import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/components/SingleBaseAlert.dart';
import 'package:meras/constants.dart';
import 'package:meras/screen/Admin/ADpages/AddQuestion.dart';
import 'package:meras/screen/Admin/ADpages/controllers/AddQuestionController.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Admin/widget/button_widget_edit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Questions extends StatelessWidget {
  final controller = Get.put(AddQuestionController());
  final int questionsLimit = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('إدارة الاختبار القصير'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple[100],
        ),
        body: SingleChildScrollView(
          child: BackgroundA(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Questions')
                      .orderBy('createdAt', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Loading();
                    return Column(
                      children: [
                        SizedBox(
                          height: 125,
                          child: StreamBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection('Global')
                                  .doc('questions')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) return Loading();
                                int numberOfQuestions = snapshot.data!
                                        .data()!['numberOfQuestions'] ??
                                    -1;
                                return numberOfQuestions < 0
                                    ? Container()
                                    : Center(
                                        child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 65),
                                            child: ListTile(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 13),
                                              tileColor: numberOfQuestions ==
                                                      questionsLimit
                                                  ? Colors.green[200]
                                                  : Colors.red[200],
                                              title: Text(
                                                  numberOfQuestions ==
                                                          questionsLimit
                                                      ? 'تم إضافة جميع الأسئلة'
                                                      : 'عدد الأسئلة المتبقية ${questionsLimit - numberOfQuestions}',
                                                  textAlign: TextAlign.center),
                                            )),
                                      );
                              }),
                        ),
                        SizedBox(
                          height: Get.height - 125,
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) => _buildListItem(
                                context, (snapshot.data!).docs[index]),
                          ),
                        ),
                      ],
                    );
                  })),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () async {
            await FirebaseFirestore.instance
                .collection('Global')
                .doc('questions')
                .get()
                .then((snapshot) {
              if (snapshot.exists) {
                if (snapshot.data()!['numberOfQuestions'] >= questionsLimit) {
                  var baseDialog = SignleBaseAlertDialog(
                    title: "",
                    content: "لقد وصلت الحد الأقصى من الأسئلة",
                    // content: "لا يمكن إضافة أكثر من $questionsLimit",
                    yesOnPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                    yes: "إغلاق",
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => baseDialog);
                } else {
                  controller.clearData();
                  Get.to(AddQuestion(
                    isEditPage: false,
                    questionData: '',
                  ));
                }
              }
            });
          },
          child: Icon(Icons.add),
        ));
  }

  _buildListItem(BuildContext context, dynamic doc) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 30),
      child: Card(
          elevation: 2,
          shadowColor: Colors.deepPurple[500],
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.white, width: 1)),
          child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (doc.data()['imageUrl'] != null &&
                        doc.data()['imageUrl'] != '')
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: doc.data()['imageUrl'],
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          height: 150,
                        ),
                      ),
                    if (doc.data()['imageUrl'] != null &&
                        doc.data()['imageUrl'] != '')
                      SizedBox(height: 30),
                    Text(doc.data()['question'],
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              subtitle: Column(
                children: [
                  Divider(color: Colors.black45),
                  SizedBox(height: 20),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: doc.data()['options'].length,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          tileColor: doc.data()['options'][index.toString()] ==
                                  doc.data()['answer']
                              ? Colors.deepPurple[50]!.withOpacity(0.7)
                              : Colors.white,
                          title: Text(
                            '${index == 0 ? 'أ' : index == 1 ? 'ب' : index == 2 ? 'ج' : 'د'} ${doc.data()['options'][index.toString()] == 'True' ? 'صح' : doc.data()['options'][index.toString()] == 'False' ? 'خطأ' : doc.data()['options'][index.toString()]}',
                            textAlign: TextAlign.right,
                          ),
                        );
                      }),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonWidgetEdit(
                        colorr: kPrimaryColor,
                        text: 'تعديل',
                        onClicked: () async {
                          controller.initEditQuestionPage(doc);
                          Get.to(AddQuestion(
                              isEditPage: true, questionData: doc.data()));
                        },
                      ),
                      SizedBox(width: 30),
                      ButtonWidgetEdit(
                        colorr: kPrimaryColor,
                        text: ' حذف  ',
                        onClicked: () async {
                          await controller.deleteQuestion(
                              doc.data()['id'], context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ))),
    );
  }
}
