import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meras1/Background.dart';
import 'package:meras1/Test.dart';

void main() async {
  runApp(MaterialApp(
    routes: {
      //  '/test': (context) => TestScreen(ic),
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

class CoachlistScreen extends StatefulWidget {
  @override
  _CoachlistScreenState createState() => _CoachlistScreenState();
}

class _CoachlistScreenState extends State<CoachlistScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return SingleChildScrollView(
      child: document['Status'] == 'A'
          ? Container(
              child: Card(
                child: ListTile(
                  title: Text(document['Fname'] + ' ' + document['Lname']),
                  subtitle: Text(document['Discerption']),
                  leading: document['Gender'] == 'female'
                      ? Image.asset("assets/Female.png")
                      : Image.asset("assets/driver-male.jpg"),
                  trailing: ElevatedButton(
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
      appBar: AppBar(
        title: Text(' قائمة مدربين القيادة '),
        backgroundColor: Color(0xFF6F35A5),
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
        return TestScreen(icd);
      }),
    );
  }
}
