import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/widget/FullScreen.dart';

class CardListWidget extends StatelessWidget {
  final String type;
  CardListWidget({required this.type});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Guidlines')
            .where('Type', isEqualTo: type)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Loading();

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) =>
                _buildListItem(context, (snapshot.data!).docs[index]),
          );
        });
  }

  _buildListItem(BuildContext context, dynamic doc) {
    Image im = new Image.network(
      doc['PicLink'],
      height: 100.0,
      width: 60.0,
    );
    return Container(
      height: 120,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        elevation: 6,
        shadowColor: Colors.deepPurple[500],
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.white, width: 1)),
        child: Container(
          height: 150,
          width: double.infinity,
          child: Row(
            children: [
              Flexible(
                flex: 8,
                child: SizedBox.expand(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        doc.data()['Title'],
                        style: TextStyle(
                            height: 1, fontSize: 17, color: Colors.black),
                        // maxLines: 1,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child:
                    //   Padding(
                    //     padding: const EdgeInsets.all(2.0),
                    //     child: Image.network(
                    //       doc.data()['PicLink'],
                    //       // fit: BoxFit.cover, width: 60, height: 60
                    //     ),
                    //   ),
                    // ),
                    ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Container(
                    child: ImageFullScreenWrapperWidget(
                      child: im,
                      dark: false,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
