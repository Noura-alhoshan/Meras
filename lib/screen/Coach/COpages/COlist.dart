import 'package:flutter/material.dart';
import 'package:meras/screen/home/CnavDrawer.dart';

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
          drawer: CNavDrawer(),
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.shade100,
                    Colors.deepPurple.shade200
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
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
            title: Text('قائمة طلبات التدريب'),
            centerTitle: true,
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
