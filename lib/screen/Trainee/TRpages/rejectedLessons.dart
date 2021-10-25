import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RejectedLessons extends StatefulWidget {
  //const RejectedLessons({ Key? key }) : super(key: key);

  @override
  _RejectedLessonsState createState() => _RejectedLessonsState();
}

class _RejectedLessonsState extends State<RejectedLessons> {
  @override
  void initState() {
    super.initState();
  }

  FirebaseAuth auth1 = FirebaseAuth.instance;

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return SingleChildScrollView(
      child: (document['Tid'] == auth1.currentUser!.uid && document['Status'] == 'D')
          ? Container(
              height: 225,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Card(
                child: ListTile(
                    title: Text(
                      'المدرب: ' +
                          document['CoachName'] +
                          ' ' +
                          document['CoachName2'],
                      style: TextStyle(height: 2, fontSize: 15),
                      textAlign: TextAlign.right,
                    ),
                    subtitle: Column(children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'الحي:' + ' ' + document['Neighborhood'],
                          style: TextStyle(height: 2, fontSize: 11),
                          textAlign: TextAlign.right,
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Text(
                      //   'الحي:' + ' ' + document['Neighborhood'],
                      //   style: TextStyle(height: 2, fontSize: 11),
                      //   textAlign: TextAlign.right,
                      //   // style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'تاريخ الطلب:' + ' ' + document['reqDate'],
                          style: TextStyle(height: 2, fontSize: 11),
                          textAlign: TextAlign.right,
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Text(
                      //   'تاريخ الطلب:' + ' ' + document['reqDate'],
                      //   style: TextStyle(height: 2, fontSize: 11),
                      //   textAlign: TextAlign.right,
                      //   // style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'تاريخ التدريب :' +
                              ' ' +
                              document['DateTime'].toString().substring(0, 10),
                          style: TextStyle(height: 2, fontSize: 11),
                          textAlign: TextAlign.right,
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Text(
                      //   'تاريخ التدريب :' +
                      //       ' ' +
                      //       document['DateTime'].toString().substring(0, 10),
                      //   style: TextStyle(height: 2, fontSize: 11),
                      //   textAlign: TextAlign.right,
                      //   // style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          document['DateTime'].toString().substring(
                                  19, document['DateTime'].toString().length) +
                              ' ' +
                              ': يوم التدريب',
                          style: TextStyle(height: 2, fontSize: 11),
                          textAlign: TextAlign.right,
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Text(
                      //   document['DateTime'].toString().substring(
                      //           19, document['DateTime'].toString().length) +
                      //       ' ' +
                      //       ': يوم التدريب',
                      //   style: TextStyle(height: 2, fontSize: 11),
                      //   textAlign: TextAlign.right,
                      //   // style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          document['DateTime'].toString().substring(17, 19) +
                              ' ' +
                              'الوقت :' +
                              ' ' +
                              document['DateTime'].toString().substring(11, 17),
                          style: TextStyle(height: 2, fontSize: 11),
                          textAlign: TextAlign.right,
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Text(
                      //   document['DateTime'].toString().substring(17, 19) +
                      //       ' ' +
                      //       'الوقت :' +
                      //       ' ' +
                      //       document['DateTime'].toString().substring(11, 17),
                      //   style: TextStyle(height: 2, fontSize: 11),
                      //   textAlign: TextAlign.right,
                      //   // style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'رقم جوال المدرب :' + ' ' + document['CoachPhone'],
                          style: TextStyle(height: 2, fontSize: 11),
                          textAlign: TextAlign.right,
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Text(
                      //   'رقم جوال المدرب :' + ' ' + document['CoachPhone'],
                      //   style: TextStyle(height: 2, fontSize: 11),
                      //   textAlign: TextAlign.right,
                      //   // style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      //trailing: Image.asset("assets/images/req.png")
                    ]),
                    trailing: Image.asset("assets/images/rej2.png")
                    //: Image.asset("assets/images/driver-male.jpg"),
                    // leading: ElevatedButton(
                    //   child: Text('معلومات المدرب   '),
                    //   onPressed: () {
                    //     //nav(document.id); //for next sprint
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //       shape: StadiumBorder(),
                    //       primary: Color(0xFF6F35A5),
                    //       textStyle: TextStyle(fontSize: 16)),
                    // ),
                    ),
                elevation: 6,
                shadowColor: Colors.deepPurple[500],
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: Colors.white, width: 1)),
              ),
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   extendBodyBehindAppBar: true,
        //drawer: NavDrawer(),
        // appBar: AppBar(
        //   title: Text(
        //     'قائمة المدربين المتاحين',
        //     textDirection: TextDirection.rtl,
        //   ),
        //   backgroundColor: Colors.deepPurple[100],
        // ),
        // body:
        Container(
      child: SingleChildScrollView(
        child: BackgroundA(
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Requests').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('loading 7 ...');
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
}