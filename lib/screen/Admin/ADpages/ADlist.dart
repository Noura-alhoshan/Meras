import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';

import '../services/navDraweradmin.dart';
import 'coachProfile_admin.dart';

class ADlistScreen extends StatefulWidget {
  @override
  _ADlistScreenState createState() => _ADlistScreenState();
}

class _ADlistScreenState extends State<ADlistScreen> {
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
                    document['Fname'] + ' ' + document['Lname'],
                    style: TextStyle(height: 2, fontSize: 15),
                    textAlign: TextAlign.right,
                  ),
                  subtitle: Text(
                    'التاريخ :' +
                        document['Time'].toDate().toString().substring(1, 10),
                    style: TextStyle(height: 2, fontSize: 11),
                    textAlign: TextAlign.right,
                  ),
                  trailing: document['Gender'] == 'أنثى'
                      ? Image.asset("assets/images/Female.png")
                      : Image.asset("assets/images/driver-male.jpg"),
                  leading: ElevatedButton(
                    child: Text('معلومات المدرب   '),
                    onPressed: () {
                      nav(document.id);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: Color(0xFF6F35A5),
                        textStyle: TextStyle(fontSize: 16)),
                  ),
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
        title: Center(child: Text('قائمة المدربين قيد الانتظار')),
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
                    .collection('Coach')
                    .orderBy('Time', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Loading();

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
