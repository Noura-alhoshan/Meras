import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Trainee/TRcategory.dart';

import 'package:meras/screen/authenticate/NotApproaved.dart';
import 'package:meras/screen/authenticate/sign_in.dart';

import 'package:meras/screen/home/home.dart';
import 'package:meras/screen/authenticate/authenticate.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'package:meras/screen/home/rej.dart';
import 'package:meras/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:meras/controllers/MyUser.dart';

import 'Admin/ADcategory.dart';
import 'Admin/ADpages/ADhome.dart';
import 'Trainee/TRpages/TRhome.dart';
import 'Verify.dart';
import 'home/Chome.dart';

Future<bool> isTrainee(dynamic userid) async {
  print(userid);
  bool yesno = false;
  await FirebaseFirestore.instance
      .collection('trainees')
      .where(FieldPath.documentId, isEqualTo: userid)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((value) async {
      if (value.data()['Type'].toString() == 'Trainee') {
        yesno = true;
        await checkToken(value.data()['notificationTokens'] ?? [],
            value.data()['ID'], 'trainees');
      }
    });
  });
  if (yesno)
    return true;
  else
    return false; //2
}

Future<bool> isAdmin(dynamic userid) async {
  bool yesno = false;
  await FirebaseFirestore.instance
      .collection('Admin')
      .where(FieldPath.documentId, isEqualTo: userid)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((value) {
      if (value.data()['Type'].toString() == 'Admin') yesno = true;
    });
  });
  if (yesno)
    return true;
  else
    return false; //2
}

Future<bool> isCoachA(dynamic userid) async {
  bool yesno = false;
  await FirebaseFirestore.instance
      .collection('Coach')
      .where(FieldPath.documentId, isEqualTo: userid)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((value) async {
      if (value.data()['Type'].toString() == 'Coach' &&
          value.data()['Status'].toString() == 'A') {
        yesno = true;
        await checkToken(value.data()['notificationTokens'] ?? [],
            value.data()['ID'], 'Coach');
      }
    });
  });
  if (yesno)
    return true;
  else
    return false; //2
}

Future<void> checkToken(List<String> tokens, String userId, String type) async {
  FirebaseMessaging.instance.getToken().then((token) async {
    if (!tokens.contains(token)) {
      tokens.add(token!);
      await FirebaseFirestore.instance
          .collection(type)
          .doc(userId)
          .update({'notificationTokens': tokens});
    }
  });
}

Future<bool> isCoachP(dynamic userid) async {
  bool yesno = false;
  await FirebaseFirestore.instance
      .collection('Coach')
      .where(FieldPath.documentId, isEqualTo: userid)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((value) {
      if (value.data()['Type'].toString() == 'Coach' &&
          value.data()['Status'].toString() == 'P') yesno = true;
    });
  });
  if (yesno)
    return true;
  else
    return false; //2
}

class Wrapper extends StatelessWidget {
  Wrapper();

  AuthService aut = AuthService();

  Widget build(
    BuildContext context,
  ) {
    final Puser = Provider.of<MyUser?>(context);
    if (Puser == null) return authenticate();
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    dynamic userid = user!.uid;
    if (user.emailVerified == false)
      return Verify(); ///////////////////////////////////////////
    else
      return _build(context);
  }

// class _HomePageState extends State<home> {
//   void initState() {
//     super.initState();
//   }
  @override
  Widget _build(
    BuildContext context,
  ) {
    //final Puser = Provider.of<MyUser?>(context);
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    dynamic userid = user!.uid;

    return FutureBuilder<List<bool>>(
        future: Future.wait([
          //isNull(context),
          isTrainee(userid), // Future<bool> firstFuture() async {...}
          isAdmin(userid),
          isCoachA(userid),
          isCoachP(userid) // Future<bool> secondFuture() async {...}
          //... More futures
        ]),
        builder: (
          context,
          // List of booleans(results of all futures above)
          AsyncSnapshot<List<bool>> snapshot,
        ) {
          // Check hasData once for all futures.
          if (!snapshot.hasData) {
            return Loading();
          }

          if (snapshot.data![0])
            return TRcategory();
          else if (snapshot.data![1])
            return ADcategory();
          else if (snapshot.data![2])
            return Chome();
          else if (snapshot.data![3])
            return notApproaved();
          else
            return Rhome();
          // Access first Future's data:
          // snapshot.data[0]

          // Access second Future's data:
          // snapshot.data[1]
        });
  }
}

//  class Wrapper extends StatelessWidget {
//   const Wrapper({Key? key}) : super(key: key);

//   @override
//  Widget build(BuildContext context)  {
//     final user = Provider.of<MyUser?>(context); // i added ? even tho there was no error
//     //print(user);//////////////////////////////////////////////////
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? getid = auth.currentUser;
//     dynamic userid = getid?.uid;
// bool yesno=true;
//      if (user == null) {
//        print ('im here in null');
//       return authenticate(); //homescreen
//      }

// //     if (getid!.emailVerified == false){
// //       print ('im here in not');
// //       return Verify();
// //  }

//   else
//         if (isTrainee(userid))
//         return Thome();

//   else
//         if (isAdmin(userid))
//         return home();

//   else
//     print ('im here in else home');
//       return Chome();
//   }
//  }

// // Future.delayed(Duration(seconds: 1),isTrainee () {
