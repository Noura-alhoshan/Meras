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
import 'package:meras/screen/Admin/ADpages/manageGuidlines.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/authenticate/background2.dart';
import 'package:meras/screen/home/BaseAlertDialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:random_string/random_string.dart';

class AddTest extends StatefulWidget {
  // final String uid;
  // AddGuidlines({required this.uid});
  //const AddGuidlines({ Key? key }) : super(key: key);

  @override
  _AddTest createState() => _AddTest();
}

class _AddTest extends State<AddTest> {
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
          title: Center(child: Text('إضافة اختبار قصير  ')),
          backgroundColor: Colors.deepPurple[100],
        ),
        body: SingleChildScrollView(
          child: BackgroundA(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40.0),
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
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () {
            final TextEditingController testNameController =
                TextEditingController();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Add Test', textAlign: TextAlign.right),
                content: SizedBox(
                    height: 150,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: testNameController,
                          decoration: InputDecoration(
                              hintText: 'Title', border: OutlineInputBorder()),
                        )
                      ],
                    )),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Cancel')),
                  TextButton(
                      onPressed: () async {
                        if (testNameController.text.length < 1) {
                          Get.showSnackbar(GetBar(
                            title: 'Error',
                            message: 'Please enter valid test name',
                            duration: Duration(seconds: 1),
                          ));
                        } else {
                          final String id = randomAlpha(20);
                          await FirebaseFirestore.instance
                              .collection('Tests')
                              .doc(id)
                              .set({
                            'id': id,
                            'title': testNameController.text,
                            'createdAt': FieldValue.serverTimestamp(),
                          });
                          Get.back();

                          Get.showSnackbar(GetBar(
                            title: 'Success',
                            message: 'Test Added Successfully',
                            duration: Duration(seconds: 1),
                          ));
                        }
                      },
                      child: Text('Add'))
                ],
              ),
            );
          },
          child: Icon(Icons.add),
        ));
  }

  _buildListItem(BuildContext context, dynamic doc) {
    return Container(
      height: 120,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
          elevation: 6,
          shadowColor: Colors.deepPurple[500],
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.white, width: 1)),
          child: ListTile(
            onTap: () {},
            title: Text(doc.data()['title']),
          )),
    );
  }
}
