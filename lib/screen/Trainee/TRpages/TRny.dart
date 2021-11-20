import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import 'card_list_widget.dart';

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
            title: Center(
                child: Row(
              children: [
                IconButton(onPressed: Get.back, icon: Icon(Icons.arrow_back)),
                SizedBox(width: 50),
                Center(child: Text('الإشارات التنظيمية')),
              ],
            )),
          ),
          body: TabBarView(
            children: [
              CardListWidget(type: 'N'),
              CardListWidget(
                type: 'Y',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
