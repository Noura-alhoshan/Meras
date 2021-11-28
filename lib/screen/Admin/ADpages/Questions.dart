import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/Controllers/MyUser.dart';
import 'package:meras/components/ADroundedTitle.dart';
import 'package:meras/components/SingleBaseAlert.dart';
import 'package:meras/components/rounded_button.dart';
import 'package:meras/constants.dart';
import 'package:meras/screen/Admin/ADpages/ADhome.dart';
import 'package:meras/screen/Admin/ADpages/AddQuestion.dart';
import 'package:meras/screen/Admin/ADpages/controllers/AddQuestionController.dart';
import 'package:meras/screen/Admin/ADpages/manageGuidlines.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/authenticate/background2.dart';
import 'package:meras/screen/home/BaseAlertDialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:random_string/random_string.dart';

class Questions extends StatefulWidget {
  final String testId;
  Questions({required this.testId});
  final controller = Get.put(AddQuestionController());

  @override
  _Questions createState() => _Questions();
}

class _Questions extends State<Questions> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _controller = TextEditingController();

  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  String error = '';

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Center(child: Text('الأسئلة المضافة')),
          backgroundColor: Colors.deepPurple[100],
        ),
        body: SingleChildScrollView(
          child: BackgroundA(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Tests')
                      .doc(widget.testId)
                      .collection('Questions')
                      .orderBy('createdAt', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Loading();

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) =>
                          _buildListItem(context, (snapshot.data!).docs[index]),
                    );
                  })),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () {
            Get.to(AddQuestion(testId: widget.testId));
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
              onTap: () {},
              title: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Container(
                  child: Text(
                    doc.data()['question'],
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              subtitle: ListView.builder(
                  shrinkWrap: true,
                  itemCount: doc.data()['options'].length,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(29))),
                      tileColor: doc.data()['options'][index.toString()] ==
                              doc.data()['answer']
                          ? Colors.deepPurple[50]
                          : Colors.white,
                      title: Text(
                        doc.data()['options'][index.toString()],
                        textAlign: TextAlign.right,
                      ),
                    );
                  }))),
    );
  }
}
