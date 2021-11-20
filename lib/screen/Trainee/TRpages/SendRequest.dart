import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meras/components/rounded_button.dart';
import 'package:meras/screen/home/BaseAlertDialog.dart';
import 'package:meras/screen/Trainee/TRpages/acceptedLessons.dart';
import 'package:meras/screen/Trainee/TRpages/rejectedLessons.dart';
import 'package:meras/screen/Trainee/TRpages/pendingLessons.dart';
import 'package:random_string/random_string.dart';
import '../../../constants.dart';
//check the pull request

late DateTime day;
late DateTime dateTime;
late String Tname;
late String Tgender;
late int Tage;
late String Tphone;
//DateTime docDateTime = DateTime.parse(FieldValue.serverTimestamp());//DateTime.parse(DateTime.now());

class RequestButton extends StatelessWidget {
  //late String Tid; // FirebaseAuth auth1 = FirebaseAuth.instance;      auth1.currentUser!.uid

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
        text: "حجز",
        press: () {
          // var baseDialog = BaseAlertDialog(
          //   title: "",
          //   content: "هل أنت متأكد من حجز الموعد؟",
          //     //او نخليها هل انت متاكد من حجز الدرس؟

          //   yesOnPressed: () {
          //     Request1('0000', '0000', '0000', '000000000000000000000', '0000', '0000','mmm'); //change the parameters ;)

          //       Navigator.of(context, rootNavigator: true).pop('dialog');
          //     },
          //     noOnPressed: () {
          //       Navigator.of(context, rootNavigator: true).pop('dialog');
          //     },
          //     yes: "نعم",
          //     no: "لا");
          // showDialog(
          //     context: context, builder: (BuildContext context) => baseDialog);
        });
  }
}

Request1(
  //coach info
  String
      Cid, //document['id'] Noura will send you this id from the list, so make it as an attribute to the class. See class coachProfile_admin.dart for more info
  String CoachName, //document['Fname']
  String CoachName2, // document['Lname']
  String Cphone, //document['Phone Number']
  String Neighborhood,
  String price, //document['Neighborhood']
  String DateNTime,
  String Dateid,
  double Rate,
  //document['DateTime'] ? I'm not sure if this how you read from subcollection
) async {
  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);
  String dd = DateFormat('MM/dd/yyyy').format(date);

  FirebaseAuth traineeNow = FirebaseAuth.instance;
  User? usernow = FirebaseAuth.instance.currentUser;

  await FirebaseFirestore.instance
      .collection('trainees')
      .doc(traineeNow.currentUser!.uid)
      .get()
      .then((ds) {
    Tname = ds['Fname'] + ' ' + ds['Lname'];
    Tphone = ds['Phone Number'];
    Tgender = ds['Gender'];
    Tage = ds['Age'];
    //print(Tname);
  }).catchError((e) {
    print(e);
  });

  CollectionReference Collection =
      FirebaseFirestore.instance.collection('Requests');
  String lid = randomAlpha(20);
  Map<String, dynamic> RequestDataDemo = {
    //coach info
    'Cid': Cid,
    "CoachName": CoachName,
    'CoachName2': CoachName2,
    'CoachPhone': Cphone,
    'Neighborhood': Neighborhood,
    'Price': price,
    // trainee info
    'Tid': usernow!.uid,
    'Tname': Tname,
    'TAge': Tage,
    'TPhone Number': Tphone,
    'TGender': Tgender,

    //request info
    'reqDate': FieldValue.serverTimestamp(),
    'Status': 'P',
    'DateTime': DateNTime,
    'Lid': lid, //Lesson id, Leena needs it
    'Paid': 'false',
    'TRate': 0,
    'IsRate': 'false',
  };
  Collection.doc(lid).set(RequestDataDemo);

// await  FirebaseFirestore.instance.collection('Coach').doc(Cid).collection("Dates").get().then((value) {
//       value.docs.forEach((element) {
//         FirebaseFirestore.instance.collection('Coach')
//             .doc('rR3m3ViSYcO21IV4va4Xb41XFuz2')//Cid
//             .collection("Dates")
//             //.where('DateTime', isEqualTo: DateNTime)
//             .doc(element.id)

//             .delete()
//             .then((value) => print(element.id));
//             print('hhhhhhhhhhhhhhhhhhhhhhhhh');
//       });
//     });
//FieldPath fff;
  FirebaseFirestore.instance
      .collection('Coach')
      .doc(Cid)
      .get()
      .then((DocumentSnapshot em) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Coach');

    users.doc(Cid).update({'CountDate': em['CountDate'] - 1});
  });
  await FirebaseFirestore.instance
      .collection('Coach')
      .doc(Cid)

      ///$Cid/Dates
      .collection('Dates')
      .doc(Dateid)
      .delete()
      .then((value) => print("time deleted"))
      .catchError((error) => print("Failed to delete time: $error"));
  // print(dsk.docs[1].data()) ;
//print(dsk['DateTime']);
  //if (value['DateTime']==DateNTime)
}
