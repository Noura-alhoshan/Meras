import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:meras1/widget/Background.dart'd.dart';
import 'package:meras1/Test.dart';
//import 'package:meras1/screen/admin/navDraweradmin.dart';
import 'package:meras1/screen/home/navDrawer.dart';
import 'package:meras1/widget/BackgroundA.dart';

void main() async {
  runApp(MaterialApp(
    routes: {},
  ));
}

class CoachlistScreen extends StatefulWidget {
  @override
  _CoachlistScreenState createState() => _CoachlistScreenState();
}

class _CoachlistScreenState extends State<CoachlistScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return SingleChildScrollView(
      child: document['Status'] == 'A'
          ? Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Card(
                child: ListTile(
                  title: Text(
                    document['Fname'] + ' ' + document['Lname'],
                    textAlign: TextAlign.right,
                    // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    document['Age'] +
                        ' :' +
                        'الجنس:' +
                        ' ' +
                        document['Gender'] +
                        '        ' +
                        'العمر',
                    textAlign: TextAlign.right,
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: document['Gender'] == 'أنثى'
                      ? Image.asset("assets/Female.png")
                      : Image.asset("assets/driver-male.jpg"),
                  leading: ElevatedButton(
                    child: Text('معلومات المدرب'),
                    onPressed: () {
                      nav(document.id);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: Color(0xFF6F35A5),
                        textStyle: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('قائمة المدربين المتاحين'),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: SingleChildScrollView(
        child: BackgroundA(
          child: Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Coach').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('loading 7 ...');
                  return ListView.builder(
                    //physics: const NeverScrollableScrollPhysics(), //<--here
                    controller: _scrollController,

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

  void nav(String icd) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return TestScreen(icd);
      }),
    );
  }
}
