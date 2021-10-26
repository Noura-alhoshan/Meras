import 'package:flutter/material.dart';

import 'package:meras/screen/home/navDrawer.dart';

import '../../../constants.dart';
import 'requests/PendingRequest.dart';
import 'requests/acceptedRequest.dart';
import 'requests/rejectedRequest.dart';

class COlist extends StatelessWidget {
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
                Tab(text: 'المرفوضة'),
                Tab(
                  text: 'المعلقة',
                ),
                Tab(text: 'المقبولة'),
              ],
              indicatorColor: kPrimaryColor,
              unselectedLabelColor: Colors.white54,
            ),
            title: Text('قائمة الطلبات'),
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
