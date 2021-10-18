import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import 'COpages/COexplore.dart';
import 'COpages/COhome.dart';
import 'COpages/COlessons.dart';
import 'COpages/COnotification.dart';

//import 'package:meras_sprint1/TRpages/TRhome.dart';

class COcategory extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<COcategory> {
  int selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: selectedIndex == 0
          ? COnotification()
          : selectedIndex == 1
              ? COlessons()
              : selectedIndex == 2
                  ? COexplore()
                  : selectedIndex == 3
                      ? COhome()
                      : COhome(),
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
              icon: Icon(Icons.car_repair),
              title: Text('الدروس'),
              activeColor: Colors.purple),
          BottomNavyBarItem(
              icon: Icon(Icons.search),
              title: Text('المدربين'),
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
