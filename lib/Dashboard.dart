import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meras1/DatabaseManager/DatabaseManager.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List userProfilesList = [];
  @override
  void initState() {
    super.initState();
    //fetchUserInfo();
    fetchDatabaseList();
  }

////
  final Future<Null> profileList = FirebaseFirestore.instance
      .collection('Coach')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      print(doc["Fname"]);
    });
  }); //this function print my data on the console

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUsersList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
            child: ListView.builder(
                itemCount: userProfilesList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(userProfilesList[index]['Fname']),
                      subtitle: Text(userProfilesList[index]['Discerption']),
                      leading: CircleAvatar(
                          //left
                          //  child: Image(
                          //     image: AssetImage(''),
                          //    ),
                          ),
                      trailing: Text('@ @'), //right
                    ),
                  );
                })));
  }
}
