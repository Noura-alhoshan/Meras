import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meras/screen/Trainee/TRpages/BackgroundLo2.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';
import 'TRviewPenRequest.dart';
import 'TRviewRejRequest.dart';
import 'package:meras/screen/Trainee/TRpages/TRviewRejRequest.dart';

class RejectedLessons extends StatefulWidget {
  //const RejectedLessons({ Key? key }) : super(key: key);

  @override
  _RejectedLessonsState createState() => _RejectedLessonsState();
}

class _RejectedLessonsState extends State<RejectedLessons> {
  @override
  void initState() {
    super.initState();
  }

  FirebaseAuth auth1 = FirebaseAuth.instance;
  Color red = Color(0xFFFFCDD2);
  Color green = Color(0xFFC8E6C9);
  final ScrollController _scrollController = ScrollController();

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    final DateTime dd2 = document['reqDate'].toDate();
    final String reqDate = DateFormat('MM/dd/yyyy').format(dd2);
    final String ph = document['CoachPhone'];
    return SingleChildScrollView(
      child: (document['Tid'] == auth1.currentUser!.uid &&
                  document['Status'] == 'D' ||
              document['Status'] == 'C')
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
                          color: red),
                      child: ListTile(
                        title: document['Status'] == 'C'
                            ? Text(' ملغى',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    height: -1,
                                    fontSize: 16,
                                    color: Colors.red[900]))
                            : Text(' مرفوض',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    height: -1,
                                    fontSize: 16,
                                    color: Colors.red[900])),
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
                                style: TextStyle(
                                    height: 2,
                                    fontSize: 10,
                                    color: kPrimaryColor),
                                textAlign: TextAlign.right,
                                // style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 4.5, horizontal: 7.0),
                          trailing: Image.asset("assets/images/req.png"),
                          leading: ElevatedButton(
                            child: Text('التفاصيل'),
                            onPressed: () async {
                              nav(document.id);
                            },
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                primary: Color(0xFF6F35A5),
                                textStyle: TextStyle(fontSize: 12)),
                          )),
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
    return
        // Scaffold(
        // extendBodyBehindAppBar: true,
        //drawer: NavDrawer(),
        // appBar: AppBar(
        // title: Text(
        // 'قائمة المدربين المتاحين',
        // textDirection: TextDirection.rtl,
        // ),
        // backgroundColor: Colors.deepPurple[100],
        // ),
        // body:
        Container(
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
        return ViewRejectedRequest(icd);
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
