import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:meras_sprint1/ADpages/ADhome.dart';
import 'package:meras_sprint1/ADpages/ADlist.dart';
import 'package:meras_sprint1/ADpages/ADnotification.dart';

class ADcategory extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ADcategory> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple[400],
          title: Center(child: Text('مراس'))),
      body: selectedIndex == 0
          ? ADnotification()
          : selectedIndex == 1
              ? ADlist()
              : selectedIndex == 2
                  ? ADhome()
                  : ADhome(),
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
              icon: Icon(Icons.notifications_active_sharp),
              title: Text('التنبيهات'),
              activeColor: Colors.pink),
          BottomNavyBarItem(
              icon: Icon(Icons.list_alt_sharp),
              title: Text('القائمة'),
              activeColor: Colors.blue),
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('الرئيسية'),
              activeColor: Colors.green),
        ],
      ),
    );
  }
}
