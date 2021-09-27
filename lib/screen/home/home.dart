import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meras/constants.dart';
import 'package:meras/models/MyUser.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart'; 
import 'package:meras/services/auth.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'package:provider/provider.dart';


//this home page will be edited to fit our app, this one is just for testing ^_^
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final userid = user!.uid;
   CollectionReference firevar = FirebaseFirestore.instance.collection('users');



class home extends StatefulWidget {
	  home({ required this.userId});

	AuthService aut= AuthService();
	final String userId;

	  @override
	  State<StatefulWidget> createState() => new _HomePageState();
	}
	

	class _HomePageState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        //title: Text('Side menu'),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Center(
        child: Text(userid.toString()),
      ),
    );
  }
}