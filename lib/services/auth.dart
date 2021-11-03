import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meras/screen/authenticate/sign_in.dart';
import 'package:meras/screen/home/BaseAlertDialog.dart';
import 'package:meras/services/database.dart';
import 'package:meras/controllers/MyUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore fuser = FirebaseFirestore.instance;
  // create MyUser obj based on firebase user
  static int count =0;
  MyUser? _userFromFirebase(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
    //.map((User user) => _userFromFirebase(user));
  }

  //sign up ############ testing version until Haifa implement it

  // Future registerWithEmailAndPassword(
  //     String Fname,
  //     String Lname,
  //     String Gender, //DateTime Birth,
  //     String Neigh,
  //     String Email,
  //     String Pass) async {
  //   //try {
  //   UserCredential result = await _auth.createUserWithEmailAndPassword(
  //       email: Email, password: Pass);
  //   User? user1 = result.user;
  //   // create a new document for the user with the uid
  //   DatabaseService(uid: user1!.uid)
  //       .updateUserData(Fname, Lname, Gender, Neigh, Email, Pass);
  //   //   return _userFromFirebase(user1);
  //   // } catch (error) {
  //   //   print(error.toString());
  //   //   return null;
  //   // }
  // }

  Future registerAsTrainee(
      String Fname,
      String Lname,
      String email,
      String password,
      int age,
      String phoneNumber,
      String neighborhood,
      String gender) async {
        try{
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await result.user!.sendEmailVerification();
    User? user1 = result.user;
    MyUser trainee = MyUser(uid: user1!.uid);
    //    DatabaseService(uid: user1!.uid).updateTraineeData(Fname,Lname,email,password,age,phoneNumber,neighborhood,gender);

    await DatabaseService(uid: user1.uid).updateTraineeData(trainee, Fname,
        Lname, email, password, age, phoneNumber, neighborhood, gender);

         return user1;
    }
    catch(error){
      print(error.toString());
      return null;
    }
  }




  Future registerAsCoach(
      String Fname,
      String Lname,
      String email,
      String password,
      int age,
      String phoneNumber,
      String neighborhood,
      String description,
      String gender,
      String status,
      String url,
      String price) async {
    try {
       UserCredential result = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);
          await result.user!.sendEmailVerification();
          User? user1 = result.user;
          MyUser Coach = MyUser(uid: user1!.uid);

     await DatabaseService(uid: user1.uid).updateCoachesData(Coach, Fname,
        Lname, email, password, age, phoneNumber, neighborhood,description, gender,status,url,price);

         return user1;
    }
    catch(error){
      print(error.toString());
      return null;
    }

    // User? user1 = result.user;
    // DatabaseService(uid: user1!.uid).updateCoachesData(Fname,Lname,email,password,age,phoneNumber,neighborhood,
    //     description, gender, status);
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
      //       if (count > 0)  {
      //             //UserCredential result = await _auth.signInWithEmailAndPassword(email: "DefaultEmail@gmail.com", password: "1234567");
      //             //User? user3 = result.user; 
      //             var baseDialog = BaseAlertDialog(
      //         title: "",
      //         content: "  :عزيزي المدرب\n لا يمكنك تسجيل الدخول لانه لم يتم توثيق حسابك بعد"+"\n ملاحظة: يتم التوثيق حسب صلاحية رخصة قيادتك",
      //         yesOnPressed: ()  {
                
      //           Navigator.pop( context, 
      //              MaterialPageRoute(builder: (context) => SignIn()),);
      //               //Navigator.of(context, rootNavigator: true).pop('dialog');
                   
      //              },
                
      //         noOnPressed: () {
      //           //Navigator.of(context, rootNavigator: true).pop('dialog');
      //         },
      //         yes: "إغلاق",
      //         no: "");
      //     showDialog(context: context, builder: (BuildContext context) => baseDialog); 
      //          // Navigator.push( context, 
      //          // MaterialPageRoute(builder: (context) => notApproaved()), );
      //         // return user3; 
      //  } else 
      return null;
      }
   );
    } 
    
 count=0;
    
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


  


}
