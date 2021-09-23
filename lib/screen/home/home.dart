import 'package:firebase_auth/firebase_auth.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart'; 
import 'package:meras/services/auth.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'package:provider/provider.dart';


//this home page will be edited to fit our app, this one is just for testing ^_^



class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
        child: Text('home'),
      ),
    );
  }
}