import 'package:flutter/material.dart';
import '../../../constants.dart';

class TRny extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple[100],
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "الممنوعات",
                    style: TextStyle(fontSize: 19),
                  ),
                ),
                Tab(
                  child: Text(
                    "الإجبارية",
                    style: TextStyle(fontSize: 19),
                  ),
                ),
              ],
              indicatorColor: kPrimaryColor,
              unselectedLabelColor: Colors.white54,
            ),
            // title: Text('إرشادات القيادة'),
          ),
          // body: TabBarView(
          //   children: [
          //     // Text('المرفوضة'),
          //     // Text('المعلقة'),
          //     // Text('المقبولة'),
          //     new RejectedLessons(),
          //     new PendingLessons(),
          //     new AcceptedLessons(),
          //   ],
          // ),
        ),
      ),
    );
  }
}
