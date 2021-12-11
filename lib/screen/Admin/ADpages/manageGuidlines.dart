import 'package:flutter/material.dart';
import 'package:meras/components/adminRounded_button.dart';
import 'package:meras/screen/Admin/ADpages/addGuidlines.dart';
import 'package:meras/screen/Admin/ADpages/editGuidlines.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Trainee/TRpages/TRguidelines.dart';
import 'package:meras/screen/authenticate/background.dart';

import '../../../constants.dart';
import 'deleteGuidelines.dart';

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
          centerTitle: true,
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
        ),
        body: Background(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50.0),
              SizedBox(height: 50.0),
              SizedBox(height: 40.0),
              SizedBox(height: 30.0),
              Container(
                width: 350,
                height: 90,
                padding: EdgeInsets.all(10),
                decoration: new BoxDecoration(
                  color: Colors.deepPurple[50],
                  border: Border.all(color: Colors.white, width: 0.0),
                  borderRadius: new BorderRadius.all(Radius.circular(29.0)),
                ),
                child: Center(
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TRguidelines()))
                    },
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "إشارات السير المضافة   ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            Icons.check,
                            color: kPrimaryColor,
                            size: 35,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: 350,
                height: 90,
                padding: EdgeInsets.all(10),
                decoration: new BoxDecoration(
                  color: Colors.deepPurple[50],
                  border: Border.all(color: Colors.white, width: 0.0),
                  borderRadius: new BorderRadius.all(Radius.circular(29.0)),
                ),
                child: Center(
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddGuidlines()))
                    },
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "إضافة إشارة سير ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            Icons.add,
                            color: kPrimaryColor,
                            size: 35,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: 350,
                height: 90,
                padding: EdgeInsets.all(10),
                decoration: new BoxDecoration(
                  color: Colors.deepPurple[50],
                  border: Border.all(color: Colors.white, width: 0.0),
                  borderRadius: new BorderRadius.all(Radius.circular(29.0)),
                ),
                child: Center(
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditGuidlines()))
                    },
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "تعديل معلومات إشارات السير    ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            Icons.border_color,
                            color: kPrimaryColor,
                            size: 23,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: 350,
                height: 90,
                padding: EdgeInsets.all(10),
                decoration: new BoxDecoration(
                  color: Colors.deepPurple[50],
                  border: Border.all(color: Colors.white, width: 0.0),
                  borderRadius: new BorderRadius.all(Radius.circular(29.0)),
                ),
                child: Center(
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => deleteGuidelines()))
                    },
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "حذف إشارة سير  ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            Icons.clear,
                            color: kPrimaryColor,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
