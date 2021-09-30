import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meras/constants.dart';
import 'package:meras/screen/authenticate/background.dart';

import 'widget/FullScreen.dart';
import 'widget/button_widget.dart';

class DoctorsInfo extends StatefulWidget {
  final String id;
  DoctorsInfo(this.id);
  @override
  _DoctorsInfoState createState() => _DoctorsInfoState();
}

Color red = Color(0xFFFFCDD2);
Color green = Color(0xFFC8E6C9);




class _DoctorsInfoState extends State<DoctorsInfo> {
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
          // height: 900,
          //padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
              style: TextStyle(fontSize: 23,color: kPrimaryColor,fontWeight: FontWeight.bold),
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
               Divider(
              color: Colors.deepPurple[900]
            ),
            Container(
                child: Column(children: <Widget>[
              Container(
                
                margin: EdgeInsets.all(20),
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(120.0),
                  border: TableBorder.all(
                      color: Colors.white, style: BorderStyle.solid, width: 0),
                  children: [
            
                    TableRow(children: [
                      Column(children: [Text('')]),
                      Column(
                          children: [Text('')]), //Column(children:[Text('')]),
                    ]),
                    TableRow(children: [
                      //Column(children:[Text('')]),
                      Column(children: [
                        Text(document['Gender'],
                            style: TextStyle(fontSize: 18, color: Colors.grey,),textAlign: TextAlign.right,)
                      ]),
                      Column(children: [
                        Text('الجنس', style: TextStyle(fontSize: 20.0),textAlign: TextAlign.right,)
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [Text('')]),
                      Column(
                          children: [Text('')]), //Column(children:[Text('')]),
                    ]),
                    TableRow(children: [
                      //Column(children:[Text('')]),
                      Column(children: [
                        Text(document['Age'],
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                      ]),
                      Column(children: [
                        Text('العمر', style: TextStyle(fontSize: 20.0))
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [Text('')]),
                      Column(
                          children: [Text('')]), //Column(children:[Text('')]),
                    ]),
                    TableRow(children: [
                      // Column(children:[Text('')]),
                      Column(children: [
                        Text(document['Neighborhood'],
                            style: TextStyle(fontSize: 18, color: Colors.grey))
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
                      color: Colors.white, style: BorderStyle.solid, width: 0),
                  children: [
                    TableRow(children: [
                      //Column(children:[Text('')]),
                      Column(children: [
                        Text('الوصف', style: TextStyle(fontSize: 20.0),textAlign: TextAlign.center,)
                       
                      ]),]),
                      TableRow(children: [
                      Column(children: [ Text(document['Discerption'],
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                        
                      ]), ]),
                     
                   ] ),),
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
                    padding: EdgeInsets.symmetric(horizontal: 37, vertical: 5)),
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


 


class IconTile extends StatelessWidget {
  final String imgAssetPath;
  final Color backColor;

  IconTile({required this.imgAssetPath, required this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 900,
      margin: EdgeInsets.only(right: 16),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          imgAssetPath,
          width: 20,
        ),
      ),
    );
  }
}
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             //color: kPrimaryLightColor,

//             child: Row(
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(top: 0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(85),
//                     child: Container(
//                       child: ImageFullScreenWrapperWidget(
//                         child: im,
//                         dark: false,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Container(
//                   // color: Colors.deepPurple[100],
//                   width: MediaQuery.of(context).size.width - 222,
//                   height: 220,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: <Widget>[
//                       SizedBox(
//                         height: 29,
//                       ),
//                       Text(
//                         document['Fname'] + ' ' + document['Lname'] + '  ',
//                         style: TextStyle(fontSize: 22),
//                       ),
//                       Text(
//                         document['Email'],
//                         style: TextStyle(fontSize: 18, color: Colors.grey),
//                       ),
//                       Text(
//                         document['Phone Number'],
//                         style: TextStyle(fontSize: 18, color: Colors.grey),
//                       ),
//                       SizedBox(
//                         height: 40,
//                       ),

//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: <Widget>[
//                  Text(
//                   "الجنس",
//                   style: TextStyle(fontSize: 22),
//                   textAlign: TextAlign.right,
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Text(document["Gender"],
//                           style:
//                               TextStyle(fontSize: 18, color: Colors.grey),
//                           textAlign: TextAlign.right),
//                            Text(
//                   "العمر",
//                   style: TextStyle(fontSize: 22),
//                   textAlign: TextAlign.right,
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                       Text(document["Age"],
//                           style:
//                               TextStyle(fontSize: 18, color: Colors.grey),
//                           textAlign: TextAlign.right),
//                 Text(
//                   "الوصف",
//                   style: TextStyle(fontSize: 22),
//                   textAlign: TextAlign.right,
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Text(document["Discerption"],
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 16,
//                     ),
//                     textAlign: TextAlign.justify),
//                 SizedBox(
//                   height: 24,
//                 ),
//                 Text("المنطقة السكنية",
//                     style: TextStyle(
//                       color: Colors.black87.withOpacity(0.7),
//                       fontSize: 20,
//                     ),
//                     textAlign: TextAlign.right),
//                 SizedBox(
//                   height: 3,
//                 ),

//                  Text(document["Neighborhood"],
//                       style: TextStyle(color: Colors.grey),
//                       textAlign: TextAlign.right),

//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   children: <Widget>[
//                     //Image.asset("assets/images/logo1.png"),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         SizedBox(
//                           height: 3,
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width - 268,
//                         ),

//                         SizedBox(
//                           height: 22,
//                         ),
//                         Row(
//                           children: <Widget>[
//                             Expanded(
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 24, horizontal: 16),
//                                 decoration: BoxDecoration(
//                                     color: Color(0xffFBB97C),
//                                     borderRadius:
//                                         BorderRadius.circular(20)),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Container(
//                                       padding: EdgeInsets.all(8),
//                                       decoration: BoxDecoration(
//                                           color: Color(0xffFCCA9B),
//                                           borderRadius:
//                                               BorderRadius.circular(16)),
//                                       // child: //Image.asset("assets/images/logo1.png"))
//                                     ),
//                                     SizedBox(
//                                       width: 16,
//                                     ),
//                                     Container(
//                                       width: MediaQuery.of(context)
//                                                   .size
//                                                   .width /
//                                               2 -
//                                           130,
//                                       child: Text(
//                                         "List Of Schedule",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 17),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 16,
//                             ),
//                             Expanded(
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 24, horizontal: 16),
//                                 decoration: BoxDecoration(
//                                     color: Color(0xffA5A5A5),
//                                     borderRadius:
//                                         BorderRadius.circular(20)),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Container(
//                                       padding: EdgeInsets.all(8),
//                                       decoration: BoxDecoration(
//                                           color: Color(0xffBBBBBB),
//                                           borderRadius:
//                                               BorderRadius.circular(16)),
//                                       //child: //Image.asset("assets/images/logo1.png")
//                                     ),
//                                     SizedBox(
//                                       width: 16,
//                                     ),
//                                     Container(
//                                       width: MediaQuery.of(context)
//                                                   .size
//                                                   .width /
//                                               2 -
//                                           130,
//                                       child: Text(
//                                         "Doctor's Daily Post",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 17),

//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// ),
