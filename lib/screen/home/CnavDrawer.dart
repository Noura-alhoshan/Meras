import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meras/screen/authenticate/sign_in.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/services/database.dart';
import 'package:meras/controllers/MyUser.dart';
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

  static const IconData money = IconData(0xf0d6, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  final AuthService _auth = AuthService();
   //final String id;
  //ViewLessonsInfo(this.id);

  @override
  _ViewLessonsInfoState createState() => _ViewLessonsInfoState();
}

class _ViewLessonsInfoState extends State<CNavDrawer> {
  final ScrollController _scrollController = ScrollController();
late int earn=0; 
  void initState() {
    super.initState();
  }

  getE(){
 FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    dynamic userid = user!.uid;

   FirebaseFirestore.instance
                                          .collection("Coach")
                                          .doc(userid)
                                          .get()
                                          .then((querySnapshot) async {
                                        double ddd =
                                            querySnapshot.data()!['Earn'];
                                            print(ddd);
                                             setState(() {
                                             earn =  (querySnapshot.data()!['Earn']- 0.1).toInt();
                                             //earn = earn.toInt() as double;
      });
                                          });
}

  @override
  Widget build(BuildContext context)  {
getE();
    return  Container(
      height: 650,
      width: 250,
      child: Drawer(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,

          children: [
            Container(
              height: 210,
              child: DrawerHeader(

                child: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset('assets/images/def.jpg', height: 230,),
                  ),
                ),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,

                ), //child: null,
              ),
            ),
            ListTile(
              trailing: Icon(Icons.person),
              title: Text('الملف الشخصي ',textAlign: TextAlign.end,),
              onTap: () => null,
            ),

            Divider(),


            ListTile(
              title: Text('الربح: $earn ريال'  ,textAlign: TextAlign.end,),
              trailing: Icon(CNavDrawer.money) ,
              onTap: ()  {

               
              }
              ,),



            ListTile(
              title: Text('تسجيل الخروج', textAlign: TextAlign.end,),
              trailing: Icon(Icons.exit_to_app),
              onTap: ()  {

                var baseDialog = BaseAlertDialog(
                    title: "",
                    content: "هل أنت متأكد من تسجيل الخروج؟",
                    yesOnPressed: () async {
                      await widget._auth.signOut();
                      //print("hellppp");
                      Navigator.of(context, rootNavigator: true).pop('dialog');//عكستهم
                      //Navigator.of(context).push(
                             //  MaterialPageRoute(builder: (context) => SignIn()),//CHANGE IT
                             //);
                      
                    },

                    noOnPressed: () {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                    yes: "نعم",
                    no: "لا");
                showDialog(context: context, builder: (BuildContext context) => baseDialog);
              }
              ,),


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

