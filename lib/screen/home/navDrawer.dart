import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/services/database.dart';
import 'package:meras/models/MyUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';





class NavDrawer extends StatelessWidget  {

   final AuthService _auth = AuthService(); 
   
  
 


  @override
   Widget build(BuildContext context)  {
dynamic mailID = _auth.getEmail();
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
              color: Colors.deepPurple[100],
              
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
            onTap: () async {
                await _auth.signOut();
              },
          ),
        ],
      ),  
    ),);
  
  }


}

