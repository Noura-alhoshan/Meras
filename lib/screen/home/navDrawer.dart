import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'BaseAlertDialog.dart';
//import 'package:flutter/material.dart';


class NavDrawer extends StatelessWidget  {

 final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context)  {
//dynamic mailID = _auth.getEmail();
//String mail= mailID.toString();
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
              title: Text('الملف الشخصي',textAlign: TextAlign.end,),
              onTap: () => null,
            ),

            Divider(),
            ListTile(
              title: Text('تسجيل الخروج',textAlign: TextAlign.end,),
              trailing: Icon(Icons.exit_to_app),
              onTap: ()  {

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
                showDialog(context: context, builder: (BuildContext context) => baseDialog);
              }
              ,),
          ],
        ),
      ),
    );

  }
}