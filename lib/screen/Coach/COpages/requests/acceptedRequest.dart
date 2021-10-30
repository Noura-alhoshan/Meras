import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'viewRequest.dart';
import 'viewRequest2.dart';

class AcceptedRequest extends StatefulWidget {
  //const AcceptedLessons({ Key? key }) : super(key: key);

  @override
  _AcceptedRequestState createState() => _AcceptedRequestState();
}

class _AcceptedRequestState extends State<AcceptedRequest> {
  @override
  void initState() {
    super.initState();

    //User? user = auth.currentUser;
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  Color red = Color(0xFFFFCDD2);
  Color green = Color(0xFFC8E6C9);

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    if (document['Cid'] == uid) {
      if (document['Status'] == 'A') {
        return SingleChildScrollView(
            //    child: document['Status'] == 'P'
            //  ?
            child: Container(
          height: 120,
          padding: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
          child: Card(
            //  elevation: 4.0,
            child: Column(
              children: [
                Container(
                  height: 25,
                  decoration: new BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0)),
                      //borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: green),
                  child: ListTile(
                    title: Text(' مقبول',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            height: -1, fontSize: 18, color: Colors.white)),
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(16.0),

                  child: ListTile(
                    title: Text(
                      document['Tname'], //+ ' ' + document['Lname'],
                      style: TextStyle(height: 2, fontSize: 15),
                      textAlign: TextAlign.right,
                    ),
                    // subtitle: Text(
                    //  'التاريخ :' + document['Time'].toDate().toString().substring(1, 10),
                    //   style: TextStyle(height: 2, fontSize: 11),
                    //   textAlign: TextAlign.right,
                    // ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                    trailing: document['TGender'] == 'أنثى'
                        ? Image.asset("assets/images/TF.png")
                        : Image.asset("assets/images/TM.png"),
                    leading: ElevatedButton(
                      child: Text(' تفاصيل الطلب  '),
                      onPressed: () {
                        nav(document.id);
                      },
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: Color(0xFF6F35A5),
                          textStyle: TextStyle(fontSize: 16)),
                    ),
                  ),
                  //
                ),
              ],
            ),
            elevation: 6,
            shadowColor: Colors.deepPurple[500],

            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: Colors.transparent, width: 1)),
          ),
        )
            // : null,
            );
      }
    }
    return SingleChildScrollView(
      //    child: document['Status'] == 'P'
      //  ?
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: BackgroundA(
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Requests').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Loading();
                return ListView.builder(
                  //physics: const NeverScrollableScrollPhysics(), //<--here
                  //controller: _scrollController,

                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, (snapshot.data!).docs[index]),
                );
              }),
        ),
      ),
    );
    //);
  }

  void nav(String icd) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return ViewLessonRequest2(icd);
      }),
    );
  }
}
