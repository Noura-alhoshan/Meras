import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'ADpages/ADhome.dart';
import 'ADpages/ADlist.dart';

class ADcategory extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ADcategory> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: selectedIndex == 0
          ? ADlistScreen()
          : selectedIndex == 1
              ? ADhome()
              : ADhome(),
      //  : selectedIndex == 2
      //       ? ADhome()
      //        : ADhome(),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: selectedIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          //BottomNavyBarItem(
          //   icon: Icon(Icons.notifications_active_sharp),
          //   title: Text('التنبيهات'),
          //    activeColor: Colors.pink),
          BottomNavyBarItem(
              icon: Icon(Icons.list_alt_sharp),
              title: Text('القائمة'),
              activeColor: Colors.blue),
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('الرئيسية'),
              activeColor: Colors.pink),
        ],
      ),
    );
  }
}
