import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Admin/widget/FullScreen.dart';
import 'package:meras/screen/authenticate/background2.dart';

import '../../../constants.dart';

class TRprofile extends StatefulWidget {
  final String id;
  TRprofile(this.id);

  @override
  _TRprofileState createState() => _TRprofileState();
}

class _TRprofileState extends State<TRprofile> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'الملف الشخصي                                 ',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.deepPurple[100],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('trainees')
                .where(FieldPath.documentId, isEqualTo: widget.id)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Loading(); //it was text 7.....
              return ListView.builder(
                controller: _scrollController,

                //  physics: const NeverScrollableScrollPhysics(), //<--here
                itemCount: 1,

                itemBuilder: (context, index) =>
                    _build(context, (snapshot.data!).docs[0]),
              );
            }));
  }

  Widget _build(BuildContext context, DocumentSnapshot document) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.deepPurple.shade50,
            Colors.white10,
          ],
        )),
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
          ),
          CircleAvatar(
            radius: 70,
            child: ClipOval(
              child: document['Gender'] == 'أنثى'
                  ? Image.asset(
                      "assets/images/TF.png",
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      "assets/images/TM.png",
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Card(
            child: Column(children: [
              Container(
                child: ListTile(
                  title: Text(
                    'الأسم: ' +
                        document['Fname'] +
                        ' ' +
                        document['Lname'] +
                        '  ',
                    style: TextStyle(
                        height: 1, fontSize: 23, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4.5, horizontal: 20.0),
                ),
              ),
              Container(
                child: ListTile(
                  title: Text(
                    ':البريد الالكتروني ' + document['Email'] + ' ',
                    style: TextStyle(
                        height: 1, fontSize: 23, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4.5, horizontal: 20.0),
                ),
              ),
              Container(
                child: ListTile(
                  title: Text(
                    'العمر:  ' + document['Age'].toString(),
                    style: TextStyle(
                        height: 1, fontSize: 23, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4.5, horizontal: 20.0),
                ),
              ),
              Container(
                child: ListTile(
                  title: Text(
                    'الجنس: ' + document['Gender'],
                    style: TextStyle(
                        height: 1, fontSize: 23, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4.5, horizontal: 20.0),
                ),
              ),
              Container(
                child: ListTile(
                  title: Text(
                    'المنطقة السكنية: ' + document['Neighborhood'],
                    style: TextStyle(
                        height: 1, fontSize: 23, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4.5, horizontal: 20.0),
                ),
              ),
              Container(
                child: ListTile(
                  title: Text(
                    'رقم الجوال: ' + document['Phone Number'],
                    style: TextStyle(
                        height: 1, fontSize: 23, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4.5, horizontal: 20.0),
                ),
              ),
            ]),
            elevation: 50,
            shadowColor: Colors.deepPurple[500],
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: Colors.white, width: 1)),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            child: Text('تعديل'),
            onPressed: () async {
              //nav(document.id);
            },
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                shape: StadiumBorder(),
                primary: Color(0xFF6F35A5),
                textStyle: TextStyle(fontSize: 20)),
          ),
        ]));
  }
}
