import 'package:firebase_auth/firebase_auth.dart';
import 'package:meras/models/MyUser.dart'; 


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

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

   Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
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