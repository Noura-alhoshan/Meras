import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:meras/screen/Navigation/ADcategory.dart';
import 'package:meras/screen/coachProfile_admin/widget/button_widget.dart';
import 'package:meras/screen/home/BaseAlertDialog.dart';
import 'package:meras/services/google_auth_api.dart';

import '../../constants.dart';
import 'widget/BackgroundA.dart';
import 'widget/FullScreen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
//final FirebaseFirestore fuser = FirebaseFirestore.instance;

class TestScreen1 extends StatefulWidget {
  final String id;
  TestScreen1(this.id);

  @override
  _TestScreenState createState() => _TestScreenState();
}

Color red = Color(0xFFFFCDD2);
Color green = Color(0xFFC8E6C9);

class _TestScreenState extends State<TestScreen1> {
  final ScrollController _scrollController = ScrollController();

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
      body:  StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Coach')
                .where(FieldPath.documentId, isEqualTo: widget.id)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('loading 7 ...');
              return ListView.builder(
                controller: _scrollController,

                //  physics: const NeverScrollableScrollPhysics(), //<--here
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

  Widget Reject(DocumentSnapshot document) => ButtonWidget(
        colorr: red,
        text: 'رفض',
        onClicked: () async {
          var baseDialog = BaseAlertDialog(
              title: "",
              content: "هل أنت متأكد من رفض المدرب؟",
              yesOnPressed: () async {
                deleteUser();
                sendRejecteEmail(document);
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
              context: context, builder: (BuildContext context) => baseDialog);
        },
      );
  Widget Accept(DocumentSnapshot document) => ButtonWidget(
        colorr: green,
        text: 'قبول',
        onClicked: () async {
          // print('test' + document['Email']);

          var baseDialog = BaseAlertDialog(
              title: "",
              content: "هل أنت متأكد من قبول المدرب؟",
              yesOnPressed: () async {
                sendAccepteEmail(document);

                FirebaseFirestore.instance
                    .collection('Coach')
                    .doc(widget.id)
                    .update({'Status': 'A'});
                UserCredential result =
                    await _auth.createUserWithEmailAndPassword(
                        email: document['Email'], password: document['Pass']);
                deleteField();
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
              context: context, builder: (BuildContext context) => baseDialog);
        },
      );

  Widget _build(BuildContext context, DocumentSnapshot document) {
    Image im = new Image.network(
      document['URL'],
      height: 230.0,
      width: 250.0,
    );
    return BackgroundA(
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
            )),
            //  height: 1200,
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
                    // color: kPrimaryColor,
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
                   Text(
                                'الوصف',
                                style: TextStyle(fontSize: 20.0),
                                textAlign: TextAlign.center,
                              ),
                          //   ]),
                          // ]),
                          // TableRow(children: [
                          //   Column(children: [
   SizedBox(
                    height: 8,
                  ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 22),
                            
                   child:Text(document['Discerption'], textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey)
                                ),
                            ),
                     
                  SizedBox(
                    height: 24,
                  ),
                  Row(children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 37, vertical: 5)),
                    Center(child: Accept(document)),
                    SizedBox(width: 24),
                    Center(child: Reject(document)),
                  ]),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  CollectionReference users = FirebaseFirestore.instance.collection('Coach');

  Future<void> deleteField() {
    return users
        .doc(widget.id)
        .update({'Pass': FieldValue.delete()})
        .then((value) => print("User's Property Deleted"))
        .catchError(
            (error) => print("Failed to delete user's property: $error"));
  }

  Future<void> deleteUser() {
    CollectionReference users = FirebaseFirestore.instance.collection('Coach');
    return users
        .doc(widget.id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future sendAccepteEmail(DocumentSnapshot document) async {
    FirebaseFirestore.instance
        .collection('Emails')
        .doc('0ZMsVxSp9qjHnIJu2MIX')
        .get()
        .then((DocumentSnapshot em) async {
      final user = await GoogleAuthApi.signIn();
      print('hey before null');

      if (user == null) return;
      print('hey:))))))');

      final email = user.email;
      final auth = await user.authentication;
      final token = auth.accessToken!;

      print('A authintcated: $email');
      GoogleAuthApi.signOut();

      final smtpServer = gmailSaslXoauth2(email, token);

      final message = Message()
        ..from = Address(email, em['Title'])
        ..recipients = ['nooni-4321@hotmail.com'] //[document['Email']]
        ..subject =
            em['SubjectAccepted'] //'Welcome to Meras مرحبا بك في مِرَاس'
        ..text = em['Hello'] +
            ' ' +
            document['Fname'] +
            '\n' +
            em['TextAccepted'] +
            '\n \n' +
            em['End'];

      try {
        await send(message, smtpServer);
        print('email sent');
      } on MailerException catch (e) {
        print(e);
      }
    });
  }

  Future sendRejecteEmail(DocumentSnapshot document) async {
    FirebaseFirestore.instance
        .collection('Emails')
        .doc('0ZMsVxSp9qjHnIJu2MIX')
        .get()
        .then((DocumentSnapshot em) async {
      //  GoogleAuthApi.signOut();
      //  return;
      final user = await GoogleAuthApi.signIn();
      print('hey before null rejected');

      if (user == null) return;
      print('hey:))))))rejected');

      final email = user.email;
      final auth = await user.authentication;
      final token = auth.accessToken!;

      print('R authintcated: $email');
      GoogleAuthApi.signOut();

      final smtpServer = gmailSaslXoauth2(email, token);

      final message = Message()
        ..from = Address(email, em['Title'])
        ..recipients = ['nooni-4321@hotmail.com'] //[document['Email']]
        ..subject =
            em['SubjectRejected'] //'Welcome to Meras مرحبا بك في مِرَاس'
        ..text = em['Hello'] +
            ' ' +
            document['Fname'] +
            '\n' +
            em['TextRejected'] +
            '\n \n' +
            em['End'];

      try {
        await send(message, smtpServer);
        print('R email sent');
      } on MailerException catch (e) {
        print(e);
      }
    });
  }
}