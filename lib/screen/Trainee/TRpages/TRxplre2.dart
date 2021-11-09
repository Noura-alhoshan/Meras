import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Trainee/TRpages/BackgroundLo22.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'BackgroundLo2.dart';

import 'DraftF.dart';

class TRexplore2Screen extends StatefulWidget {
  @override
  _TRexplore2ScreenState createState() => _TRexplore2ScreenState();
}

class _TRexplore2ScreenState extends State<TRexplore2Screen> {
  //final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (String) {
              setState(() {
                name = String;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
            ? FirebaseFirestore.instance
                .collection('Coach')
                .where("Fname", isEqualTo: name)
                .snapshots()
            : FirebaseFirestore.instance.collection("Coach").snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data!.docs[index];
              return Card(
                child: Row(
                  children: <Widget>[
                    Text(
                      data['Gender'],
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      data['Fname'],
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
