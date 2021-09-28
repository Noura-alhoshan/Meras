import 'package:firebase_auth/firebase_auth.dart';
import 'package:meras/services/database.dart';
import 'package:meras/models/MyUser.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore fuser = FirebaseFirestore.instance;
  // create MyUser obj based on firebase user
  MyUser? _userFromFirebase(User? user) { 
    return user != null ? MyUser(uid: user.uid) : null;
  } 


  // auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
    //.map((User user) => _userFromFirebase(user));
  }


  //sign up ############ testing version until Haifa implement it

   Future registerWithEmailAndPassword(String Fname, String Lname, String Gender, //DateTime Birth,
                              String Neigh, String Email, String Pass ) async {
     
    //try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: Email, password: Pass);
      User? user1 = result.user;
      // create a new document for the user with the uid
      DatabaseService(uid: user1!.uid).updateUserData(Fname,Lname, Gender ,Neigh ,Email,Pass);
    //   return _userFromFirebase(user1);
    // } catch (error) {
    //   print(error.toString());
    //   return null;
    // } 
  }

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

  //sign in 
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
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