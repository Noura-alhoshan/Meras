//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meras1/ADcategory.dart';
import 'package:meras1/BaseAlertDialog.dart';
import 'package:meras1/auth.dart';

void main() async {
  runApp(MaterialApp(
    routes: {
      '/ADcategory': (context) => ADcategory(),
    },
  ));
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class TestScreen extends StatefulWidget {
  final String id;
  TestScreen(this.id);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
  }

/*
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TEST PAGE'),
        backgroundColor: Colors.deepPurple[400],
      ),
      body: Container(
        color: Colors.purple[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(
              widget.id,
              style: TextStyle(fontSize: 35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ],
        ),
      ),
    );
  }*/

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return Container(
      color: Colors.purple[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Text(
            document['Email'],
            //  document['Email'],
            style: TextStyle(fontSize: 35),
          ),
          TextButton(
            child: Text('رفض'),
            onPressed: () {/** */},
            style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.redAccent[200],
                textStyle: TextStyle(fontSize: 16)),
          ),
          TextButton(
            child: Text('قبول'),
            onPressed: () async {
              var baseDialog = BaseAlertDialog(
                  title: "",
                  content: "هل أنت متأكد من قبول المدرب؟",
                  yesOnPressed: () async {
                    FirebaseFirestore.instance
                        .collection('Coach')
                        .doc(widget.id)
                        .update({'Status': 'A'});
                    UserCredential result =
                        await _auth.createUserWithEmailAndPassword(
                            email: document['Email'],
                            password: document['Pass']);
                    Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => ADcategory()),
                    );
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                  noOnPressed: () {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                  yes: "نعم",
                  no: "لا");
              showDialog(
                  context: context,
                  builder: (BuildContext context) => baseDialog);
            },
            style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.lightGreen[200],
                textStyle: TextStyle(fontSize: 16)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TEST PAGE'),
        backgroundColor: Colors.deepPurple[400],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Coach')
              .where(FieldPath.documentId, isEqualTo: widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('loading 7 ...');
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(), //<--here
              itemCount: 1,

              itemBuilder: (context, index) =>
                  _buildListItem(context, (snapshot.data!).docs[0]),
            );
          }),
    );
  }

  void nav1() async {
    Navigator.pushNamed(context, '/ADcategory'); //nn
  }
}
