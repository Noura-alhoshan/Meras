import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:meras/screen/Coach/COpages/COlist.dart';
import 'COpages/COhome.dart';
import 'COpages/COlist.dart';
import 'COpages/CoachDate.dart';
import 'Cchat.dart';

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
          ? COlist()
          : selectedIndex == 1
              ? CoachDate()
              : selectedIndex == 2
                  ? Cchat()
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
              icon: Icon(Icons.list_alt),
              title: Text('الطلبات'),
              activeColor: Colors.pink),
          BottomNavyBarItem(
              icon: Icon(Icons.perm_contact_calendar),
              title: Text('المواعيد'),
              activeColor: Colors.purple),
              BottomNavyBarItem(
              icon: Icon(Icons.chat),
              title: Text('المحادثات'),
              activeColor: Colors.yellow.shade700),
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('الرئيسية'),
              activeColor: Colors.blue),
        ],
      ),
    );
  }
}