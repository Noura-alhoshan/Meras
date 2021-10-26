import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:intl/intl.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/ADpages/coachProfile_admin.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Admin/widget/button_widget.dart';
//import 'package:meras/screen/Coach/Cpages/BackgroundC.dart';
import 'package:meras/screen/home/BaseAlertDialog.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'SendRequest.dart';

class CoachDate extends StatefulWidget {
  @override
  _CoachDate createState() => _CoachDate();
}

class _CoachDate extends State<CoachDate> {
  late DateTime date;
  late TimeOfDay time;
  late DateTime dateTime;
  late DateTime day;

  final FirebaseAuth auth = FirebaseAuth.instance;
  //CollectionReference AvaDates = FirebaseFirestore.instance.collection('Coach');

  ///first null?
  @override
  Widget build(BuildContext context) {
    // final User? user = auth.currentUser;
    // final uid = user!.uid;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Coach')
              .where(FieldPath.documentId,
                  isEqualTo: 'rR3m3ViSYcO21IV4va4Xb41XFuz2') //widget.id
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Loading(); //it was text 7.....
            return ListView.builder(
              // controller: _scrollController,

              //  physics: const NeverScrollableScrollPhysics(), //<--here
              itemCount: 1,

              itemBuilder: (context, index) =>
                  _build(context, (snapshot.data!).docs[0]),
            );
          }),
    );
  }
}

//    1. show the coach info

Widget _build(BuildContext context, DocumentSnapshot document) {
  final String ph = document['Phone Number'];
  Image im = new Image.network(
    document['URL'],
    height: 230.0,
    width: 250.0,
  );
  return BackgroundA(
    child: Container(
      height: 900,
      child: SingleChildScrollView(
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
          //  height: 1200,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 00),
          child: Column(children: <Widget>[
            Text(
              document['Fname'] + ' ' + document['Lname'] + '  ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 23,
                  // color: kPrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              document['Email'],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(
                // height: 10,
                ),
            TextButton(
                child: Text(document['Phone Number'],
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    )),
                onPressed: () {
                  launch("tel://$ph");
                }),
            Divider(color: Colors.deepPurple[900]),
            Container(
              child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: Table(
                    defaultColumnWidth: FixedColumnWidth(120.0),
                    border: TableBorder.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 0),
                    children: [
                      TableRow(children: [
                        Column(children: [Text('')]),
                        Column(children: [
                          Text('')
                        ]), //Column(children:[Text('')]),
                      ]),
                      TableRow(children: [
                        //Column(children:[Text('')]),

                        Container(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            document['Gender'],
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),

                        Container(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              'الجنس',
                              style: TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.end,
                            )),
                      ]),
                      TableRow(children: [
                        Column(children: [Text('')]),
                        Column(children: [
                          Text('')
                        ]), //Column(children:[Text('')]),
                      ]),
                      TableRow(children: [
                        //Column(children:[Text('')]),
                        Container(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              document['Age'].toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.right,
                            )),
                        Container(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              'العمر',
                              style: TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.right,
                            )),
                      ]),
                      TableRow(children: [
                        Column(children: [Text('')]),
                        Column(children: [
                          Text('')
                        ]), //Column(children:[Text('')]),
                      ]),
                      TableRow(children: [
                        // Column(children:[Text('')]),
                        Container(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              document['Neighborhood'],
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                              textAlign: TextAlign.right,
                            )),
                        Container(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              'المنطقة السكنية',
                              style: TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.right,
                            )),
                      ]),
                    ],
                  ),
                ),
              ]),
            ),

            //iterate over the subcollection
            Container(
              child: SingleChildScrollView(
                child: BackgroundA(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Coach')
                          .doc('rR3m3ViSYcO21IV4va4Xb41XFuz2') //widget.id
                          .collection('Dates')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return const Text('loading 7 ...');
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

//    2. show the coach dates

Widget _buildListItem(
  BuildContext context,
  String iid,
  String fname,
  String lname,
  String phone,
  String n,
  DocumentSnapshot document,
) {
  return SingleChildScrollView(
    child: Container(
      height: 170,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),

      ///
      child: Card(
        //  elevation: 4.0,
        child: Column(
          children: [
            Container(
              decoration: new BoxDecoration(color: Colors.deepPurple[100]),
              child: ListTile(
                title: Text('يوم ' + document['DateTime'].toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(height: 1.5, fontSize: 11)),
                //subtitle: Text(subheading),
                leading: IconButton(
                    icon: Image.asset("assets/images/acc.png"),
                    iconSize: 30,
                    onPressed: () async {
                      var baseDialog = BaseAlertDialog(
                          title: "",
                          content: "هل أنت متأكد من حجز الموعد؟",
                          //او نخليها هل انت متاكد من حجز الدرس؟

                          yesOnPressed: () {
                            print(document.id);
                            Request1(iid, fname, lname, phone, n,
                                document['DateTime'], document.id);
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
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
                        //   getArabicdays(document['DateTime'].toString()) +
                        ' ' +
                        document['DateTime'].toString().substring(0, 10) +
                        '\n'
                            '  الوقت: ' +
                        document['DateTime'].toString().substring(11, 16) +
                        ' صباحا '
                    : 'يوم ' +
                        document['DateTime'].toString() +
                        ' ' +
                        document['DateTime'].toString().substring(0, 10) +
                        '\n'
                            '  الوقت: ' +
                        document['DateTime'].toString().substring(11, 16) +
                        ' مساءً ',
                style: TextStyle(height: 1.5, fontSize: 19),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),

      ///
    ),
  );
}










//  Future<void> deleteDate(String a) {
//    FirebaseAuth auth = FirebaseAuth.instance;
//     final User? user = auth.currentUser;
//     final uid = user!.uid;
//     CollectionReference AvaDates = FirebaseFirestore.instance.collection('Coach');
//     return AvaDates.doc(uid)
//         .collection('Dates')
//         .doc(a)
//         .delete()
//         .then((value) => print("time deleted"))
//         .catchError((error) => print("Failed to delete time: $error"));
//   }


// Widget profile(BuildContext context, String coachid) {
//         return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'معلومات المدرب',
//           textAlign: TextAlign.center,
//         ),
//         backgroundColor: Colors.deepPurple[100],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('Coach')
//               .where(FieldPath.documentId, isEqualTo: coachid)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) return Loading(); //it was text 7.....
//             return ListView.builder(
//              // controller: _scrollController,

//               //  physics: const NeverScrollableScrollPhysics(), //<--here
//               itemCount: 1,

//               itemBuilder: (context, index) =>
//                   _build(context, (snapshot.data!).docs[0]),
//             );
//           }),
//     );
//   }






 // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   drawer: NavDrawer(),
    //   appBar: AppBar(
    //     title: Text(''
    //         // textAlign: TextAlign.center,
    //         ),
    //     backgroundColor: Colors.deepPurple[100],
    //   ),
    //   /*
    //   body: Container(
    //     child: Center(
    //       child: Date(),
    //     ),
    //   ), */

    //   //   /*
    //   body: Container(
    //     child: BackgroundA(
    //       child: SafeArea(
    //         child: Column(
    //           children: <Widget>[
                // Padding(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: 30, vertical: 20)),

                // Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5)),
            //   profile(context, 'rR3m3ViSYcO21IV4va4Xb41XFuz2'),//widgit.id
                // Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5)),
                // // buildCard(),
                // Text(
                //   'المواعيد المتاحة خلال الاسبوع القادم',
                //   style: TextStyle(height: 2, fontSize: 18),
                //   textAlign: TextAlign.right,
                // ),
                //Padding(
                //     padding:
                //          EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                /*Column(children: <Widget>[
        Expanded(
          /*  child: Center(
            child: Container(
              child: SingleChildScrollView(
                // child: BackgroundA(
                child: Date(),
              ),
            ),
          ),
       */ // ),
          child: Container(
            child: SingleChildScrollView(
              child: BackgroundA(
                child: Row(children: <Widget>[
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5)),
                  Center(child: Date()),
                  SizedBox(width: 24),
                  Center(child: Date()),
                ]
                    // child: Date(),
                    ),
              ),
            ),
          ),
        ),
                             
        // Container(height: 40, color: Colors.grey),
        */

               // Expanded(
      //              Container(
      //               child: SingleChildScrollView(
      //                 child: BackgroundA(
      //                   child: StreamBuilder<QuerySnapshot>(
      //                       stream: FirebaseFirestore.instance
      //                           .collection('Coach')
      //                           .doc('rR3m3ViSYcO21IV4va4Xb41XFuz2')//widget.id
      //                           .collection('Dates')
      //                           .snapshots(),
      //                       builder: (context, snapshot) {
      //                         if (!snapshot.hasData)
      //                           return const Text('loading 7 ...');
      //                         return ListView.builder(
      //                           physics:
      //                               const NeverScrollableScrollPhysics(), //<--here

      //                           itemCount: snapshot.data!.docs.length,
      //                           itemBuilder: (context, index) => _buildListItem(
      //                               context, (snapshot.data!).docs[index]),
      //                         );
      //                       }),
      //                 ),
      //               ),
      //             ),
                
    //          ],
    //        ),
    //       ),
    //     ),
    //  ),
    // );
    //  ]),
    //  );



  //  Container(
                  //          padding: EdgeInsets.all(2),
                  //          child:
                  // Text(
                  //   'الوصف',
                  //   style: TextStyle(fontSize: 20.0),
                  //   textAlign: TextAlign.end,
                  // )),
                  // //   ]),
                  // // ]),
                  // // TableRow(children: [
                  // //   Column(children: [
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 22),
                  //   child: Text(document['Discerption'],
                  //       //textDirection: TextDirection.rtl,
                  //       style: TextStyle(fontSize: 18, color: Colors.grey)),
                  // ),

                  // SizedBox(
                  //   height: 24,
                  // ),
                  // Row(children: <Widget>[
                  //   Padding(
                  //       padding:
                  //           EdgeInsets.symmetric(horizontal: 30, vertical: 5)),
                  //  // Center(child: Accept(document)),
                  //   //SizedBox(width: 24),
                  //   //Center(child: Reject(document)),
                  // ]),
