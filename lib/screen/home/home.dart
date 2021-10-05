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

  // CollectionReference firevar = FirebaseFirestore.instance.collection('users');



class home extends StatefulWidget {
	  home();

	AuthService aut= AuthService();
	//final String? userId;

	  @override
	  State<StatefulWidget> createState() => new _HomePageState();
	}
	

	class _HomePageState extends State<home> {
     void initState() {
    super.initState();
  }
 @override
  Widget build(BuildContext context,) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    dynamic userid = user!.uid;

     print(userid+" hello there");//first user only

     //print(widget.userId);//updated
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        //title: Text('Side menu'),
        backgroundColor: Colors.deepPurple[100],
      ),
    
      body: Center( child: Text(userid),),
      
    );
    
  }
  
}

// class MyHomePage extends StatelessWidget {
//   MyHomePage(String? userId);

//   //get userId => userId;

//   @override
//   Widget build(BuildContext context,) {
//     return Scaffold(
//       drawer: NavDrawer(),
//       appBar: AppBar(
//         //title: Text('Side menu'),
//         backgroundColor: Colors.deepPurple[100],
//       ),
//       body: Center(
//         child: Text(userId),
//       ),
//     );
//   }
//}