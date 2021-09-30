import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
//import 'package:meras1/CoachList.dart';
import 'package:meras1/screen/admin/Dashboard.dart';
import 'package:meras1/screen/tranee/Coachlist.dart';
import 'package:meras1/screen/tranee/TRpages/TRlessons.dart';
import 'package:meras1/screen/tranee/TRpages/TRnotification.dart';

//import 'TRpages/TRexplore.dart';
import 'TRpages/TRhome.dart';
//import 'package:meras_sprint1/TRpages/TRhome.dart';

class TRcategory extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TRcategory> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     backgroundColor: Colors.purple[400],
      //s    title: Center(child: Text('مراس'))),
      body: selectedIndex == 0
          ? TRnotification()
          : selectedIndex == 1
              ? TRlessons()
              : selectedIndex == 2
                  ? CoachlistScreen()
                  : selectedIndex == 3
                      ? TRhome()
                      : TRhome(),
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
