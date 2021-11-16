import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/screen/Trainee/TRpages/TRprofile.dart';
import 'package:meras/screen/Trainee/TRpages/navDrawerTR.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'package:meras/screen/Trainee/TRpages/acceptedLessons.dart';
import 'package:meras/screen/Trainee/TRpages/rejectedLessons.dart';
import 'package:meras/screen/Trainee/TRpages/pendingLessons.dart';

import '../../../constants.dart';
import 'acceptedLessons.dart';

class TRlessons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          drawer: NavDrawerTR(),
          appBar: AppBar(
            backgroundColor: Colors.deepPurple[100],
            bottom: TabBar(
              tabs: [
                Tab(text: 'المرفوضة/الملغاة'),
                Tab(
                  text: 'قيد الانتظار',
                ),
                Tab(text: 'المقبولة'),
              ],
              indicatorColor: kPrimaryColor,
              unselectedLabelColor: Colors.white54,
            ),
            title: Text('                 قائمة الدروس'),
          ),
          body: TabBarView(
            children: [
              // Text('المرفوضة'),
              // Text('المعلقة'),
              // Text('المقبولة'),
              new RejectedLessons(),
              new PendingLessons(),
              new AcceptedLessons(),
            ],
          ),
        ),
      ),
    );
  }

  // void nav(String userid, BuildContext context) async {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) {
  //       return TRprofile(userid);
  //     }),
  //   );
  // }
}
