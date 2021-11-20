import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/constants.dart';
import 'package:meras/screen/Admin/widget/FullScreen.dart';
import 'package:meras/screen/Coach/BackgroundProfileLight.dart';
import 'package:meras/screen/Coach/COpages/editProfileInfoCO.dart';

class COprifile extends StatefulWidget {
  final String id;
  COprifile(this.id);

  @override
  _COprifileState createState() => _COprifileState();
}

class _COprifileState extends State<COprifile> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.deepPurple[100],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Coach')
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
    Image im = new Image.network(
      document['URL'],
      height: 230.0,
      width: 250.0,
    );
    return BackgroundProfileLight(
      child: Container(
        child: SingleChildScrollView(
          child: Container(
              child: Column(children: <Widget>[
            Text(
              'الملف الشخصي                                 ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 27),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 1, 0),
            ),
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Container(
                  child: ImageFullScreenWrapperWidget(
                    child: im,
                    dark: false,
                  ),
                ),
              ),
            ),
            Card(
              child:
                  // Column(children: [
                  //   Container(
                  //     child:
                  Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: Table(
                    columnWidths: {
                      0: FlexColumnWidth(6),
                      1: FlexColumnWidth(3),
                      //2: FlexColumnWidth(4),
                    },
                    //margin: EdgeInsets.all(40),
                    //child: Table(
                    defaultColumnWidth: FixedColumnWidth(150.0),
                    border: TableBorder.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 0),
                    children: [
                      TableRow(children: [
                        Container(
                            padding: EdgeInsets.all(1.0),
                            child: Text(
                              document['Fname'] + ' ' + document['Lname'],
                              style: TextStyle(
                                  fontSize: 16.5,
                                  color: Colors.grey,
                                  height: 1.3),
                              textAlign: TextAlign.right,
                            )),

                        Container(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              ':الاسم',
                              style: TextStyle(fontSize: 18.0),
                              textAlign: TextAlign.end,
                            )),

                        //Column(children: [Text('')]),
                        // Column(children: [
                        // Text('')
                      ]),
                      TableRow(children: [
                        //Column(children:[Text('')]),
                        Container(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              document['Age'].toString() + "  سنة ",
                              style: TextStyle(
                                height: 1.49,
                                fontSize: 16.3,
                                color: Colors.grey,
                              ),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                            )),
                        Container(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              ':العمر',
                              style: TextStyle(fontSize: 18.0),
                              textAlign: TextAlign.right,
                            )),
                      ]),
                      TableRow(children: [
                        Container(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            document['Gender'],
                            style: TextStyle(
                              height: 1.99,
                              fontSize: 16.37,
                              color: Colors.grey,
                              //height: 1
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              ':الجنس',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.end,
                            )),
                      ]),
                      TableRow(children: [
                        Container(
                          padding: EdgeInsets.all(1.0),
                          child: Text(
                            document['Email'],
                            style: TextStyle(
                              height: 1.7, //1.99
                              fontSize: 15.37,
                              color: Colors.grey,
                              //height: 1
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              ':البريد الالكتروني',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.end,
                            )),
                      ]),
                      TableRow(children: [
                        Container(
                          padding: EdgeInsets.all(1.0),
                          child: Text(
                            document['Neighborhood'],
                            style: TextStyle(
                              height: 1.99,
                              fontSize: 16.37,
                              color: Colors.grey,
                              //height: 1
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              ':الحي السكني ',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.end,
                            )),
                      ]),
                      TableRow(children: [
                        Container(
                          padding: EdgeInsets.all(1.0),
                          child: Text(
                            " " + document['Price'] + " ريال",
                            style: TextStyle(
                              height: 1.99,
                              fontSize: 16.37,
                              color: Colors.grey,
                              //height: 1
                            ),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              ':سعر التدريب ',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.end,
                            )),
                      ]),
                      TableRow(children: [
                        Container(
                          padding: EdgeInsets.all(1.0),
                          child: Text(
                            document['Phone Number'],
                            style: TextStyle(
                              height: 1.99,
                              fontSize: 16.37,
                              color: Colors.grey,
                              //height: 1
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(3.0),
                            child: Text(
                              ':رقم الجوال',
                              style: TextStyle(fontSize: 18.0),
                              textAlign: TextAlign.end,
                            )),
                      ]),
                      TableRow(children: [
                        Container(
                          padding: EdgeInsets.all(1.0),
                          child: Text(
                            document['Discerption'],
                            style: TextStyle(
                              height: 1.99,
                              fontSize: 16.5,
                              color: Colors.grey,
                              //height: 1
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              ':الوصف ',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.end,
                            )),
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
              ]),
              // ),
              // ]),
              elevation: 30,
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
                nav(document.id, document['Price'], document['Age']);
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: StadiumBorder(),
                  primary: Color(0xFF6F35A5),
                  textStyle: TextStyle(fontSize: 17)),
            ),
            SizedBox(
              height: 30,
              //width: 40,
            ),
          ])),
        ),
      ),
    );
  }

  void nav(String id, String pppp, int aaaa) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return EditProfileInfoCo(id, pppp, aaaa.toString());
        //return RequestLessonPage(icd);
      }),
    );
  }
}
