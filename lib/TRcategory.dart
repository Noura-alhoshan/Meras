import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class TRcategory extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TRcategory> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple[900],
          title: Center(child: Text('مراس'))),
      body: Center(child: Text('')),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: selectedIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text(''),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.car_repair),
              title: Text(''),
              activeColor: Colors.purpleAccent),
          BottomNavyBarItem(
              icon: Icon(Icons.search),
              title: Text(''),
              activeColor: Colors.pink),
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text(''),
              activeColor: Colors.blue),
        ],
      ),
    );
  }
}
