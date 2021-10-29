import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meras/components/rounded_button.dart';
import 'package:meras/screen/home/BaseAlertDialog.dart';
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
          var baseDialog = BaseAlertDialog(
              title: "",
              content: "هل أنت متأكد من حجز الموعد؟",
              //او نخليها هل انت متاكد من حجز الدرس؟

              yesOnPressed: () {
                Request1(
                    'rR3m3ViSYcO21IV4va4Xb41XFuz2',
                    '0000',
                    '0000',
                    '000000000000000000000',
                    '0000',
                    '0000',
                    'mmm'); //change the parameters ;)

                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              noOnPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              yes: "نعم",
              no: "لا");
          showDialog(
              context: context, builder: (BuildContext context) => baseDialog);
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
  String Neighborhood, //document['Neighborhood']
  String DateNTime,
  String
      Dateid, //document['DateTime'] ? I'm not sure if this how you read from subcollection
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

    // trainee info
    'Tid': usernow!.uid,
    'Tname': Tname,
    'TAge': Tage,
    'TPhone Number': Tphone,
    'TGender': Tgender,

    //request info
    'reqDate': dd,
    'Status': 'P',
    'DateTime': DateNTime,
    'Lid': lid, //Lesson id, Leena needs it
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

//    print(
// //DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch));

/// method 6
// String getText() {
//   return DateFormat('MM/dd/yyyy hh:mm aa').format(dateTime);
//   // '${dateTime.day}/${dateTime.month}/${dateTime.year}  ' +
//   //     ' ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
// }

// /// method 7
// String getday() {
//   day = dateTime;
//   return DateFormat('EEEE').format(day);
//   // '${dateTime.day}/${dateTime.month}/${dateTime.year}  ' +
//   //     ' ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
// }

//FirebaseAuth auth1 = FirebaseAuth.instance;
//TraineeData trainee= TraineeData(uid: '') ;
// FirebaseFirestore.instance
//             .collection('trainees')
//             .doc(auth1.currentUser!.uid)
//             .get()
//             .then((value);

//FirebaseFirestore.instance.collection("trainess").doc('b6J60NW8fEU2bVWoFETnRX0HyYE3').get().then((value) {//async

// trainee.uid= value.data()!['ID'].toString();

// trainee.Tname= value.data()!['Fname'].toString() + ' '+value.data()!['Lname'].toString() ;
// trainee.Age= value.data()!['Age'];
// trainee.Gender= value.data()!['Gender'].toString();
// trainee.Phone= value.data()!['Phone Number'].toString();

// });

//print(usernow!.email);
// print(usernow!.displayName ) ;
//print(trainee.Phone);

//trainee info
//   String Tid, // FirebaseAuth auth1 = FirebaseAuth.instance;      auth1.currentUser!.uid
//   String Tname,
//   String Tgender,
//   String Tage,
//   String Tphone,
//
