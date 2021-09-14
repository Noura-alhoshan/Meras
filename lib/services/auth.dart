import 'package:firebase_auth/firebase_auth.dart';
import 'package:meras/models/MyUser.dart';
import 'package:meras/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on FirebaseUser
  MyUser? _userFromFirebase(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }
  //sign in with email & pass
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


  //register as trainee
  Future registerAsTrainee(String Fname,String Lname,String email,int age,String password,String phoneNumber,String city, String gender) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateTraineeData(Fname, Lname, email, age, password, phoneNumber, city, gender);
      return _userFromFirebase(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
  Future registerAsCoach(String Fname,String Lname,String email,int age,String password,String phoneNumber,String city, String gender) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


  //register as coach


  //sign out
Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
}
}