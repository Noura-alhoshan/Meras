import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/home/BaseAlertDialog.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'SendRequest.dart';

class RequestLessonPage extends StatefulWidget {
  late final String id;
  RequestLessonPage(String icd) {
    this.id = icd;
  }

  //const RequestLessonPage({ Key? key }) : super(key: key);

  @override
  _RequestLessonPageState createState() => _RequestLessonPageState();
}

class _RequestLessonPageState extends State<RequestLessonPage> {
  late DateTime date;
  late TimeOfDay time;
  late DateTime dateTime;
  late DateTime day;

  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference req = FirebaseFirestore.instance.collection('Requests');

  @override
  Widget build(BuildContext context) {
    // final User? user = auth.currentUser;
    // final uid = user!.uid;

    return Scaffold(
      extendBodyBehindAppBar: true,
      //drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('حجز درس جديد'
            // textAlign: TextAlign.center,
            ),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Container(
        child: BackgroundA(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5)),

                //coach information

                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5)),

                // Align(
                //   alignment: Alignment.topRight,
                //   child: Text(
                //     'المواعيد المتاحة خلال الأسبوع القادم',
                //     style: TextStyle(height: 2, fontSize: 13),
                //     textAlign: TextAlign.right,
                //     // style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                // ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: BackgroundA(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Coach')
                                .where(FieldPath.documentId,
                                    isEqualTo: '${widget.id}') //widget.id
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return Loading(); //it was text 7.....
                              return ListView.builder(
                                // controller: _scrollController,

                                //  physics: const NeverScrollableScrollPhysics(), //<--here
                                itemCount: 1,

                                itemBuilder: (context, index) =>
                                    _build(context, (snapshot.data!).docs[0]),
                              );
                            }),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _build(BuildContext context, QueryDocumentSnapshot<Object?> doc) {}
}
