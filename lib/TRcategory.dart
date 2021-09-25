import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:meras_sprint1/Global.dart';
import 'package:meras_sprint1/TRpages/TRhome.dart';
import 'TRpages/TRexplore.dart';
import 'TRpages/TRlessons.dart';
import 'TRpages/TRnotification.dart';

class TRcategory extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TRcategory> {
  int selectedIndex = 0;

  // handleNotifications() async {
  //   await firebaseMessaging.getToken().then((value) {
  //     print('Token');
  //     print(value);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple[400],
          title: Center(child: Text('مراس'))),
      body: selectedIndex == 0
          ? TRnotification()
          : selectedIndex == 1
              ? TRlessons()
              : selectedIndex == 2
                  ? TRexplore()
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
