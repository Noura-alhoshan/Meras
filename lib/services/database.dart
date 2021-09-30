import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meras/models/MyUser.dart'; 

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid }); //added required. it was comment

  // collection reference
  CollectionReference userscollection = FirebaseFirestore.instance.collection('users');

  updateUserData(String Fname, String Lname, String Gender, //DateTime Birth,
                              String Neighborhood, String Email, String Pass  ) {

    Map<String,dynamic> datademo= {"Fname": Fname,
      'Lname': Lname,
      'Gender': Gender,
      'Neighborhood': Neighborhood,
      'Email': Email,
      'Pass': Pass,
    };
    userscollection.add(datademo);
  }


// user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      Fname: snapshot['Fname'],
      Lname: snapshot['Lname'],
      Email: snapshot['Email'],
      Pass: snapshot['Pass'],
      Gender: snapshot['Gender'],   
      Age: snapshot['Age'],
      City: snapshot['City'],
      Neighborhood: snapshot['Neighborhood'],

    );
  }



// get user doc stream
  Stream<UserData> get userData {
    return userscollection.doc(uid).snapshots()
      .map(_userDataFromSnapshot);
  }


CollectionReference traineeCollection = FirebaseFirestore.instance.collection('trainees');


updateTraineeData(String Fname, String Lname, String email, String password,
                  int age, String phoneNumber, String neighborhood, String gender) {
    Map<String,dynamic> traineeDataDemo = {
      "First Name": Fname,
      'Last Name': Lname,
      'Email': email,
      'Password': password,
      'Age': age,
      'Phone Number': phoneNumber,
      'Neighborhood': neighborhood,
      'Gender': gender,
    };
    traineeCollection.add(traineeDataDemo);
  }
  CollectionReference coachesCollection = FirebaseFirestore.instance.collection('Coach');

  updateCoachesData(String Fname, String Lname,String email,String password, String age,
      String phoneNumber, String neighborhood,String description, String gender, String status) {
    Map<String,dynamic> traineeDataDemo = {
      "Fname": Fname,
      'Lname': Lname,
      'Email': email,
      'Pass': password,
      'Age': age,
      'Phone Number': phoneNumber,
      'Discerption': description,
      'Neighborhood': neighborhood,
      'Gender': gender,
      'Status': status,
    };
    coachesCollection.add(traineeDataDemo);
  }


}