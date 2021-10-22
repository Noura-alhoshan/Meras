import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meras/screen/Admin/ADpages/coachProfile_admin.dart';
import 'package:meras/screen/Admin/services/navDraweradmin.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';

class TRnotification extends StatefulWidget {
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
    return SingleChildScrollView(
      child: document['Status'] == 'P'
          ? Container(
              height: 100,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Card(
                child: ListTile(
                  title: Text(
                    "طلبك قيد الانتظار مع المدرب" +
                        " " +
                        document['CoachName'] +
                        ' ' +
                        document['CoachName2'],
                    style: TextStyle(height: 2, fontSize: 15),
                    textAlign: TextAlign.right,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (document['DateTime'] != null)
                        Text(
                          document['DateTime'].toString().substring(0, 10) +
                              " " +
                              document['DateTime'].toString().substring(11, 19),
                          style: TextStyle(height: 2, fontSize: 11),
                          textAlign: TextAlign.right,
                        ),
                      // Text(
                      //   document['Des'],
                      //   style: TextStyle(height: 2, fontSize: 11),
                      //   textAlign: TextAlign.right,
                      // ),
                    ],
                  ),
                  // trailing: document['Gender'] == 'أنثى'
                  //     ? Image.asset("assets/images/Female.png")
                  //     : Image.asset("assets/images/driver-male.jpg"),
                  // leading: ElevatedButton(
                  //   child: Text('معلومات المدرب   '),
                  //   onPressed: () {
                  //     nav(document.id);
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //       shape: StadiumBorder(),
                  //       primary: Color(0xFF6F35A5),
                  //       textStyle: TextStyle(fontSize: 16)),
                  // ),
                ),
                elevation: 6,
                shadowColor: Colors.deepPurple[500],
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: Colors.white, width: 1)),
              ),
            )
          : null,
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
                    // .orderBy('Time', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('loading 7 ...');
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
