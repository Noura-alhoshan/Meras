//import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      //catchError: () =>null,
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
      
    );
  }
}

//Directionality( // add this
        //textDirection: TextDirection.rtl, 
        //child:
