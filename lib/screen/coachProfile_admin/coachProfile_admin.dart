import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meras/models/MyUser.dart';
import 'package:meras/screen/authenticate/background.dart';
import 'package:meras/screen/coachProfile_admin/Coach.dart';
import 'package:meras/screen/coachProfile_admin/user_preferences.dart';
import 'package:meras/screen/coachProfile_admin/widget/appbar_widget.dart';
import 'package:meras/screen/coachProfile_admin/widget/button_widget.dart';
import 'package:meras/screen/coachProfile_admin/widget/numbers_widget.dart';
import 'package:meras/screen/coachProfile_admin/widget/profile_widget.dart';
import 'package:meras/screen/home/home.dart';


class TestScreen extends StatefulWidget {
  final String id;
  TestScreen(this.id);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Center(child: Text('معلومات المدرب',textAlign: TextAlign.center,),),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Coach')
              .where(FieldPath.documentId, isEqualTo: widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('loading 7 ...');
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(), //<--here
              itemCount: 1,

              itemBuilder: (context, index) =>
                  _build(context, (snapshot.data!).docs[0]),
            );
          }),
    );
  }

  void nav1() async {
    Navigator.pushNamed(context, '/ADcategory'); //nn
  }


 Color red = Color(0xFFFFCDD2);
 Color green = Color(0xFFC8E6C9);


  Widget _build(BuildContext context, DocumentSnapshot document) {


    return Container(
        height: 1100,
        //child: SingleChildScrollView(
          child:  ListView(
          
        physics: BouncingScrollPhysics(),
        children: [
           const SizedBox(height: 14),
          ProfileWidget(
           imagePath: document['URL'],
           onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(document),
          const SizedBox(height: 24),
          //const SizedBox(height: 24),
         // NumbersWidget(),
           Row(
           children: <Widget>[ 
             Padding(padding:EdgeInsets.symmetric(horizontal: 37, vertical: 5)),
             Center(child: Accept()),
             SizedBox(width: 24),
          Center(child: Reject()), ]),
          const SizedBox(height: 38),

            Row(
           children: <Widget>[ 
             Padding(padding:EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
              Text('             العمر',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
                Text('                       الجنس',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
             //Center(child: Text('العمر')),
             SizedBox(width: 24),
           ]),

            Row(
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
              crossAxisAlignment: CrossAxisAlignment.center ,
           children: <Widget>[ 
             Padding(padding:EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
             const SizedBox(height: 16),
             Center(child: Text(
              document['Age']+'                       ',textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),),

           const SizedBox(width: 33),
             Text(
              document['Gender']+"                       ",textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),

             //Center(child: Text('العمر')),
             SizedBox(width: 48),
           ]),

          buildAbout(document),
          
        ],
      ),
    );
  }

  Widget buildName( DocumentSnapshot document) => Column(
    mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          Text(
           document['Fname']+' '+ document['Lname'] ,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
           document['Email'],
            style: TextStyle(color: Colors.grey,fontSize:15.7),
          ),
          SizedBox(height: 8),
             Text(
            document['Phone Number'],
            style: TextStyle(color: Colors.grey,fontSize:15.7 ),
          )
        ],
      );

  Widget Reject() => ButtonWidget(
  colorr:red,
        text: 'رفض',
        onClicked: () { },
      );
 Widget Accept() => ButtonWidget(
   colorr: green,
        text: 'قبول',
        onClicked: () { FirebaseFirestore.instance
                  .collection('Coach')
                  .doc(widget.id)
                  .update({'Status': 'A'});
                  nav1();},
      ); 


  Widget buildAbout(document) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 19),
             Center( child: Text(
              ' المنطقة السكنية', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),),
            const SizedBox(height: 1),
            Center( child: Text(
              document['Neighborhood'] ,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),),

            SizedBox(height: 19.0),


           Center( child: Text(
              'الوصف',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),),
            const SizedBox(height: 1),
            Center( child: Text(
              document['Discerption'],
              style: TextStyle(fontSize: 16, height: 1.4),
            ),),

            
          ],
        ),

        
      );
}