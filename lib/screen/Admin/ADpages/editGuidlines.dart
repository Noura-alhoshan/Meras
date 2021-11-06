import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Admin/widget/FullScreen.dart';

class EditGuidlines extends StatefulWidget {
  // const EditGuidlines({ Key? key }) : super(key: key);

  @override
  _EditGuidlinesState createState() => _EditGuidlinesState();
}

class _EditGuidlinesState extends State<EditGuidlines> {
  void initState() {
    super.initState();
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    Image im = new Image.network(
      document['PicLink'],
      height: 100.0,
      width: 50.0,
    );
    return SingleChildScrollView(
        child: Container(
      height: 110,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        child: ListTile(
          title: Text(
            document['Title'],
            style: TextStyle(height: 2, fontSize: 17),
            textAlign: TextAlign.right,
          ),
          subtitle: Text(
            'النوع :' + ' ' + getType(document['Type']),
            style: TextStyle(height: 2, fontSize: 14),
            textAlign: TextAlign.right,
          ),
          trailing: ClipRRect(
            borderRadius: BorderRadius.circular(89),
            child: Container(
              child: ImageFullScreenWrapperWidget(
                child: im,
                dark: false,
              ),
            ),
          ),
          leading: ElevatedButton(
            child: Text('تعديل'),
            onPressed: () {
              // nav(document.id);
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
        //: null,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'إشارات السير',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('Guidlines').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Loading();

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, (snapshot.data!).docs[index]),
            );
          }),
    );
  }

  String getType(String a) {
    switch (a) {
      case 'G':
        return 'الإشارات العامة';
      case 'N':
        return 'الإشارات التنظيمية - الممنوعات';
      case 'Y':
        return 'الإشارات التنظيمية - الإجبارية';
      case 'W':
        return 'الإشارات التحذيرية';
      default:
        return 'no type';
    }
  }
}
