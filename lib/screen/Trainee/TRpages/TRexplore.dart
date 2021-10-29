import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/home/navDrawer.dart';

import 'DraftF.dart';

class TRexploreScreen extends StatefulWidget {
  @override
  _TRexploreScreenState createState() => _TRexploreScreenState();
}

class _TRexploreScreenState extends State<TRexploreScreen> {
  //final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return SingleChildScrollView(
      child: document['Status'] == 'A'
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
                    'الحي:' + ' ' + document['Neighborhood'],
                    style: TextStyle(height: 2, fontSize: 11),
                    textAlign: TextAlign.right,
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: document['Gender'] == 'أنثى'
                      ? Image.asset("assets/images/Female.png")
                      : Image.asset("assets/images/driver-male.jpg"),
                  leading: ElevatedButton(
                    child: Text('تقديم طلب تدريب'),
                    onPressed: () {
                      nav(document.id); //for next sprint
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text(
          'قائمة المدربين المتاحين',
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: BackgroundA(
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Coach').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('loading 7 ...');
                  return ListView.builder(
                    //physics: const NeverScrollableScrollPhysics(), //<--here
                    //controller: _scrollController,

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
        return CoachDate(icd);
        //return RequestLessonPage(icd);
      }),
    );
  }
}
