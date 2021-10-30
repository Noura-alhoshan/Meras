import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meras/screen/Coach/widget/BackgroundLo.dart';

import '../viewRequest.dart';
import '../viewRequest2.dart';

class RejectedRequest extends StatefulWidget {
  //const RejectedLessons({ Key? key }) : super(key: key);

  @override
  _RejectedRequestState createState() => _RejectedRequestState();
}

class _RejectedRequestState extends State<RejectedRequest> {
  @override
  void initState() {
    super.initState();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  Color red = Color(0xFFFFCDD2);
  Color green = Color(0xFFC8E6C9);

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    if (document['Cid'] == uid) {
      if (document['Status'] == 'D') {
        return SingleChildScrollView(
            //    child: document['Status'] == 'P'
            //  ?
            child: Container(
          height: 135,
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
                      color: Colors.redAccent[100]),
                  child: ListTile(
                    title: Text(' مرفوض',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            height: -1, fontSize: 16, color: Colors.white)),
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(16.0),

                  child: ListTile(
                    title: Text(
                      document['Tname'], //+ ' ' + document['Lname'],
                      style: TextStyle(height: 1, fontSize: 15),
                      textAlign: TextAlign.right,
                    ),
                    subtitle: Text(
                      'العمر :' + document['TAge'].toString(),
                      style: TextStyle(height: 1, fontSize: 15),
                      textAlign: TextAlign.right,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4.5, horizontal: 7.0),
                    trailing: document['TGender'] == 'أنثى'
                        ? Image.asset("assets/images/TF.png")
                        : Image.asset("assets/images/TM.png"),
                    leading: ElevatedButton(
                      child: Text('التفاصيل  '),
                      onPressed: () {
                        nav(document.id);
                      },
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: Color(0xFF6F35A5),
                          textStyle: TextStyle(fontSize: 12)),
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
        child: BackgroundLO(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Requests')
                  .orderBy('reqDate', descending: false)
                  .snapshots(),
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
