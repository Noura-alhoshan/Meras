import 'package:flutter/material.dart';
import 'package:meras/screen/authenticate/sign_in.dart';
import 'package:meras/services/auth.dart';

import '../../../constants.dart';
import '../../home/BaseAlertDialog.dart';

class NavDraweradmin extends StatelessWidget {
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
                
                    child: Image.asset(
                      'assets/images/whitelogo.png',
                      height: 230,
                   
                ),
                decoration: BoxDecoration(
                    color: Colors.white,

                    ), //child: null,
              ),
            ),
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
