import 'package:cloud_firestore/cloud_firestore.dart'; 

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

}