import 'package:cloud_firestore/cloud_firestore.dart'; 

class DatabaseService {

 // final String uid;
  //DatabaseService({ required this.uid }); //added required 

  // collection reference
  CollectionReference userscollection = FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String Fname, String Lname, String Gender, //DateTime Birth,
                              String Neighborhood, String Email, String Pass  ) {
    return userscollection .add({
      'Fname': Fname,
      'Lname': Lname,
      'Gender': Gender,
      'Neighborhood': Neighborhood,
      'Email': Email,
      'Pass': Pass,
    });
  }

}