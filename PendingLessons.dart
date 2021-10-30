import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/components/SingleBaseAlertDialog.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meras/screen/Trainee/TRpages/BackgroundLo2.dart';
import 'package:meras/screen/home/BaseAlertDialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';
import 'TRviewPenRequest.dart';
import 'TRviewRequest.dart';

class PendingLessons extends StatefulWidget {
  //const PendingLessons({ Key? key }) : super(key: key);

  @override
  _PendingLessonsState createState() => _PendingLessonsState();
}

class _PendingLessonsState extends State<PendingLessons> {
  String sp = '                 ';
  @override
  void initState() {
    super.initState();
  }

  FirebaseAuth auth1 = FirebaseAuth.instance;
  Color red = Color(0xFFFFCDD2);
  Color green = Color(0xFFC8E6C9);

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    final DateTime dd2 = document['reqDate'].toDate();
    final String reqDate = DateFormat('MM/dd/yyyy').format(dd2);
    final String ph = document['CoachPhone'];
    return SingleChildScrollView(
      child: (document['Tid'] == auth1.currentUser!.uid &&
              document['Status'] == 'P')
          ? Container(
              height: 135,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Card(
                child: Column(
                  children: [
                    Container(
                      height: 25,
                      decoration: new BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20.0)),
                          //borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.orangeAccent[100]),
                      child: ListTile(
                        title: Text(' قيد الانتظار',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                height: -1, fontSize: 16, color: Colors.white)),
                      ),
                    ),
                    Container(
                      child: ListTile(
                        title: Text(
                          'المدرب: ' +
                              document['CoachName'] +
                              ' ' +
                              document['CoachName2'],
                          style: TextStyle(height: 1, fontSize: 15),
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Column(children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'تاريخ الطلب:' + ' ' + reqDate,
                              // .toString()
                              // .substring(0, 10),
                              style: TextStyle(
                                  height: 2,
                                  fontSize: 10,
                                  color: kPrimaryColor),
                              textAlign: TextAlign.right,
                              // style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          // ElevatedButton(
                          //     onPressed: () {
                          //       nav(document.id);
                          //     },
                          //     child: Text('التفاصيل')),
                          //trailing: Image.asset("assets/images/req.png")
                        ]),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 4.5, horizontal: 7.0),
                        trailing: Image.asset("assets/images/req.png"),
                        leading: ElevatedButton(
                          child: Text('التفاصيل'),
                          onPressed: () async {
                            nav(document.id);
                          },

                          // },
                          style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              primary: Color(0xFF6F35A5),
                              textStyle: TextStyle(fontSize: 12)),
                        ),
                      ),
                    ),
                  ],
                ),
                elevation: 6,
                shadowColor: Colors.deepPurple[500],
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: Colors.white, width: 1)),
              ),
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: BackgroundLO2(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Requests')
                  .orderBy('reqDate', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Loading();
                return ListView.builder(
                  //physics: const NeverScrollableScrollPhysics(), //<--here
                  //controller: _scrollController,

                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, (snapshot.data!).docs[index]),
                );
              }),
        ),
      ),
    );
    //);
  }

  void nav(String icd) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return ViewPendingRequest(icd);
        //return RequestLessonPage(icd);
      }),
    );
  }
}

String getArabicdays(String a) {
  switch (a.substring(19)) {
    case 'Saturday':
      return 'السبت';
    case 'Sunday':
      return 'الأحد';
    case 'Monday':
      return 'الأثنين';
    case 'Tuesday':
      return 'الثلاثاء';
    case 'Wednesday':
      return 'الأربعاء';
    case 'Thursday':
      return 'الخميس';
    case 'Friday':
      return 'الجمعة';
    default:
      return 'no day';
  }
}
