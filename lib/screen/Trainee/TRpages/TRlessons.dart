import 'package:flutter/material.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'package:meras/screen/Trainee/TRpages/acceptedLessons.dart';
import 'package:meras/screen/Trainee/TRpages/rejectedLessons.dart';
import 'package:meras/screen/Trainee/TRpages/pendingLessons.dart';

import '../../../constants.dart';

class TRlessons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          //extendBodyBehindAppBar: true,
          drawer: NavDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.deepPurple[100],
            bottom: TabBar(
              tabs: [
                Tab(text: 'المرفوضة/الملغاة'),
                Tab(
                  text: 'المعلقة',
                ),
                Tab(text: 'المقبولة'),
              ],
              indicatorColor: kPrimaryColor,
              unselectedLabelColor: Colors.white54,
            ),
            title: Text('قائمة الدروس'),
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
}
