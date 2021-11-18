import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Trainee/TRpages/BackgroundLo22.dart';
import 'package:meras/screen/authenticate/background.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'BackgroundLo2.dart';

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

  String name = "";
  String help = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text(
          'البحث        ',
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: BackgroundLO22(
            child: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: TextField(
                        onChanged: (String) {
                          setState(() {
                            name = String;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          ////
                          prefixIcon: PopupMenuButton<String>(
                            icon: Icon(Icons.calendar_today),
                            onSelected: (String result) {
                              switch (result) {
                                case 'filter0':
                                  setState(() {
                                    help = '';
                                  });
                                  print('filter 0 clicked');

                                  break;
                                case 'filter1':
                                  setState(() {
                                    help = 'A';
                                  });
                                  print('filter 1 clicked');

                                  break;
                                case 'filter2':
                                  setState(() {
                                    help = 'B';
                                  });
                                  print('filter 2 clicked');
                                  break;
                                default:
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'filter0',
                                child: Text('الجميع'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'filter1',
                                child: Text('أنثى'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'filter2',
                                child: Text('ذكر'),
                              ),
                            ],
                          ),
                          ////
                          contentPadding: EdgeInsets.only(left: 25.0),
                          hintText: 'قم بالبحث بالأسم الاول للمدرب ...',
                          hintTextDirection: TextDirection.rtl,
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color: Colors.deepPurple.shade200,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),

                      /*     
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.deepPurple.shade200,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.deepPurple.shade200,
                              width: 2.0,
                            ),
                          ),
                          icon: Icon(
                            Icons.star,
                            color: Colors.grey,
                            size: 40,
                          ),

                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: 'قم بالبحث بالأسم الاول للمدرب ...',
                          hintTextDirection: TextDirection.rtl,
                          // suffixIcon: MaterialButton(
                          //    onPressed: () {},
                          //   child: Text('الجنس'),
                          // ),
                        ),
                        onChanged: (String) {
                          setState(() {
                            name = String;
                          });
                        },
                      ), */
                    ),
                    ///////////////////// start from here
                    Expanded(
                      child: Container(
                        child: SingleChildScrollView(
                          child: Background(
                            child: StreamBuilder<QuerySnapshot>(
                                stream: (name != "" && name != null)
                                    ? FirebaseFirestore.instance
                                        .collection('Coach')
                                        .where("Fname", isEqualTo: name)
                                        .orderBy("Rate", descending: true)
                                        .snapshots()
                                    : FirebaseFirestore.instance
                                        .collection("Coach")
                                        .orderBy("Rate", descending: true)
                                        .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) return Loading();
                                  return ListView.builder(
                                    //physics: const NeverScrollableScrollPhysics(), //<--here
                                    //controller: _scrollController,

                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) =>
                                        _buildListItem(context,
                                            (snapshot.data!).docs[index]),
                                  );
                                }),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    if (help == 'A') print("ITS A");

    if (help == 'B') print("ITS B");
    if (help == 'C') print("ITS C");

    print("Are you here sos");
////

    ///

    switch (help) {
      case 'A':
        return SingleChildScrollView(
          child: ((document['Status'] == 'A') &&
                  (document['CountDate'] > 0) &&
                  (document['Gender'] == 'أنثى'))
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
                        'تقييم المدرب:' +
                            ' ' +
                            document['Rate'].toStringAsFixed(2),

                        style: TextStyle(height: 2, fontSize: 12),
                        textAlign: TextAlign.right,
                        // style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: document['Gender'] == 'أنثى'
                          ? Image.asset("assets/images/Female.png")
                          : Image.asset("assets/images/driver-male.jpg"),
                      leading: ElevatedButton(
                        child: Text('معلومات المدرب   '),
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
      case 'B':
        return SingleChildScrollView(
          child: ((document['Status'] == 'A') &&
                  (document['CountDate'] > 0) &&
                  (document['Gender'] == 'ذكر'))
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
                        'تقييم المدرب:' +
                            ' ' +
                            document['Rate'].toStringAsFixed(2),

                        style: TextStyle(height: 2, fontSize: 12),
                        textAlign: TextAlign.right,
                        // style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: document['Gender'] == 'أنثى'
                          ? Image.asset("assets/images/Female.png")
                          : Image.asset("assets/images/driver-male.jpg"),
                      leading: ElevatedButton(
                        child: Text('معلومات المدرب   '),
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
      default:
        return SingleChildScrollView(
          child: ((document['Status'] == 'A') && (document['CountDate'] > 0))
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
                        'تقييم المدرب:' +
                            ' ' +
                            document['Rate'].toStringAsFixed(2),

                        style: TextStyle(height: 2, fontSize: 12),
                        textAlign: TextAlign.right,
                        // style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: document['Gender'] == 'أنثى'
                          ? Image.asset("assets/images/Female.png")
                          : Image.asset("assets/images/driver-male.jpg"),
                      leading: ElevatedButton(
                        child: Text('معلومات المدرب   '),
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
