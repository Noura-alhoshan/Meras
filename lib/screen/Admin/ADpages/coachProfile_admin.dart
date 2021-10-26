import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/services/BaseAlertDialog.dart';
import 'package:meras/screen/Admin/services/google_auth_api.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Admin/widget/FullScreen.dart';
import 'package:meras/screen/Admin/widget/button_widget.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
//final FirebaseFirestore fuser = FirebaseFirestore.instance;

class ADcoachProfile extends StatefulWidget {
  final String id;
  ADcoachProfile(this.id);

  @override
  _ADcoachProfileScreenState createState() => _ADcoachProfileScreenState();
}

Color red = Color(0xFFFFCDD2);
Color green = Color(0xFFC8E6C9);

class _ADcoachProfileScreenState extends State<ADcoachProfile> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'معلومات المدرب',
          textAlign: TextAlign.center,
        ),
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

              //physics: const NeverScrollableScrollPhysics(), //<--here
              itemCount: 1,

              itemBuilder: (context, index) =>
                  _build(context, (snapshot.data!).docs[0]),
            );
          }),
    );
  }

  Widget Reject(DocumentSnapshot document) => ButtonWidget(
        colorr: red,
        text: 'رفض',
        onClicked: () async {
          var baseDialog = BaseAlertDialog(
              title: "",
              content: "هل أنت متأكد من رفض المدرب؟",
              yesOnPressed: () async {
                await FirebaseFirestore.instance
                    .collection('Coach')
                    .doc(widget.id)
                    .update({'Status': 'D'});

                // deleteUser();
                // nav1();
                sendRejecteEmail(document);
                //nav1WithPOP();
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
          var baseDialog = BaseAlertDialog(
              title: "",
              content: "هل أنت متأكد من قبول المدرب؟",
              yesOnPressed: () async {
                sendAccepteEmail(document);
                await FirebaseFirestore.instance
                    .collection('Coach')
                    .doc(widget.id)
                    .update({'Status': 'A'});
                // nav1WithPOP2();
                //nav1();
                //  Navigator.of(context, rootNavigator: true).pop('dialog');
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
      child: Scrollbar(
        isAlwaysShown: true,
        controller: _scrollController,
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
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 23,
                      // color: kPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  document['Email'],
                  textAlign: TextAlign.center,
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
                              Text(document['Age'].toString(),
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
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
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
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
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Text(document['Discerption'],
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ),

                    SizedBox(
                      height: 24,
                    ),
                    Row(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5)),
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
      ),
    );
  }

  void nav1WithPOP() async {
    //Navigator.pushNamed(context, '/ADcategory');
    Navigator.of(context).pop();

    var baseDialog = BaseAlertDialog(
        title: "",
        content: "تم رفض المدرب بنجاح   ",
        yesOnPressed: () async {
          nav1();
        },
        noOnPressed: () {
          //Navigator.of(context, rootNavigator: true).pop('dialog');
        },
        yes: "إغلاق",
        no: "");
    showDialog(
        context: context, builder: (BuildContext context) => baseDialog); //nn
  }

  void nav1WithPOP2() async {
    //Navigator.pushNamed(context, '/ADcategory');
    Navigator.of(context).pop();

    var baseDialog = BaseAlertDialog(
        title: "",
        content: "تم قبول المدرب بنجاح   ",
        yesOnPressed: () async {
          nav1();
        },
        noOnPressed: () {
          //Navigator.of(context, rootNavigator: true).pop('dialog');
        },
        yes: "إغلاق",
        no: "");
    showDialog(
        context: context, builder: (BuildContext context) => baseDialog); //nn
  }

/////////////////////////////////////////////////
  void nav1() async {
    // Navigator.pushNamed(context, '/ADcategory'); //nn
    Navigator.of(context).pop();
    Navigator.of(context).pop();

    // Navigator.of(context, rootNavigator: true)
    //     .pop('dialog'); ////////////////////////// to be ubdated
  }

  Future sendAccepteEmail(DocumentSnapshot document) async {
    GoogleAuthApi.signOut();

    await FirebaseFirestore.instance
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
      //GoogleAuthApi.signOut();

      final smtpServer = gmailSaslXoauth2(email, token);

      final message = Message()
        ..from = Address(email, em['Title'])
        ..recipients = [document['Email']] //[document['Email']]
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
        nav1WithPOP2();
      } on MailerException catch (e) {
        print(e);
      }
    });
    // pop(context);
  }

  Future sendRejecteEmail(DocumentSnapshot document) async {
    GoogleAuthApi.signOut();

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
        ..recipients = [document['Email']] //[document['Email']]
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
        nav1WithPOP();
      } on MailerException catch (e) {
        print(e);
      }
    });
  }

///////////
  void pop(BuildContext context) {
    var baseDialog = BaseAlertDialog(
        title: "",
        content: "هل أنت متأكد من قبول المدرب؟",
        yesOnPressed: () async {},
        noOnPressed: () {},
        yes: "نعم",
        no: "لا");
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  ///////////
}
