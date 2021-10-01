import 'package:flutter/material.dart';

import 'package:meras1/Services/auth.dart';

import '../home/BaseAlertDialog.dart';

class NavDrawertranee extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
//dynamic mailID = _auth.getEmail();
//String mail= mailID.toString();
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
                      'assets/def.jpg',
                      height: 230,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    // color: kPrimaryLightColor,

                    ), //child: null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('الملف الشخصي'),
              onTap: () => null,
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
                      //Navigator.pop( context,
                      // MaterialPageRoute(builder: (context) => SignIn()),);
                      //  Navigator.of(context, rootNavigator: true).pop('dialog');
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
