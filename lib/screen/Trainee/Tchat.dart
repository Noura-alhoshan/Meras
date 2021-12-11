import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as ui;
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Chat/constants.dart';
import 'package:meras/screen/Chat/screens/Backg.dart';
import 'package:meras/screen/Trainee/TRpages/BackgroundLo22.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'package:meras/screen/Chat/screens/chat.dart';

class Tchat extends StatefulWidget {
  @override
  _TRexploreScreenState createState() => _TRexploreScreenState();
}

class _TRexploreScreenState extends State<Tchat> {
  //final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final Muid = user!.uid;
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'المحادثات',
          // textDirection: TextDirection.rtl,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade100, Colors.deepPurple.shade200],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Backg(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("messages")
                    .orderBy('Time', descending: true)
                    .where('peers', arrayContains: Muid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Loading();
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) =>
                        _buildListItem(context, (snapshot.data!).docs[index]),
                  );
                }),
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    String fullname = document['Cname'];
    String shortM = '';
    String pic = "";
    String from = "";
    int spl = fullname.indexOf(' ');
    String Fname = fullname.substring(0, spl);
    late String dot = "";

    if (document["lastFrom"] != document["Tid"] && document['unread'] == true) {
      dot = '.';
    }

    if (document['lastMessage']
        .toString()
        .contains("https://firebasestorage")) {
      pic = "صورة";
    } else if (document['lastMessage'].toString().length > 20) {
      String lla = document['lastMessage'];
      shortM = lla.substring(0, 18) + "...";
    } else
      shortM = document['lastMessage'];

    if (shortM.contains("\n")) {
      shortM = shortM.substring(0, shortM.indexOf("\n"));
    }

    if (document['lastFrom'] == document['Tid']) {
      from = 'أنت: ';
      dot = '';
    } else
      from = Fname + ": ";

    late String tname;
    FirebaseFirestore.instance
        .collection('trainees')
        .doc(document['Tid'])
        .get()
        .then((ds) {
      tname = ds['Fname'] + ' ' + ds['Lname'];
    }).catchError((e) {
      print(e);
    });

    late String phe = '';
    FirebaseFirestore.instance
        .collection('Coach')
        .doc(document['Cid'])
        .get()
        .then((ds) {
      phe = ds['Phone Number'];
    }).catchError((e) {
      print(e);
    });
    return SingleChildScrollView(
        child: Container(
            height: 104,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Material(
                child: InkWell(
                    onTap: () {
                      if (document["lastFrom"] != document["Tid"] &&
                          document['unread'] == true) {
                        dot = '';
                        //FirebaseFirestore.instance

                        FirebaseFirestore.instance
                            .collection('messages')
                            .doc(document["ID"])
                            .update({'unread': false});
                        //;});
                      }
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Chat(
                            currentUserId: document['Tid'],
                            peerAvatar:
                                "https://i.postimg.cc/59D0sP2g/Female.png",
                            peerId: document['Cid'],
                            peerName: document['Cname'],
                            Cname: document['Cname'],
                            Tname: tname,
                            Tid: document['Tid'],
                            Cid: document['Cid'],
                            phone: phe,
                          ),
                        ),
                      );
                    },
                    splashColor: Colors.deepPurple[800],
                    child: Card(
                      child: ListTile(
                        leading: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              text: ui.DateFormat('kk:mm').format(DateTime
                                      .fromMillisecondsSinceEpoch(int.parse(
                                          document['lastTime'].toString()))) +
                                  "\n",
                              style: TextStyle(
                                  height: 1.6,
                                  fontSize: 11.7,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "$dot",
                                  style: TextStyle(
                                    height: .27,
                                    fontSize: 120,
                                    color: Colors.blue,
                                  ),
                                ),
                              ]),
                        ),

                        // DateFormat('dd MMM kk:mm').format(
                        //         DateTime.fromMillisecondsSinceEpoch(
                        //             int.parse(document['lastTime'].toString()))),

                        //             style: TextStyle(height: 0.4, fontSize: 15,color: Colors.red),),
                        title: Text(
                          document['Cname'],
                          style: TextStyle(
                              height: 2,
                              fontSize: 15.9,
                              color: primaryColor,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                        subtitle: (pic == "صورة")
                            ? RichText(
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.right,
                                text: TextSpan(
                                    text: from,
                                    style: TextStyle(
                                      height: 2,
                                      fontSize: 15,
                                      color: Colors.green[700],
                                    ), //fontWeight: FontWeight.bold

                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "صورة",
                                        style: TextStyle(
                                            height: 2,
                                            fontSize: 15,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ]),
                              )
                            : RichText(
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                text: TextSpan(
                                    text: from,
                                    style: TextStyle(
                                      height: 2,
                                      fontSize: 15,
                                      color: Colors.green[700],
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: shortM,
                                        style: TextStyle(
                                            height: 2,
                                            fontSize: 15,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ]),
                              ),
                        trailing: Image.asset("assets/images/Female.png"),
                      ),
                    )))));
  }
}
