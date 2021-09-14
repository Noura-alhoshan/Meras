import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({required this.uid});
  //collection refrence
  final CollectionReference merasCollection = FirebaseFirestore.instance.collection('trainees');
  final CollectionReference merasCollection2 = FirebaseFirestore.instance.collection('Coaches');

  Future updateTraineeData(String Fname,String Lname,String email,int age,String password,String phoneNumber,String city, String gender) async {
    return await merasCollection.doc(uid).set({
      'First Name': Fname,
      'Last Name': Lname,
      'Email': email,
      'Age': age,
      'Password': password,
      'Phone Number': phoneNumber,
      'City': city,
      'Gender': gender
    });
  }
}