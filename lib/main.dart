//import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meras/screen/home/home.dart';
import 'package:meras/services/auth.dart';
import 'package:meras/screen/wrapper.dart'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meras/models/MyUser.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp(MyApp());
}



class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      //catchError: () =>null,
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),///wrapper
      ),
      
    );
  }
}

//Directionality( // add this
        //textDirection: TextDirection.rtl, 
        //child:
