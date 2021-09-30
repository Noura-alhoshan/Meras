import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meras1/screen/admin/navDraweradmin.dart';
import 'package:meras1/widget/Background.dart';
import 'package:meras1/Test.dart';
import 'package:meras1/screen/admin/coachProfile_admin.dart';

void main() async {
  runApp(MaterialApp(
    routes: {
      //  '/test': (context) => TestScreen(),
    },
  ));
}

//
//final FirebaseAuth auth = FirebaseAuth.instance;
//void inputData() {
//f//inal User user = auth.currentUser;
//final uid = user.uid;
// Similarly we can get email as well
//final uemail = user.email;
// print(uid);
//print(uemail);
//}
//RaisedButton(
//          onPressed: getCurrentUser,
//             child: Text('Details'),
//           ),

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return SingleChildScrollView(
      child: document['Status'] == 'P'
          ? Container(
              child: Card(
                child: ListTile(
                  title: Text(
                    document['Fname'] + ' ' + document['Lname'],
                    textAlign: TextAlign.right,
                  ),

                  //  subtitle: Text(document['Discerption']),
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
      drawer: NavDraweradmin(),
      appBar: AppBar(
        title: Text('قائمة المدربين قيد الانتظار'),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: SingleChildScrollView(
        child: Background(
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Coach').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('loading 7 ...');

                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(), //<--here

                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, (snapshot.data!).docs[index]),
                );
              }),
        ),
      ),
    );
  }

  void nav(String icd) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return TestScreen1(icd);
      }),
    );
  }
}