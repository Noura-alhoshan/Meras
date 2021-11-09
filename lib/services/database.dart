import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meras/controllers/MyUser.dart';
import 'package:random_string/random_string.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid}); //added required it was comment

  // users collection reference
  CollectionReference userscollection =
      FirebaseFirestore.instance.collection('users');

  // updateUserData(String Fname, String Lname, String Gender, String Neigh,
  //     String Email, String Pass) async {
  //   Map<String, dynamic> datademo = {
  //     "Fname": Fname,
  //     'Lname': Lname,
  //     'Gender': Gender,
  //     'Neighborhood': Neigh,
  //     'Email': Email,
  //     //'Pass': Pass,
  //   };
  //   userscollection.add(datademo);
  // }

  // trainees collection reference
  CollectionReference traineeCollection =
      FirebaseFirestore.instance.collection('trainees');

  updateTraineeData(
      MyUser traineee,
      String Fname,
      String Lname,
      String email,
      String password,
      int age,
      String phoneNumber,
      String neighborhood,
      String gender) {
    Map<String, dynamic> traineeDataDemo = {
      "Fname": Fname,
      'Lname': Lname,
      'Email': email,
      // 'Password': password,
      'Age': age,
      'Phone Number': phoneNumber,
      'Neighborhood': neighborhood,
      'Gender': gender,
      'Type': 'Trainee',
      'ID': traineee.uid,
    };
    traineeCollection.doc(traineee.uid).set(traineeDataDemo);
  }

  CollectionReference coachesCollection =
      FirebaseFirestore.instance.collection('Coach');

  updateCoachesData(
    MyUser co,
    String Fname,
    String Lname,
    String email,
    String password,
    int age, //int??????
    String phoneNumber,
    String neighborhood,
    String description,
    String gender,
    String status,
    String url,
    String price,
  ) {
    CollectionReference coachesCollection =
        FirebaseFirestore.instance.collection('Coach');
    Map<String, dynamic> traineeDataDemo = {
      "Fname": Fname,
      'Lname': Lname,
      'Email': email,
      // 'Pass': password,
      'Age': age,
      'Phone Number': phoneNumber,
      'Discerption': description,
      'Neighborhood': neighborhood,
      'Gender': gender,
      'Status': status,
      'URL': url,
      'Time': FieldValue.serverTimestamp(),
      'Type': 'Coach',
      'ID': co.uid,
      'Price': price,
      'CountDate': 0,
      'Rate': 0.0,
      'ReqCount': 1,
    };
    coachesCollection.doc(co.uid).set(traineeDataDemo);
  }
}
