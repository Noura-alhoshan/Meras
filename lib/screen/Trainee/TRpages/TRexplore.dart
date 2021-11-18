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
  TextEditingController _searchController = TextEditingController();

  late Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getUsersPastTripsStreamSnapshots();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    print(_searchController.text);
    var showResults = [];

    if (_searchController.text != "") {
      for (var tripSnapshot in _allResults) {
        var title = hope(tripSnapshot).toLowerCase();

        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(tripSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getUsersPastTripsStreamSnapshots() async {
    var data = await FirebaseFirestore.instance
        .collection("Coach")
        .orderBy("Rate", descending: true)
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultsList();
    return "complete";
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
          child: Background(
            child: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          ////
                          prefixIcon: PopupMenuButton<String>(
                            icon: Icon(Icons.filter_alt),
                            onSelected: (String result) {
                              switch (result) {
                                case 'filter0':
                                  setState(() {
                                    help = 'A';
                                  });
                                  print('filter 0 clicked');

                                  break;
                                case 'filter1':
                                  setState(() {
                                    help = 'B';
                                  });
                                  print('filter 1 clicked');

                                  break;
                                case 'filter2':
                                  setState(() {
                                    help = '';
                                  });

                                  print('filter 2 clicked');
                                  break;
                                default:
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'filter0',
                                child: Row(
                                  children: <Widget>[
                                    Text('           أنثى        '),
                                    Icon(
                                      Icons.female_rounded,
                                      color: Colors.pink,
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'filter1',
                                child: Row(
                                  children: <Widget>[
                                    Text('           ذكر        '),
                                    Icon(
                                      Icons.male_rounded,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'filter2',
                                child: Row(
                                  children: <Widget>[
                                    Text(' محو التحديد   '),
                                    Icon(Icons.clear_rounded),
                                  ],
                                ),
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
                              child: ListView.builder(
                            itemCount: _resultsList.length,
                            itemBuilder: (BuildContext context, int index) =>
                                buildTripCard(context, _resultsList[index]),
                          )),
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

  Widget buildTripCard(BuildContext context, DocumentSnapshot document) {
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

  String hope(DocumentSnapshot snapshot) {
    name = snapshot['Fname'] + ' ' + snapshot['Lname'];
    return name;
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
