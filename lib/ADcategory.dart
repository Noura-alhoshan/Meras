import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:meras_sprint1/ADpages/ADhome.dart';
import 'package:meras_sprint1/ADpages/ADlist.dart';

//
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
          ? ADlist()
          : selectedIndex == 1
              ? ADhome()
              : ADhome(),
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
              Icons.list_alt_sharp,
              color: Colors.blue,
            ),
            title: Text(
              'القائمة',
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
