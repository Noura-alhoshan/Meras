//import 'dart:html';
//import 'package:path/path.dart';
//import 'package:path/path.dart' as Path; 
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meras/screen/authenticate/NotApproaved.dart';
import 'package:meras/screen/authenticate/sign_in.dart';
import 'package:meras/screen/home/BaseAlertDialog.dart';
import 'package:meras/services/database.dart';
import 'package:meras/models/MyUser.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meras/screen/authenticate/reset.dart'; 



//BuildContext get context => null; 


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
//final FirebaseFirestore fuser = FirebaseFirestore.instance;
static int count =0;
  
  // create MyUser obj based on firebase user
  MyUser? _userFromFirebase(User? user) { 
    return user != null ? MyUser(uid: user.uid) : null;
  } 


  // auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
    //.map((User user) => _userFromFirebase(user));
  }



  //  Future registerWithEmailAndPassword(String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  //     User? user = result.user;
  //     return _userFromFirebase(user);
  //   } catch (error) {
  //     print(error.toString());
  //     return null;
  //   } 
  // }

// Future nav() async {
//     Navigator.pop(context); //nn
//   } 

 

 Future registerAsTrainee(String Fname, String Lname, String email, String password, int age,
      String phoneNumber, String neighborhood, String gender ) async {

    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User? user1 = result.user;
    DatabaseService(uid: user1!.uid).updateTraineeData(Fname,Lname,email,password,age,phoneNumber,neighborhood,gender);
  }

  Future registerAsCoach(String Fname, String Lname,String email,String password, int age,
        String phoneNumber, String neighborhood,String description, String gender, String status, String url) async {

    CollectionReference coachesCollection = FirebaseFirestore.instance.collection('Coach');
    Map<String,dynamic> traineeDataDemo = {
      "Fame": Fname,
      'Lame': Lname,
      'Email': email,
      'Pass': password,
      'Age': age,
      'Phone Number': phoneNumber,
      'Discerption': description,
      'Neighborhood': neighborhood,
      'Gender': gender,
      'Status': status,
      'URL': url,
    };
    coachesCollection.add(traineeDataDemo);
    // User? user1 = result.user;
    // DatabaseService(uid: user1!.uid).updateCoachesData(Fname,Lname,email,password,age,phoneNumber,neighborhood,
    //     description, gender, status);
  }


  
   Future registerWithEmailAndPassword(String Fname, String Lname, String Gender, //DateTime Birth,
                              String Neigh, String Email, String Pass ) async {
     
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: Email, password: Pass);
      User? user1 = result.user; 
       DatabaseService(uid: user1!.uid).updateUserData(Fname,Lname, Gender ,Neigh ,Email,Pass);
 
  }




  //sign in 
  Future signInWithEmailAndPassword(String email, String password,BuildContext context) async {
  
    try 
    {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user; 
      return user;

    } 
    catch (error) 
    {
      FirebaseFirestore.instance.collection("Coach").get().then((querySnapshot) async {//async
     
      querySnapshot.docs.forEach((value) 
      {
        if(value.data()['Email'].toString() == email && value.data()['Status'].toString()=='P' )
        {
          count= count +1; 
        }
      } 
      );
            if (count > 0)  {
                  //UserCredential result = await _auth.signInWithEmailAndPassword(email: "DefaultEmail@gmail.com", password: "1234567");
                  //User? user3 = result.user; 
                  var baseDialog = BaseAlertDialog(
              title: "",
              content: "  :عزيزي المدرب\n لا يمكنك تسجيل الدخول لانه لم يتم توثيق حسابك بعد"+"\n ملاحظة: يتم التوثيق حسب صلاحية رخصة قيادتك",
              yesOnPressed: ()  {
                
                Navigator.pop( context, 
                   MaterialPageRoute(builder: (context) => SignIn()),);
                    //Navigator.of(context, rootNavigator: true).pop('dialog');
                   
                   },
                
              noOnPressed: () {
                //Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              yes: "إغلاق",
              no: "");
          showDialog(context: context, builder: (BuildContext context) => baseDialog); 
               // Navigator.push( context, 
               // MaterialPageRoute(builder: (context) => notApproaved()), );
              // return user3; 
       } else 
      return null;
      }
   );
    } 
    
 count=0;
    
  }


//    Future isallowed(String email, String password,BuildContext context) async  {
//      //glovar =1;
//     FirebaseFirestore.instance.collection("users").get().then((querySnapshot) async {//async
     
//       querySnapshot.docs.forEach((value) 
//       {
//         if(value.data()['Email'].toString() == email && value.data()['Status'].toString()=='D' )
//         {
//           //glovar=glovar+1; 
//           count= count +1; 
//           // print("in auth");
//           // print(change);
//         }
//       } 
//       );
//      // print("in auth");
//             if (count > 0)  {       
//                 //glovar=0;
//                 Navigator.push( context, 
//                 MaterialPageRoute(builder: (context) => notApproaved()),
//   );
//        } 
//         //else print("Im in else");
//      //else return signInWithEmailAndPassword( email, password);
//   // {
//   //       try 
//   //   {
//   //     UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
//   //     User? user = result.user; 
//   //     glovar=1;
//   //     return user;
//   //   } 
//   //   catch (error) 
//   //   {
//   //     print(error.toString());
//   //      glovar=1;
//   //     return null;
//   //   } }
//    }
//    );

// count=0;

// }




  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }



  Future showError() async  {
  dynamic res;
  FirebaseAuth.instance
  .userChanges()
  .listen((User? user) {
    if (user == null) { res = 1;}
    else {print('im in elsssse'); res= 2 ;}
  
 },
 
 ); return res; 
 }

}