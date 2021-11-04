import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/services/BaseAlertDialog.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Admin/widget/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../PaypalPayment.dart';
import 'TRlessons.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ViewLessonsInfo extends StatefulWidget {
  final String id;
  ViewLessonsInfo(this.id);

  @override
  _ViewLessonsInfoState createState() => _ViewLessonsInfoState();
}

class _ViewLessonsInfoState extends State<ViewLessonsInfo> {
  final ScrollController _scrollController = ScrollController();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          ' تفاصيل الطلب',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Requests')
              .where(FieldPath.documentId, isEqualTo: widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Loading(); //it was text 7.....
            return ListView.builder(
              // controller: _scrollController,

              // physics: const NeverScrollableScrollPhysics(), //<--here
              itemCount: 1,

              itemBuilder: (context, index) =>
                  _build(context, (snapshot.data!).docs[0]),
            );
          }),
    );
  }

  Widget _build(BuildContext context, DocumentSnapshot document) {
    final String ph = document['CoachPhone'];

    return BackgroundA(
      child: Align(
        alignment: const Alignment(0, -0.4),
        child: Container(
          width: 307,
          height: 455,
          padding: EdgeInsets.only(bottom: 10, top: 0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 15.0),
                    blurRadius: 15.0),
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, -10.0),
                    blurRadius: 10.0),
              ]),
          child: Padding(
            padding: EdgeInsets.only(left: 0, right: 0, top: 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Container(
                height:
                    440, ////////////////////////////////////////////////////////////////
                //child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.deepPurple.shade50,
                      Colors.white10,
                    ],
                  )),
                  // height: 1200,
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 00),
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 6,
                    ),
                    new ListTile(
                      //leading: const Icon(Icons.today),
                      title: Text(
                        document['DateTime'].toString().substring(17, 19) ==
                                'AM'
                            ? 'يوم ' +
                                getArabicdays(document['DateTime'].toString()) +
                                ' ' +
                                document['DateTime']
                                    .toString()
                                    .substring(0, 10) +
                                '\n'
                                    ' الوقت: ' +
                                document['DateTime']
                                    .toString()
                                    .substring(11, 16) +
                                ' صباحا '
                            : 'يوم ' +
                                getArabicdays(document['DateTime'].toString()) +
                                ' ' +
                                document['DateTime']
                                    .toString()
                                    .substring(0, 10) +
                                '\n'
                                    ' الوقت: ' +
                                document['DateTime']
                                    .toString()
                                    .substring(11, 16) +
                                ' مساءً ',
                        style: TextStyle(height: 2.2, fontSize: 17.6),
                        textAlign: TextAlign.right,
                      ),
                      //subtitle: Text('February 20, 1980'),
                      trailing: IconButton(
                        icon: Icon(Icons.today_rounded),
                        iconSize: 64,
                        color: Colors.purple[900],
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(color: Colors.deepPurple[900]),

                    Text(
                      "معلومات المدرب ",
                      style: TextStyle(
                          fontSize: 22.5,
                          //fontFamily: "Poppins-Bold",
                          letterSpacing: .6,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[900]),
                      textAlign: TextAlign.left,
                    ),

                    //here is the table ################################################################3
                    Container(
                      child: Column(children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(20),
                          child: Table(
                            defaultColumnWidth: FixedColumnWidth(108.0),
                            // border: TableBorder.all(
                            // color: Colors.white,
                            // style: BorderStyle.solid,
                            // width: 0),
                            children: [
                              TableRow(children: [
                                Container(
                                    padding: EdgeInsets.all(1.0),
                                    child: Text(
                                      document['CoachName'] +
                                          ' ' +
                                          document['CoachName2'],
                                      // ' ' +
                                      // document['Lname'],
                                      style: TextStyle(
                                          fontSize: 17.5,
                                          color: Colors.grey,
                                          height: 1.3),
                                      textAlign: TextAlign.right,
                                    )),

                                Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      ':الاسم',
                                      style: TextStyle(fontSize: 18.0),
                                      textAlign: TextAlign.end,
                                    )),

                                //Column(children: [Text('')]),
                                // Column(children: [
                                // Text('')
                              ]),
                              TableRow(children: [
                                //Column(children:[Text('')]),
                                Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      document['Neighborhood'],
                                      style: TextStyle(
                                        height: 1.49,
                                        fontSize: 16.3,
                                        color: Colors.grey,
                                      ),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    )),
                                Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      ':الحي السكني',
                                      style: TextStyle(fontSize: 18.0),
                                      textAlign: TextAlign.right,
                                    )),
                              ]),
                              // TableRow(children: [
                              // Container(
                              // padding: EdgeInsets.all(2.0),
                              // child: Text(
                              // document['Gender'],
                              // style: TextStyle(
                              // height: 1.99,
                              // fontSize: 16.37,
                              // color: Colors.grey,
                              // //height: 1
                              // ),
                              // textAlign: TextAlign.right,
                              // ),
                              // ),
                              // Container(
                              // padding: EdgeInsets.all(2.0),
                              // child: Text(
                              // ':الجنس',
                              // style: TextStyle(
                              // fontSize: 18.0,
                              // ),
                              // textAlign: TextAlign.end,
                              // )),
                              // ]),
                              // TableRow(children: [
                              // Column(children: [Text('')]),
                              // Column(children: [
                              // Text('')
                              // ]), //Column(children:[Text('')]),
                              // ]),

                              TableRow(children: [
                                Container(
                                  height: 35,
                                  padding: EdgeInsets.all(2.0),
                                  child: TextButton(
                                      style: TextButton.styleFrom(
                                          padding: const EdgeInsets.all(-90),
                                          textStyle: TextStyle(
                                            fontSize: 16,
                                            // color: Colors.grey,
                                            decoration:
                                                TextDecoration.underline,
                                          )),
                                      onPressed: () {
                                        //const Text('Gradient',);
                                        launch("tel://$ph");
                                      },
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          document['CoachPhone'],
                                        ),
                                      )),
                                ),
                                Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      ':رقم الجوال',
                                      style: TextStyle(fontSize: 18.0),
                                      textAlign: TextAlign.end,
                                    )),
                              ]),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        // Row(children: <Widget>[
                        // Padding(
                        // padding: EdgeInsets.symmetric(
                        // horizontal: 12, vertical: 5)),
                        // Center(child: Accept(document)),
                        // SizedBox(width: 24),
                        // Center(
                        // child: Reject(document, document['Cid'],
                        // document['DateTime']),
                        // ),
                        // ]),

                        if (document['Paid'] == 'false')
                          ElevatedButton(
                            child: Text('الدفع'),
                            onPressed: () {
 Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => PaypalPayment(
                              onFinish: (number) async {

                                // payment done
                                print('order id: '+number);

                              },
                            ),
                          ),
                        );


                            },
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                primary: Color(0xFF6F35A5),
                                textStyle: TextStyle(fontSize: 16)),
                          )
                        else
                          Center(
                            child: Text(
                              'تم الدفع',
                              style: TextStyle(
                                  fontSize: 18.5,
                                  color: Colors.green[600],
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                      ]),
                    ),
                    ////////////////////////end of the table
                  ]),
                ),
              ),
              //),
            ]),
          ),
        ),
      ),
    );
  }

  String getArabicdays(String a) {
    switch (a.substring(19)) {
      case 'Saturday':
        return 'السبت';
      case 'Sunday':
        return 'الأحد';
      case 'Monday':
        return 'الإثنين';
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

  void nav() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return TRlessons();
        //return RequestLessonPage(icd);
      }),
    );
  }
}

Widget notPaid() => ElevatedButton(
      child: Text('الدفع'),
      onPressed: () {},

      // },
      style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          primary: Color(0xFF6F35A5),
          textStyle: TextStyle(fontSize: 16)),
    );

Widget Paid(DocumentSnapshot document) => Text('');
