import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meras/models/MyUser.dart';
import 'package:meras/screen/authenticate/background.dart';
import 'package:meras/screen/coachProfile_admin/Coach.dart';
//import 'package:meras/screen/coachProfile_admin/user_preferences.dart';
import 'package:meras/screen/coachProfile_admin/widget/appbar_widget.dart';
import 'package:meras/screen/coachProfile_admin/widget/button_widget.dart';
import 'package:meras/screen/coachProfile_admin/widget/numbers_widget.dart';
import 'package:meras/screen/coachProfile_admin/widget/profile_widget.dart';
import 'package:meras/screen/home/home.dart';

import '../../constants.dart';
import 'widget/FullScreen.dart';

class TestScreen extends StatefulWidget {
  final String id;
  TestScreen(this.id);

  @override
  _TestScreenState createState() => _TestScreenState();
}

Color red = Color(0xFFFFCDD2);
Color green = Color(0xFFC8E6C9);

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'معلومات المدرب',
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.deepPurple[100],
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
                  _build(context, (snapshot.data!).docs[0]),
            );
          }),
    );
  }

  void nav1() async {
    Navigator.pushNamed(context, '/ADcategory'); //nn
  }

  Widget Reject() => ButtonWidget(
        colorr: red,
        text: 'رفض',
        onClicked: () {},
      );
  Widget Accept() => ButtonWidget(
        colorr: green,
        text: 'قبول',
        onClicked: () {
          FirebaseFirestore.instance
              .collection('Coach')
              .doc(widget.id)
              .update({'Status': 'A'});
          nav1();
        },
      );

  Widget _build(BuildContext context, DocumentSnapshot document) {
    Image im = new Image.network(
      document['URL'],
      height: 230.0,
      width: 250.0,
    );
    return Background(
      child: Container(
        height: 900,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.deepPurple.shade50,
                Colors.white10,
              ],
            )
          ),
            // height: 900,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 00),
            child: Column(children: <Widget>[
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(89),
                  child: Container(
                    child: ImageFullScreenWrapperWidget(
                      child: im,
                      dark: false,
                    ),
                  ),
                ),
              ),
              //       Image.network(
              //  'https://image.flaticon.com/icons/png/512/1251/1251743.png',
              //   height: 230.0,
              //   width: 250.0,
              // ),
              Text(
                document['Fname'] + ' ' + document['Lname'] + '  ',
                style: TextStyle(
                    fontSize: 23,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                document['Email'],
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              SizedBox(
                height: 10,
              ),
              Text(document['Phone Number'],
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
              Divider(color: Colors.deepPurple[900]),
              Container(
                child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Table(
                      defaultColumnWidth: FixedColumnWidth(120.0),
                      border: TableBorder.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 0),
                      children: [
                        TableRow(children: [
                          Column(children: [Text('')]),
                          Column(children: [
                            Text('')
                          ]), //Column(children:[Text('')]),
                        ]),
                        TableRow(children: [
                          //Column(children:[Text('')]),
                          Column(children: [
                            Text(
                              document['Gender'],
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.right,
                            )
                          ]),
                          Column(children: [
                            Text(
                              'الجنس',
                              style: TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.right,
                            )
                          ]),
                        ]),
                        TableRow(children: [
                          Column(children: [Text('')]),
                          Column(children: [
                            Text('')
                          ]), //Column(children:[Text('')]),
                        ]),
                        TableRow(children: [
                          //Column(children:[Text('')]),
                          Column(children: [
                            Text(document['Age'],
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey))
                          ]),
                          Column(children: [
                            Text('العمر', style: TextStyle(fontSize: 20.0))
                          ]),
                        ]),
                        TableRow(children: [
                          Column(children: [Text('')]),
                          Column(children: [
                            Text('')
                          ]), //Column(children:[Text('')]),
                        ]),
                        TableRow(children: [
                          // Column(children:[Text('')]),
                          Column(children: [
                            Text(document['Neighborhood'],
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey))
                          ]),
                          Column(children: [
                            Text('المنطقة السكنية',
                                style: TextStyle(fontSize: 20.0))
                          ]),
                        ]),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(20),
                    child: Table(
                        defaultColumnWidth: FixedColumnWidth(230.0),
                        border: TableBorder.all(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 0),
                        children: [
                          TableRow(children: [
                            //Column(children:[Text('')]),
                            Column(children: [
                              Text(
                                'الوصف',
                                style: TextStyle(fontSize: 20.0),
                                textAlign: TextAlign.center,
                              )
                            ]),
                          ]),
                          TableRow(children: [
                            Column(children: [
                              Text(document['Discerption'],
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
                            ]),
                          ]),
                        ]),
                  ),
                  //  Text(
                  //       "الوصف",
                  //       style: TextStyle(fontSize: 21),
                  //       textAlign: TextAlign.right,
                  //     ),
                  //     SizedBox(
                  //       height: 8,
                  //     ),
                  //     Text(document["Discerption"],
                  //         style: TextStyle(
                  //           color: Colors.grey,
                  //           fontSize: 18,
                  //         ),
                  //         textAlign: TextAlign.justify),
                  SizedBox(
                    height: 24,
                  ),
                  Row(children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 37, vertical: 5)),
                    Center(child: Accept()),
                    SizedBox(width: 24),
                    Center(child: Reject()),
                  ]),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
