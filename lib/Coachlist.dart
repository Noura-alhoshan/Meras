import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meras1/Test.dart';

void main() async {
  runApp(MaterialApp(
    routes: {
      '/test': (context) => TestScreen(),
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
    // Size size = MediaQuery.of(context).size;

    return Container(
      //  width: double.infinity,
      //height: size.height, // every card in diffrent page

      child: Stack(
        children: <Widget>[
          /*Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/main_top.png",
              width: size.width * 0.55,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/login_bottom.png",
              width: size.width * 0.65,
            ),
          ), */
          document['Status'] == 'A'
              ? Card(
                  child: ListTile(
                    title: Text(document['Fname'] + ' ' + document['Lname']),
                    subtitle: Text(document['Discerption']),
//
                    leading: document['Gender'] == 'female'
                        ? Image.asset("assets/driver-female.jpg")
                        : Image.asset("assets/driver-male.jpg"),

                    trailing: ElevatedButton(
                      child: Text('معلومات المدرب'),
                      onPressed: () {
                        nav(document.id);
                      },
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: Colors.deepPurple[400],
                          textStyle: TextStyle(fontSize: 16)),
                    ),
                  ),
                )
              : Card(),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة المدربين'),
        backgroundColor: Colors.deepPurple[400],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Coach').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('loading 7 ...');
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, (snapshot.data!).docs[index]),
            );
          }),
    );
  }

  void nav(String id) async {
    Navigator.pushNamed(context, '/Test'); //nn
  }
}
