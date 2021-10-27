import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/constants.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class AcceptedLessons extends StatefulWidget {
  //const AcceptedLessons({ Key? key }) : super(key: key);

  @override
  _AcceptedLessonsState createState() => _AcceptedLessonsState();
}

class _AcceptedLessonsState extends State<AcceptedLessons> {
  @override
  void initState() {
    super.initState();
  }

  FirebaseAuth auth1 = FirebaseAuth.instance;

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    final String ph = document['CoachPhone'];
    // Image im = new Image.network(
    //   document['URL'],
    //   height: 230.0,
    //   width: 250.0,
    // );
    return SingleChildScrollView(
        child: (document['Tid'] == auth1.currentUser!.uid &&
                document['Status'] == 'A')
            ? Container(
                height: 250,
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
                          style: TextStyle(height: 2, fontSize: 13),
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
                          'تاريخ التدريب:' +
                              ' ' +
                              document['DateTime'].toString().substring(0, 10) +
                              ' ',
                          style: TextStyle(height: 2, fontSize: 13),
                          textAlign: TextAlign.right,
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'يوم التدريب: ' +
                              ' ' +
                              getArabicdays(document['DateTime'].toString()),
                          style: TextStyle(height: 2, fontSize: 13),
                          textAlign: TextAlign.right,
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          document['DateTime'].toString().substring(17, 19) ==
                                  'AM'
                              ? 'الوقت: ' +
                                  ' ' +
                                  document['DateTime']
                                      .toString()
                                      .substring(11, 17) +
                                  ' ' +
                                  'صباحًا'
                              : 'الوقت: ' +
                                  ' ' +
                                  document['DateTime']
                                      .toString()
                                      .substring(11, 17) +
                                  ' ' +
                                  'مساءًا',
                          style: TextStyle(height: 2, fontSize: 13),
                          textAlign: TextAlign.right,
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      Row(children: [
                        Text('          '),
                        Container(
                          height: 35,
                          padding: EdgeInsets.all(2.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(-90),
                                textStyle: TextStyle(
                                  fontSize: 13,
                                  // color: Colors.grey,
                                  decoration: TextDecoration.underline,
                                )),
                            onPressed: () {
                              //const Text('Gradient',);
                              launch("tel://$ph");
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                document['CoachPhone'],
                              ),
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(2.0),
                            child: Text(' ' + ':رقم جوال المدرب ',
                                style: TextStyle(fontSize: 13.0),
                                textAlign: TextAlign.right)),
                      ]),

                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'تاريخ الطلب:' + ' ' + document['reqDate'],
                          style: TextStyle(
                              height: 2, fontSize: 10, color: kPrimaryColor),
                          textAlign: TextAlign.right,
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      //trailing: Image.asset("assets/images/req.png")
                    ]),
                    trailing: Image.asset("assets/images/acc.png"),
                    leading: ElevatedButton(
                      child: Text('الدفع'),
                      onPressed: () {
                        //nav(document.id); //for next sprint
                      },
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: Color(0xFF6F35A5),
                          textStyle: TextStyle(fontSize: 16)),
                    ),
                  ),
                  elevation: 6,
                  shadowColor: Colors.deepPurple[500],
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: Colors.white, width: 1)),
                ),
              )
            : null);
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
}

// void fetchData() {
//   Text('لا يوجد طلبات مقبولة',
//       style: TextStyle(
//         fontSize: 40.0,
//         color: Colors.grey,
//       ),
//       textAlign: TextAlign.center);
// }

String getArabicdays(String a) {
  switch (a.substring(19)) {
    case 'Saturday':
      return 'السبت';
    case 'Sunday':
      return 'الأحد';
    case 'Monday':
      return 'الأثنين';
    case 'Tuesday':
      return 'الثلاثاء';
    case 'Wednesday':
      return 'الأربعاء';
    case 'Thursday':
      return 'الخميس';
    case 'Friday':
      return 'الجمعة';
    default:
      return 'no day';
  }
}
