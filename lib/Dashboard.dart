import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List userProfilesList = [];
  @override
  void initState() {
    super.initState();
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return Card(
      child: ListTile(
        title: Text(document['Fname']),
        subtitle: Text(document['Discerption']),
        leading: IconButton(
            icon: Icon(Icons.account_circle_rounded),
            iconSize: 50,
            onPressed: () {
              //    nav();
            }

            //left
            //  child: Image(
            //     image: AssetImage(''),
            //    ),
            ),
        trailing: new ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextButton(
              child: Text('قبول'),
              onPressed: () {/** */},
              style: TextButton.styleFrom(
                  primary: Colors.black,
                  backgroundColor: Colors.lightGreen[200],
                  textStyle: TextStyle(fontSize: 16)),
            ),
            TextButton(
              child: Text('رفض'),
              onPressed: () {/** */},
              style: TextButton.styleFrom(
                  primary: Colors.black,
                  backgroundColor: Colors.redAccent[200],
                  textStyle: TextStyle(fontSize: 16)),
            ),
          ],
        ),
        //Text('@ @'), //right
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المدربون الجدد'),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Coach').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('loading 7 ...');
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, (snapshot.data!).docs[index]),
            );
          }),
    );
  }

//  void nav() async {
//    Navigator.pushNamed(context, '/DatabaseManager'); //nn
  // }
}
