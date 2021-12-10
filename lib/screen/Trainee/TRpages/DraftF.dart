import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:intl/intl.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/components/SingleBaseAlert.dart';
import 'package:meras/screen/Admin/ADpages/coachProfile_admin.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Admin/widget/button_widget.dart';
import 'package:meras/screen/Chat/chatWidget.dart';
import 'package:meras/screen/Chat/constants.dart';
import 'package:meras/screen/Chat/screens/chat.dart';
import 'package:meras/screen/Chat/screens/dashboard_screen.dart';

import 'package:meras/screen/Trainee/TRpages/BackgroundC2.dart';
//import 'package:meras/screen/Coach/Cpages/BackgroundC.dart';
import 'package:meras/screen/home/BaseAlertDialog.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../../../constants.dart';
import 'SendRequest.dart';

class CoachDate extends StatefulWidget {
  late final String id;

  CoachDate(String icd) {
    this.id = icd;
  }

  @override
  _CoachDate createState() => _CoachDate();
}

class _CoachDate extends State<CoachDate> {
  late DateTime date;
  late TimeOfDay time;
  late DateTime dateTime;
  late DateTime day;
  

  final FirebaseAuth auth = FirebaseAuth.instance;
//    void initState() {
//     super.initState();
//   }
//   //CollectionReference AvaDates = FirebaseFirestore.instance.collection('Coach');
// void setState(Function() param0) {
// }
  ///first null?
  @override
  Widget build(BuildContext context) {
   FirebaseAuth auth2 = FirebaseAuth.instance;
    User? truser= auth2.currentUser;
    final tuid = truser!.uid;


late String tname='';
   FirebaseFirestore.instance
      .collection('trainees')
      .doc(tuid)
      .get()
      .then((ds) {
    tname = ds['Fname'] + ' ' + ds['Lname'];
  }).catchError((e) {
    print(e);
  });
late String cname='';
late String pn='';
   FirebaseFirestore.instance
      .collection('Coach')
      .doc(widget.id)
      .get()
      .then((ds) {
    cname = ds['Fname'] + ' ' + ds['Lname'];
    pn=ds['Phone Number]'];
  }).catchError((e) {
    print(e);
  });


    return Scaffold(
      extendBodyBehindAppBar: true,
      //drawer: NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
         actions: [
        Padding( padding:EdgeInsets.symmetric(horizontal: 17), 
        child: IconButton (icon: Icon (Icons.mail), color: kPrimaryColor, 
        onPressed: () 
        { 
            Navigator.of(context).push( 
              MaterialPageRoute( 
              builder: (context) => 
              Chat(
              currentUserId: tuid, 
              peerAvatar:  "https://i.postimg.cc/59D0sP2g/Female.png",
              peerId: widget.id, 
              peerName: cname,
              Cname:cname ,
              Tname: tname,
              Tid: tuid,
              Cid: widget.id,
              phone: pn,
              )               
                       ));


         },//change the phone
        ),)],
        title: Text(' حجز موعد جديد'
            // textAlign: TextAlign.center,
            ),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Coach')
              .where(FieldPath.documentId, isEqualTo: widget.id) //widget.id
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
}

// 1. show the coach info

Widget _build(BuildContext context, DocumentSnapshot document) {
  //print("daaay");
  
   FirebaseAuth auth2 = FirebaseAuth.instance;
    User? truser= auth2.currentUser;
    final tuid = truser!.uid;
  final String ph = document['Phone Number'];
  
  return BackgroundA(
    child: Container(
      height: 900,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 00),
          child: Column(children: <Widget>[
            Text(' '),
            document['Gender'] == 'أنثى'
                ? Image.asset(
                    "assets/images/Female.png",
                    height: 100.0,
                    width: 100.0,
                  )
                : Image.asset(
                    "assets/images/driver-male.jpg",
                    height: 100.0,
                    width: 100.0,
                  ),
            Text(' '),

            Row(children: [
              Center(child:
              Text(
                '                           ' +document['Rate'].toStringAsFixed(2),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    // color: kPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),),
              Icon(
                Icons.star_rate,
                color: Colors.orange,
                size: 30.0,
              ),
              Center(child:
              Text(
                ' ' + document['Fname'] + ' ' + document['Lname'] + ' ',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 23,
                    // color: kPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),)
            ]),

            Row(
              children: [
                Text(' '),
                Text(
                   document['Price'] + ' ريال '+ '                   ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,

                    //decoration: TextDecoration.underline,
                  ),
                  textDirection: ui.TextDirection.rtl,
                  textAlign: TextAlign.right,

                  // textDirection:,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text( ' ' +'  :سعر التدريب لساعتين',
                      style: TextStyle(fontSize: 18, color: Colors.grey[700])),
                ),
              ],
            ),

            // SizedBox(
            //     // height: 10,
            //     ),

            Row(
              children: [
                Text(' '),
                TextButton(
                    child: Text(
                      document['Phone Number']+ '                        ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    onPressed: () {
                      launch("tel://$ph");
                     }),
                    
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(':للتواصل',
                      style: TextStyle(fontSize: 18, color: Colors.grey[700])),
                ),
              ],
            ),

            Center(
                child: Card(
              color: Colors.deepPurple[50],
              child: Padding(
                  padding: EdgeInsets.only(
                      top: 6.0, left: 2.0, right: 6.0, bottom: 6.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      accentColor: Colors.deepPurple[100],
                      unselectedWidgetColor: kPrimaryColor.withOpacity(0.8),
                    ),
                    child: ExpansionTile(
                      iconColor: kPrimaryColor,
                      backgroundColor: Colors.deepPurple[50],
                      title: Text(
                        'معلومات المدرب',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 18,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(6),
                                    1: FlexColumnWidth(3),
                                    //2: FlexColumnWidth(4),
                                  },
                                  defaultColumnWidth: FixedColumnWidth(167.0),
                                  border: TableBorder.all(
                                      color: Colors.white,
                                      style: BorderStyle.none,
                                      width: 0),
                                  children: [
                                    /*
                                    TableRow(children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(1.0),
                                        child: Text(
                                            document['Rate'].toStringAsFixed(2),
                                            style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.right),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2.0),

                                        child: Text(
                                          ' :التقييم',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      )
                                    ]), */
                                    TableRow(children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(1.0),
                                        child: Text(document['Gender'],
                                            style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.right),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(
                                          ' :الجنس',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      )
                                    ]),
                                    TableRow(children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(1.0),
                                        child: Text(document['Age'].toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              //height: 1.49,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.right),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(
                                          ' :العمر',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      )
                                    ]),
                                    TableRow(children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(1.0),
                                        child: Text(document['Neighborhood'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              //height: 1.49,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.right),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(
                                          ' :المنطقة السكنية',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      )
                                    ]),
                                    TableRow(children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(1.0),
                                        child: Text(document['Email'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              height: 1.4,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.right),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(
                                          ' :البريد الإلكتروني',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      )
                                    ]),
                                    TableRow(children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(1.0),
                                        child: Text(document['Discerption'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              //height: 1.49,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.right),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(
                                          ' :الوصف',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      )
                                    ]),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
              elevation: 6,
              shadowColor: Colors.deepPurple[500],
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Colors.white, width: 1)),
            )),

            Divider(color: Colors.deepPurple[900]),

            Text('مواعيد التدريب المتاحة للمدرب',
                style: TextStyle(
                    fontSize: 23,
                    // color: kPrimaryColor,
                    fontWeight: FontWeight.bold)),

            //iterate over the subcollection
            Container(
              child: SingleChildScrollView(
                child: BackgroundC2(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Coach')
                          .doc(document.id) //widget.id
                          .collection('Dates')
                          .orderBy('DateTime', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return Loading();
                        return ListView.builder(
                          physics:
                              const NeverScrollableScrollPhysics(), //<--here

                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) => _buildListItem(
                              context,
                              document['ID'],
                              document['Fname'],
                              document['Lname'],
                              document['Phone Number'],
                              document['Neighborhood'],
                              document['Price'],
                              document['Rate'],
                              (snapshot.data!).docs[index]),
                        );
                      }),
                ),
              ),
            ),
          ]),
        ),
      ),
    ),
  );
}



// 2. show the coach dates

Widget _buildListItem(
  BuildContext context,
  String iid,
  String fname,
  String lname,
  String phone,
  String n,
  String price,
  double Rate,
  DocumentSnapshot document,
) {
  return SingleChildScrollView(
    child: Container(
      height: 160,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),

      ///
      child: Card(
        //elevation: 4.0,
        child: Column(
          children: [
            Container(
              decoration: new BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                  color: Colors.deepPurple[100]),
              child: ListTile(
                title: Text(
                    'يوم ' + getArabicdays(document['DateTime'].toString()),
                    textAlign: TextAlign.right,
                    style: TextStyle(height: 1.5, fontSize: 16)),
                //subtitle: Text(subheading),
                leading: ElevatedButton(
                    child: Text('حجز'),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: Color(0xFF6F35A5),
                        textStyle: TextStyle(fontSize: 16)),
                    onPressed: () async {
                      var baseDialog = BaseAlertDialog(
                          title: "",
                          content: "هل أنت متأكد من حجز الموعد؟",
                          //او نخليها هل انت متاكد من حجز الدرس؟

                          yesOnPressed: () {
                            print(document.id);
                            Request1(iid, fname, lname, phone, n, price,
                                document['DateTime'], document.id, Rate);
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                            var baseDialog2 = SignleBaseAlertDialog(
                              title: '',
                              content:
                                  "تم طلب موعد الدرس بنجاح، يمكنك مشاهدته في قائمة الدروس قيد الانتظار",
                              yesOnPressed: () async {
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                              },
                              yes: "إغلاق",
                            );
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => baseDialog2);
                          },
                          noOnPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                          },
                          yes: "نعم",
                          no: "لا");
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => baseDialog);
                    }),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.centerRight,
              child: Text(
                document['DateTime'].toString().substring(17, 19) == 'AM'
                    ? 'التاريخ:' +
                        //getArabicdays(document['DateTime'].toString()) +
                        ' ' +
                        document['DateTime'].toString().substring(0, 10) +
                        '\n'
                            ' الوقت: ' +
                        document['DateTime'].toString().substring(11, 16) +
                        ' صباحا '
                    : 'التاريخ:' +
                        //document['DateTime'].toString() +
                        ' ' +
                        document['DateTime'].toString().substring(0, 10) +
                        '\n'
                            ' الوقت: ' +
                        document['DateTime'].toString().substring(11, 16) +
                        ' مساءً ',
                style: TextStyle(height: 1.5, fontSize: 14.8),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        elevation: 6,
        shadowColor: Colors.deepPurple[500],
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.transparent, width: 1)),
      ),

      ///
    ),
  );
}

void setday(String a) {
  switch (a) {
    case 'Saturday':
      // setState(() {
      //  selectedDay = 'السبت';
      // });
      //   print("y " + selectedDay);

      break;
    default:
  }
  print('are you workung in setday?');
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
