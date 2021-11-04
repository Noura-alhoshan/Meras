import 'package:flutter/material.dart';
import 'package:meras/components/adminRounded_button.dart';
import 'package:meras/screen/Admin/ADpages/addGuidlines.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';

import '../../../constants.dart';

class ManageGuidlines extends StatefulWidget {
  @override
  _ManageGuidlinesState createState() => _ManageGuidlinesState();
}

class _ManageGuidlinesState extends State<ManageGuidlines> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        //drawer: NavDraweradmin(),
        appBar: AppBar(
          title: Text('إدارة معلومات إشارات السير'),
          backgroundColor: Colors.deepPurple[100],
        ),
        body: BackgroundA(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50.0),
              SizedBox(height: 50.0),
              SizedBox(height: 40.0),
              Center(
                child: RoundedButtonAdmin(
                    text: 'إضافة إشارات سير',
                    press: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddGuidlines()));
                    }),
              ),
              RoundedButtonAdmin(
                  text: 'تعديل معلومات إشارات السير',
                  press: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => AddGuidlines()));
                  }),
            ],
          ),
        ));
  }
}
