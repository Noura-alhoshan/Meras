import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:meras_sprint1/Global.dart';
import 'package:meras_sprint1/TRpages/TRhome.dart';
import 'TRpages/TRexplore.dart';
import 'TRpages/TRlessons.dart';
import 'TRpages/TRnotification.dart';

//
class TRcategory extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TRcategory> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // Generates push notification token
    firebaseMessaging.getToken().then((token) {
      print(token);
    });
  }

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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_active_sharp,
              color: Colors.red,
            ),
            title: Text(
              'التنبيهات',
              style: TextStyle(color: Colors.red),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.car_repair,
              color: Colors.purple,
            ),
            title: Text(
              'الدروس',
              style: TextStyle(color: Colors.purple),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.blue,
            ),
            title: Text(
              'المدربين',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.green,
            ),
            title: Text(
              'الرئيسية',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
