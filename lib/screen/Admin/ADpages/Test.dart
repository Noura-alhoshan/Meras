import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/constants.dart';
import 'package:meras/screen/Admin/ADpages/controllers/TestController.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Admin/widget/button_widget_edit.dart';

import 'Questions.dart';

class Test extends StatelessWidget {
  final controller = Get.put(TestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Center(child: Text('الاختبارات المضافة')),
          backgroundColor: Colors.deepPurple[100],
        ),
        body: SingleChildScrollView(
          child: BackgroundA(
            child: Column(
              children: <Widget>[
                SizedBox(height: 36.5),
                SizedBox(
                    height: Get.height * 0.95,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Tests')
                            .orderBy('createdAt', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return Loading();

                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) => _buildListItem(
                                context, (snapshot.data!).docs[index]),
                          );
                        })),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () async {
            await controller.addTest(context, false);
          },
          child: Icon(Icons.add),
        ));
  }

  _buildListItem(BuildContext context, dynamic doc) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
          elevation: 2,
          shadowColor: Colors.deepPurple[500],
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.white, width: 1)),
          child: ListTile(
            onTap: () {
              Get.to(Questions(testId: doc.id));
            },
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  doc.data()['title'],
                  // style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidgetEdit(
                      colorr: kPrimaryColor,
                      text: 'تعديل',
                      onClicked: () async {
                        controller.initEditQuestionPage(doc);
                        controller.addTest(context, true, doc!.data()['id']);
                      },
                      horizontalSize: 35,
                      verticalSize: 5,
                    ),
                    SizedBox(width: 30),
                    ButtonWidgetEdit(
                      colorr: kPrimaryColor,
                      text: ' حذف  ',
                      onClicked: () async {
                        await controller.deleteTest(doc.data()['id'], context);
                      },
                      horizontalSize: 35,
                      verticalSize: 5,
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          )),
    );
  }
}
