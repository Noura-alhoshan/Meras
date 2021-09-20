import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      //height: size.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/main_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/login_bottom.png",
              width: size.width * 0.4,
            ),
          ),
          Card(
            child: ListTile(
              title: Text(document['Fname'] + ' ' + document['Lname']),
              subtitle: Text(document['Discerption']),
//
              leading: document['Gender'] == 'female'
                  ? Image.asset("assets/driver-female.jpg")
                  : Image.asset("assets/driver-male.jpg"),

              trailing: new ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextButton(
                    child: Text('معلومات المدرب'),
                    onPressed: () {/** */},
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.deepPurple[400],
                        textStyle: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              //Text('@ @'), //right
            ),
          ),
        ],
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
