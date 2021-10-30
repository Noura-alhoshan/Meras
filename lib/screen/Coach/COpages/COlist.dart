import 'package:flutter/material.dart';

import 'package:meras/screen/home/navDrawer.dart';

import '../../../constants.dart';
import 'PendingRequest.dart';
import 'acceptedRequest.dart';
import 'rejectedRequest.dart';

class COlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          extendBody: true,
          //extendBodyBehindAppBar: true,
          drawer: NavDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.deepPurple[100],
            bottom: TabBar(
              tabs: [
                Tab(text: 'المرفوضة'),
                Tab(
                  text: 'قيد الأنتظار',
                ),
                Tab(text: 'المقبولة'),
              ],
              indicatorColor: kPrimaryColor,
              unselectedLabelColor: Colors.white54,
            ),
            title: Text('        قائمة طلبات التدريب'),
          ),
          body: TabBarView(
            children: [
              // Text('المرفوضة'),
              // Text('المعلقة'),
              // Text('المقبولة'),

              new RejectedRequest(),
              new PendingRequest(),
              new AcceptedRequest(),
            ],
          ),
        ),
      ),
    );
  }
}
