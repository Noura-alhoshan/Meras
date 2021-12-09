import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Trainee/TRpages/BackgroundLo22.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'package:meras/screen/Chat/screens/chat.dart';

class Tchat extends StatefulWidget {
  @override
  _TRexploreScreenState createState() => _TRexploreScreenState();
}

class _TRexploreScreenState extends State<Tchat> {
  //final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }
 

  Widget build(BuildContext context) {
   FirebaseAuth auth = FirebaseAuth.instance;
 final User? user = auth.currentUser;
    final Muid = user!.uid;
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'المحادثات',
         // textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: BackgroundLO22(
            child: StreamBuilder<QuerySnapshot>(
                stream:
                FirebaseFirestore.instance
                          .collection("messages")
                          .where('peers', arrayContains: Muid)
                          .snapshots(),
                    //FirebaseFirestore.instance.collection('Coach').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Loading();
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



 Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
   
   String fullname=document['Cname'];
   String shortM='';
   String pic="";
if(document['lastMessage'].toString().length > 20){
     String lla= document['lastMessage'];
   shortM =  "..."+ lla.substring(0,25) ;
}
if(document['lastMessage'].toString().contains("https://firebasestorage")){
   pic = "صورة" ;
}

   int spl= fullname.indexOf(' ');
   String Fname= fullname.substring(0, spl); 

   late String tname;
   FirebaseFirestore.instance
      .collection('trainees')
      .doc(document['Tid'])
      .get()
      .then((ds) {
    tname = ds['Fname'] + ' ' + ds['Lname'];
  }).catchError((e) {
    print(e);
  });
    return SingleChildScrollView(    
          child: Container(
              height: 104,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: Material(
              child: InkWell(
                  onTap: (){  
                    Navigator.of(context).push( MaterialPageRoute(
              builder: (context) => 
              Chat(currentUserId: document['Tid'], 
              peerAvatar:  "https://i.postimg.cc/59D0sP2g/Female.png",
              peerId:document['Cid'], 
              peerName: document['Cname'] ,
              Cname:document['Cname'] ,
              Tname: tname,
              Tid: document['Tid'],
              Cid: document['Cid']
              ),
              

              
              ),);
                  }
                  ,splashColor: Colors.purple[200],
                  child: Card(
                child: ListTile(
                  leading:  Text( DateFormat('dd MMM kk:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(document['lastTime'].toString())
                              )),
                              style: TextStyle(height: 5, fontSize: 11.7),),
                  title: Text(
                    document['Cname'],
                    style: TextStyle(height: 2, fontSize: 15.7),
                    textAlign: TextAlign.right,
                  ),
                  subtitle: (pic == "صورة") ? 
                  Text(
                     "صورة",////////////////////////////////////////////////from who???
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    style: TextStyle(height: 2, fontSize: 15,color: Colors.blue),
                    textAlign: TextAlign.right,
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  )
                 : document['lastMessage'].toString().length > 16? Text(
                      shortM,////////////////////////////////////////////////from who???
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    style: TextStyle(height: 2, fontSize: 15),
                    textAlign: TextAlign.right,
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ):  Text(
                     document['lastMessage'] ,////////////////////////////////////////////////from who???
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    style: TextStyle(height: 2, fontSize: 15),
                    textAlign: TextAlign.right,
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ) ,
                  trailing: 
                       Image.asset("assets/images/Female.png"),
                    
              ),
            )
          
    ))));
  }
  
}