import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

//import 'TRpages/TRexplore.dart';
import 'TRpages/TRexplore.dart';
import 'TRpages/TRhome.dart';
import 'TRpages/TRlessons.dart';
import 'TRpages/TRnotification.dart';
//import 'package:meras_sprint1/TRpages/TRhome.dart';

class TRcategory extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TRcategory> {
  int selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: selectedIndex == 0
          ? TRnotification()
          : selectedIndex == 1
              ? TRlessons()
              : selectedIndex == 2
                  ? TRexploreScreen()
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
              icon: SizedBox(
                width: 34,
                child: Stack(
                  children: [
                    Icon(Icons.notifications_active_sharp),
                    Positioned(
                      top: 0,
                      left: 20,
                      child: Container(
                        padding: EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        child: Text(
                          '10',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              title: Stack(
                children: [
                  Text('التنبيهات'),
                ],
              ),
              activeColor: Colors.blue),
          BottomNavyBarItem(
              icon: Icon(Icons.car_repair),
              title: Text('الدروس'),
              activeColor: Colors.purple),
          BottomNavyBarItem(
              icon: Icon(Icons.search),
              title: Text('المدربين'),
              activeColor: Colors.red),
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('الرئيسية'),
              activeColor: Colors.green),
        ],
      ),
    );
  }
}
