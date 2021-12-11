import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meras/screen/Trainee/Tchat.dart';
import 'TRpages/TRexplore.dart';
import 'TRpages/TRhome.dart';
import 'TRpages/TRlessons.dart';
import 'TRpages/TRnotification.dart';

class TRcategory extends StatefulWidget {
  final String traineeId;

  const TRcategory({Key? key, required this.traineeId}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<TRcategory> {
  int selectedIndex = 4;
  int numberOfNotification = 0;
  bool isNewNotification = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getNotificationData();
    GetStorage().listenKey("NewNotification", (value) {
      try {
        isNewNotification = value as bool;
      } catch (e) {
        isNewNotification = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: selectedIndex == 0
          ? TRnotification(
              traineeId: widget.traineeId,
            )
          : selectedIndex == 1
              ? TRlessons()
              : selectedIndex == 2
                  ? TRexploreScreen()
                  : selectedIndex == 3
                      ? Tchat()
                      : TRhome(),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: selectedIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) async {
          if (index == 0) GetStorage().write("NewNotification", false);
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
                    if (selectedIndex != 0 && isNewNotification)
                      Positioned(
                        top: 0,
                        left: 16,
                        child: Container(
                          padding: EdgeInsets.all(1.5),
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          child: Text(
                            "",
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
              title: Text('المدربين',),
              activeColor: Colors.red),
               BottomNavyBarItem(
              icon: Icon(Icons.chat),
              title: Text('المحادثات'),
              activeColor: Colors.yellow.shade700),
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('الرئيسية'),
              activeColor: Colors.green),
        ],
      ),
    );
  }

  // Future<void> getNotificationData() async {
  //   FirebaseFirestore.instance
  //       .collection('Requests')
  //       .where("Tid", isEqualTo: widget.traineeId)
  //       .where("Status", whereIn: ["A", "D"])
  //       .snapshots()
  //       .listen((event) {
  //         numberOfNotification = event.docs.length;
  //         setState(() {});
  //       });
  // }
}