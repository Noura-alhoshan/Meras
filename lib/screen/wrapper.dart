import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/screen/Navigation/ADpages/ADhome.dart';
import 'package:meras/screen/Navigation/TRpages/TRhome.dart';
import 'package:meras/screen/authenticate/NotApproaved.dart';
import 'package:meras/screen/authenticate/sign_in.dart';
import 'package:meras/screen/coachProfile_admin/widget/profile_widget.dart';
import 'package:meras/screen/home/home.dart'; 
import 'package:meras/screen/authenticate/authenticate.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'package:provider/provider.dart';
import 'package:meras/models/MyUser.dart';

import 'authenticate/Verify.dart';
import 'coachProfile_admin/coachProfile_admin.dart';
import 'coachProfile_admin/pr.dart';
import 'coachProfile_admin/profileDraft.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key); 

  @override
  Widget build(BuildContext context) {

   //signed in or not? 2 options
   final user = Provider.of<MyUser?>(context);// i added ? even tho there was no error 
    //print(user);//////////////////////////////////////////////////
 FirebaseAuth auth = FirebaseAuth.instance;
 User? getid = auth.currentUser;
dynamic userid = getid?.uid;
//bool yesno= false;

 if (user == null){
      return authenticate();//homescreen 
    } 

 if (getid!.emailVerified == false) return Verify();

// FirebaseFirestore.instance
//               .collection('Coach')
//               .where(FieldPath.documentId, isEqualTo:userid).get().then((querySnapshot) {
//      querySnapshot.docs.forEach((value)
//       {
//         if (value.data()['Status'].toString()=='P')
//             yesno=true;
// }


// );


// if (yesno) return TestScreen(userid); });

// if (yesno) return TestScreen(userid);
else

   return home();
    // if (userid)
    // else
      //TestStest ('BsFlJ1MMwSVHMdEfRvri');
      //TestScreen1 ('02yfq71X0xg5bGKYOj60');//('02yfq71X0xg5bGKYOj60');  //KxEvQXNr9smM955QCQDW

       //home();//userId: userid,);
    }

}