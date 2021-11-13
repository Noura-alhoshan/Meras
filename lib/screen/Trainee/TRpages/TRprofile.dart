import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Admin/widget/FullScreen.dart';
import 'package:meras/screen/authenticate/background2.dart';

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
            return new Row(
              children: <Widget>[
                Expanded(
                    child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    controller: _scrollController,

                    //  physics: const NeverScrollableScrollPhysics(), //<--here
                    itemCount: 1,

                    itemBuilder: (context, index) =>
                        _build(context, (snapshot.data!).docs[0]),
                  ),
                ))
              ],
            );
          }),
    );
  }

  Widget _build(BuildContext context, DocumentSnapshot document) {
    // Image im = new Image.network(
    //   document['URL'],
    //   height: 230.0,
    //   width: 250.0,
    // );
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(135, 105, 0, 50),
          child: Stack(
            children: [
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
              // Positioned(child: Container(
              //   height: 40,
              //   width: 40,

              // )),
              Column(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.black54,
                            Color.fromARGB(0, 41, 102, 1)
                          ]),
                    ),
                  )),
                ],
              ), //colummn
            ],
          ), //stack
        ),
      ],
    ));

    //     Container(
    //   height: 900,
    //   child: SingleChildScrollView(
    //     child: Container(
    //       // decoration: BoxDecoration(
    //       //     gradient: LinearGradient(
    //       //   begin: Alignment.topRight,
    //       //   end: Alignment.bottomLeft,
    //       //   colors: [
    //       //     Colors.white,
    //       //     Colors.white10,
    //       //   ],
    //       // )),
    //       padding: EdgeInsets.symmetric(vertical: 0, horizontal: 00),
    //       child: Column(children: <Widget>[
    //         Padding(
    //           padding: const EdgeInsets.fromLTRB(5, 90, 0, 50),
    //           child: Container(
    //             child: CircleAvatar(
    //               radius: 70,
    //               child: ClipOval(
    //                 child: document['Gender'] == 'أنثى'
    //                     ? Image.asset(
    //                         "assets/images/TF.png",
    //                         height: 150,
    //                         width: 150,
    //                         fit: BoxFit.cover,
    //                       )
    //                     : Image.asset(
    //                         "assets/images/TM.png",
    //                         height: 150,
    //                         width: 150,
    //                         fit: BoxFit.cover,
    //                       ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         // Expanded(child: Container()),
    //         Text(
    //           document['Fname'] + ' ' + document['Lname'] + '  ',
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //               fontSize: 23,
    //               // color: kPrimaryColor,
    //               fontWeight: FontWeight.bold),
    //         ),
    //         Text(
    //           document['Email'],
    //           textAlign: TextAlign.center,
    //           style: TextStyle(fontSize: 18, color: Colors.grey[700]),
    //         ),
    //         SizedBox(
    //             // height: 10,
    //             ),
    //         TextButton(
    //             child: Text(document['Phone Number'],
    //                 style: TextStyle(
    //                   fontSize: 18,
    //                   color: Colors.grey,
    //                   decoration: TextDecoration.underline,
    //                 )),
    //             onPressed: () {
    //               //launch("tel://$ph");
    //             }),
    //         Divider(color: Colors.deepPurple[900]),
    //         Container(
    //           child: Column(children: <Widget>[
    //             Container(
    //               margin: EdgeInsets.all(20),
    //               child: Table(
    //                 defaultColumnWidth: FixedColumnWidth(120.0),
    //                 border: TableBorder.all(
    //                     color: Colors.white,
    //                     style: BorderStyle.solid,
    //                     width: 0),
    //                 children: [
    //                   TableRow(children: [
    //                     Column(children: [Text('')]),
    //                     Column(children: [
    //                       Text('')
    //                     ]), //Column(children:[Text('')]),
    //                   ]),
    //                   TableRow(children: [
    //                     //Column(children:[Text('')]),

    //                     Container(
    //                       padding: EdgeInsets.all(2.0),
    //                       child: Text(
    //                         document['Gender'],
    //                         style: TextStyle(
    //                           fontSize: 18,
    //                           color: Colors.grey,
    //                         ),
    //                         textAlign: TextAlign.right,
    //                       ),
    //                     ),

    //                     Container(
    //                         padding: EdgeInsets.all(2.0),
    //                         child: Text(
    //                           'الجنس',
    //                           style: TextStyle(fontSize: 20.0),
    //                           textAlign: TextAlign.end,
    //                         )),
    //                   ]),
    //                   TableRow(children: [
    //                     Column(children: [Text('')]),
    //                     Column(children: [
    //                       Text('')
    //                     ]), //Column(children:[Text('')]),
    //                   ]),
    //                   TableRow(children: [
    //                     //Column(children:[Text('')]),
    //                     Container(
    //                         padding: EdgeInsets.all(2.0),
    //                         child: Text(
    //                           document['Age'].toString(),
    //                           style: TextStyle(
    //                             fontSize: 18,
    //                             color: Colors.grey,
    //                           ),
    //                           textAlign: TextAlign.right,
    //                         )),
    //                     Container(
    //                         padding: EdgeInsets.all(2.0),
    //                         child: Text(
    //                           'العمر',
    //                           style: TextStyle(fontSize: 20.0),
    //                           textAlign: TextAlign.right,
    //                         )),
    //                   ]),
    //                   TableRow(children: [
    //                     Column(children: [Text('')]),
    //                     Column(children: [
    //                       Text('')
    //                     ]), //Column(children:[Text('')]),
    //                   ]),
    //                   TableRow(children: [
    //                     // Column(children:[Text('')]),
    //                     Container(
    //                         padding: EdgeInsets.all(0),
    //                         child: Text(
    //                           document['Neighborhood'],
    //                           style:
    //                               TextStyle(fontSize: 18, color: Colors.grey),
    //                           textAlign: TextAlign.right,
    //                         )),
    //                     Container(
    //                         padding: EdgeInsets.all(0),
    //                         child: Text(
    //                           'المنطقة السكنية',
    //                           style: TextStyle(fontSize: 20.0),
    //                           textAlign: TextAlign.right,
    //                         )),
    //                   ]),
    //                 ],
    //               ),
    //             ),
    //             // Container(
    //             //     padding: EdgeInsets.all(2),
    //             //     child: Text(
    //             //       'الوصف',
    //             //       style: TextStyle(fontSize: 20.0),
    //             //       textAlign: TextAlign.end,
    //             //     )),
    //             // SizedBox(
    //             //   height: 8,
    //             // ),
    //             // Padding(
    //             //   padding: EdgeInsets.symmetric(horizontal: 22),
    //             //   child: Text(document['Discerption'],
    //             //       textDirection: TextDirection.rtl,
    //             //       style: TextStyle(fontSize: 18, color: Colors.grey)),
    //             // ),

    //             SizedBox(
    //               height: 24,
    //             ),
    //             // Row(children: <Widget>[
    //             //   Padding(
    //             //       padding:
    //             //           EdgeInsets.symmetric(horizontal: 30, vertical: 5)),
    //             //   Center(child: Accept(document)),
    //             //   SizedBox(width: 24),
    //             //   Center(child: Reject(document)),
    //             // ]),
    //           ]),
    //         ),
    //       ]),
    //     ),
    //   ),
    // );
  }
}
