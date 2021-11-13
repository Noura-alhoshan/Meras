import 'package:firebase_auth/firebase_auth.dart';
import 'package:meras/screen/Admin/services/BaseAlertDialog.dart';
import 'package:meras/screen/Trainee/TRpages/TRprofile.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
//import 'package:flutter/material.dart';

class NavDrawerTR extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    return Container(
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
                    child: Image.asset(
                      'assets/images/def.jpg',
                      height: 230,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                ), //child: null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('الملف الشخصي'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return TRprofile(uid);
                  }),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('تسجيل الخروج'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                var baseDialog = BaseAlertDialog(
                    title: "",
                    content: "هل أنت متأكد من تسجيل الخروج؟",
                    yesOnPressed: () async {
                      await _auth.signOut();
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
}
