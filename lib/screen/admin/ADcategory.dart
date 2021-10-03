import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:meras1/screen/admin/ADnotification.dart';
import 'package:meras1/screen/admin/Dashboard.dart';

class ADcategory extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ADcategory> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: selectedIndex == 1
          ? ADnotification()
          : selectedIndex == 0
              ? DashboardScreen()
              : DashboardScreen(),
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
