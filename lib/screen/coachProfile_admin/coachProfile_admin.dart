import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meras/screen/authenticate/background.dart';
import 'package:meras/screen/coachProfile_admin/Coach.dart';
import 'package:meras/screen/coachProfile_admin/user_preferences.dart';
import 'package:meras/screen/coachProfile_admin/widget/appbar_widget.dart';
import 'package:meras/screen/coachProfile_admin/widget/button_widget.dart';
import 'package:meras/screen/coachProfile_admin/widget/numbers_widget.dart';
import 'package:meras/screen/coachProfile_admin/widget/profile_widget.dart';

class CProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
 Color red = Color(0xFFFFCDD2);
 Color green = Color(0xFFC8E6C9);
class _ProfilePageState extends State<CProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
           const SizedBox(height: 14),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          const SizedBox(height: 24),
         // NumbersWidget(),
           Row(
           children: <Widget>[ 
             Padding(padding:EdgeInsets.symmetric(horizontal: 37, vertical: 5)),
             Center(child: Accept()),
             SizedBox(width: 24),
          Center(child: Reject()), ]),
          const SizedBox(height: 48),

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
           children: <Widget>[ 
             Padding(padding:EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
             const SizedBox(height: 16),
            Text(
              user.age,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),

            const SizedBox(height: 16),
            Text(
              user.gender,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),

             //Center(child: Text('العمر')),
             SizedBox(width: 24),
           ]),

          buildAbout(user),
          
        ],
      ),
    );
  }

  Widget buildName(Coach user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey,fontSize:15.7),
          ),
             Text(
            user.phone,
            style: TextStyle(color: Colors.grey,fontSize:15.7 ),
          )
        ],
      );

  Widget Reject() => ButtonWidget(
colorr:red,
        text: 'رفض',
        onClicked: () {},
      );
 Widget Accept() => ButtonWidget(
   colorr: green,
        text: 'قبول',
        onClicked: () {},
      );
  Widget buildAbout(Coach user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '            المنطقة السكنية', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),

            SizedBox(height: 15.0),


            Text(
              '                  الوصف',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),

            
          ],
        ),

        
      );
}