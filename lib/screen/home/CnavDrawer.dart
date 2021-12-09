import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meras/screen/Chat/chatWidget.dart';
import 'package:meras/screen/Chat/screens/chat.dart';
import 'package:meras/screen/Chat/screens/dashboard_screen.dart';
import 'package:meras/screen/Coach/COpages/COprofile.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import '../../constants.dart';
import 'BaseAlertDialog.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter/material.dart';

class CNavDrawer extends StatefulWidget {
  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData money =
      IconData(0xf0d6, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  final AuthService _auth = AuthService();
  //final String id;
  //ViewLessonsInfo(this.id);

  @override
  _ViewLessonsInfoState createState() => _ViewLessonsInfoState();
}

Color pu = Color(0xF4F1F8);

class _ViewLessonsInfoState extends State<CNavDrawer> {
  final ScrollController _scrollController = ScrollController();
  late int earn = 0;
  late double rate = 0.0;

  void initState() {
    super.initState();
    getE();
  }

  getE() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    dynamic userid = user!.uid;

    FirebaseFirestore.instance
        .collection("Coach")
        .doc(userid)
        .get()
        .then((querySnapshot) async {
      double ddd = querySnapshot.data()!['Earn'];
      print(ddd);
      setState(() {
        earn = (querySnapshot.data()!['Earn'] - 0.1).toInt();
        //earn = earn.toInt() as double;
      });

      double aaa = querySnapshot.data()!['Rate'];
      print(ddd);
      setState(() {
        rate = (querySnapshot.data()!['Rate']);
        //earn = earn.toInt() as double;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
//getE();
    return Container(
      height: 650,
      width: 250,
      child: Drawer(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,

          children: [
            Container(
              height: 220,
              child: DrawerHeader(
                // child: CircleAvatar(
                //child: ClipOval(
                child: Image.asset(
                  'assets/images/whitelogo.png',
                  height: 280,
                  alignment: Alignment.topCenter,
                ),
                // ),
                //),
                decoration: BoxDecoration(
                  color: Colors.white, //or pu
                ), //child: null,
              ),
            ),
            ListTile(
              trailing: Icon(Icons.person),
              title: Text(
                'الملف الشخصي ',
                textAlign: TextAlign.end,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return COprifile(uid);
                  }),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text(/////////////////////////////////////////////temporary!!! delete it 
               "chat",
                textAlign: TextAlign.end,
              ),
              trailing: Icon(
                Icons.message_outlined,
                color: Colors.orange,
                size: 30.0,
              ),
              onTap:  () {
                 Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DashboardScreen(currentUserId: 'rR3m3ViSYcO21IV4va4Xb41XFuz2',),
              // Chat(currentUserId: uid,
              // peerId: "b6J60NW8fEU2bVWoFETnRX0HyYE3",
              // peerAvatar: "https://sitechecker.pro/wp-content/uploads/2017/12/URL-meaning.png",
              // peerName: "sarah",) ));
                 ));}
            ),
            ListTile(
              title: Text(
                rate.toStringAsFixed(2),
                textAlign: TextAlign.end,
              ),
              trailing: Icon(
                Icons.star_rate,
                color: Colors.orange,
                size: 30.0,
              ),
              onTap: null,
            ),
            ListTile(
              title: Text(
                'الربح: $earn ريال',
                textAlign: TextAlign.end,
              ),
              trailing: Icon(CNavDrawer.money),
              onTap: null,
            ),
            ListTile(
              title: Text(
                'تسجيل الخروج',
                textAlign: TextAlign.end,
              ),
              trailing: Icon(Icons.exit_to_app),
              onTap: () {
                var baseDialog = BaseAlertDialog(
                    title: "",
                    content: "هل أنت متأكد من تسجيل الخروج؟",
                    yesOnPressed: () async {
                      await widget._auth.signOut();
                      //print("hellppp");
                      Navigator.of(context, rootNavigator: true)
                          .pop('dialog'); //عكستهم
                      //Navigator.of(context).push(
                      //  MaterialPageRoute(builder: (context) => SignIn()),//CHANGE IT
                      //);
                    },
                    noOnPressed: () {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                    yes: "نعم",
                    no: "لا");
                showDialog(
                    context: context,
                    builder: (BuildContext context) => baseDialog);
              },
            ),
          ],
        ),
      ),
    );
  }

// getE(){
//  FirebaseAuth auth = FirebaseAuth.instance;
//     User? user = auth.currentUser;
//     dynamic userid = user!.uid;

//    FirebaseFirestore.instance
//                                           .collection("Coach")
//                                           .doc(userid)
//                                           .get()
//                                           .then((querySnapshot) async {
//                                         double ddd =
//                                             querySnapshot.data()!['Earn'];
//                                             print(ddd);
//                                              setState(() {
//                                              earn =  querySnapshot.data()!['Earn'];
//       });
//                                           });
// }

}
