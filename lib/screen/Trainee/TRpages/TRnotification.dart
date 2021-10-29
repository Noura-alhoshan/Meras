import 'dart:async';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:meras/screen/Admin/ADpages/coachProfile_admin.dart';
import 'package:meras/screen/Admin/services/navDraweradmin.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';

class TRnotification extends StatefulWidget {
  final String traineeId;

  const TRnotification({Key? key, required this.traineeId}) : super(key: key);
  @override
  _TRnotification createState() => _TRnotification();
}

class _TRnotification extends State<TRnotification> {
  //final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  static const IconData swap_vert_rounded =
      IconData(0xf01fc, fontFamily: 'MaterialIcons');

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    // String dateTime = "";
    // final indexToSplit = (document["DateTime"] as String).indexOf("M");
    // if (indexToSplit > 0) {
    //   dateTime =
    //       (document["DateTime"] as String).substring(0, indexToSplit + 1);
    // }

    DateTime reqDate = DateTime.now();
    print(document["reqDate"].runtimeType);
    if (document["reqDate"] != null &&
        document["reqDate"].runtimeType == Timestamp) {
      reqDate = (document["reqDate"] as Timestamp).toDate();
    } else if (document["reqDate"] != null &&
        document["reqDate"].runtimeType == String) {
      reqDate = DateTime.now();
    }

    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        elevation: 6,
        shadowColor: Colors.deepPurple[500],
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.white, width: 1)),
        child: Container(
          height: 120,
          width: double.infinity,
          child: Row(
            children: [
              Flexible(
                flex: 8,
                child: SizedBox.expand(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        (document['Status'] == 'P'
                                ? "طلبك قيد الانتظار مع المدرب"
                                : document['Status'] == 'D'
                                    ? "تم رفض طلبك مع المدرب"
                                    : "تم قبول طلبك مع المدرب") +
                            " " +
                            document['CoachName'] +
                            ' ' +
                            document['CoachName2'],
                        style: TextStyle(height: 2.5, fontSize: 15),
                        // maxLines: 1,
                        textAlign: TextAlign.right,
                      ),
                      if (document['reqDate'] != null)
                        Text(
                          "${reqDate.month}/${reqDate.day}/${reqDate.year} ${DateFormat.jm().format(reqDate)}",
                          style: TextStyle(height: 1.5, fontSize: 11),
                          textAlign: TextAlign.right,
                        ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/icons/ringing.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    //   Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDraweradmin(),
      appBar: AppBar(
        /*
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.swap_vert_rounded,
              color: Colors.black,
              size: 40,
            ),
            onPressed: () {
              // do something
            },
          )
        ],*/
        title: Text('التنبيهات'),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: BackgroundA(
            //   child: Scrollbar(
            //   isAlwaysShown: true,
            //    controller: _scrollController,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Requests')
                    .where("Tid", isEqualTo: widget.traineeId)
                    .where("Status", whereIn: ["A", "D"])
                    .orderBy("reqDate", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('loading 7 ...');
                  print("**********************");
                  print(snapshot.data!.docs.length);

                  return ListView.builder(
                    //    controller: _scrollController,

                    //physics: const NeverScrollableScrollPhysics(), //<--here

                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) =>
                        _buildListItem(context, (snapshot.data!).docs[index]),
                  );
                }),
            // ),
          ),
        ),
      ),
    );
  }

  void nav(String icd) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return ADcoachProfile(icd);
      }),
    );
  }
}
