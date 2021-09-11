import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart'; 


//this home page will be edited to fit our app, this one is just for testing ^_^



class home extends StatelessWidget {
 // const home({ Key? key }) : super(key: key);

  final AuthService _auth = AuthService();

 @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}