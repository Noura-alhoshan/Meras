import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/components/SingleBaseAlert.dart';
import 'package:meras/screen/Admin/ADpages/coachProfile_admin.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Admin/widget/button_widget.dart';
import 'package:meras/screen/Coach/BackgroundC.dart';
import 'package:meras/screen/home/BaseAlertDialog.dart';
import 'package:meras/screen/home/navDrawer.dart';

class CoachDate extends StatefulWidget {
  @override
  _CoachDate createState() => _CoachDate();
}

class _CoachDate extends State<CoachDate> {
  late DateTime date;
  late TimeOfDay time;
  late DateTime dateTime;
  late DateTime day;
  late bool S = false;
  late String date1;
  static  int count=0;
  //static const IconData clear_rounded =
  //    IconData(0xf645, fontFamily: 'MaterialIcons');

  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference AvaDates = FirebaseFirestore.instance.collection('Coach');
  final ScrollController _scrollController = ScrollController();

  ///first null?

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user!.uid;

    return Scaffold(
      //extendBody: true,
      extendBodyBehindAppBar: true,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('          إضافة موعد جديد'
            // textAlign: TextAlign.center,
            ),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: BackgroundA(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20)),

                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5)),
                  Date(),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5)),
                  // buildCard(),
                  Text(
                    'المواعيد المتاحة خلال الاسبوع القادم',
                    style: TextStyle(height: 2, fontSize: 18),
                    textAlign: TextAlign.right,
                  ),

                  Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        child: BackgroundC(
                          child: Scrollbar(
                            isAlwaysShown: true,
                            controller: _scrollController,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Coach')
                                    .doc(uid)
                                    .collection('Dates')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) return Loading();
                                  return ListView.builder(
                                    controller: _scrollController,

                                    //      physics:
                                    //          const NeverScrollableScrollPhysics(), //<--here

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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    //  ]),
    //  );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return SingleChildScrollView(
      child: Container(
        height: 160,
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),

        ///
        child: Card(
          //  elevation: 4.0,
          child: Column(
            children: [
              Container(
                decoration: new BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                    color: Colors.deepPurple[100]),
                child: ListTile(
                  title: Text(
                      //  istrue(document['DateTime'].toString()) + i need to do this one
                      'يوم ' + getArabicdays(document['DateTime'].toString()),
                      textAlign: TextAlign.right,
                      style: TextStyle(height: 1.5, fontSize: 15)),
                  //subtitle: Text(subheading),
                  leading: IconButton(
                    icon: Icon(Icons
                        .clear_rounded), // Image.asset("assets/icons/delete-icon1.jpg"),
                    iconSize: 30,
                    color: Colors.deepOrange[800],
                    onPressed: () async {
                      var baseDialog = BaseAlertDialog(
                          title: "",
                          content: "هل أنت متأكد من حذف الموعد؟",
                          yesOnPressed: () async {
                            deleteDate(document.id); ////

                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                            var baseDialog = SignleBaseAlertDialog(
                              title: "",
                              content: "تم حذف الدرس بنجاح",
                              yesOnPressed: () async {
                                Navigator.of(context, rootNavigator: true).pop(
                                    'dialog'); //////////////////////////////////??????
                                //   nav1();
                              },
                              yes: "إغلاق",
                            );
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => baseDialog);
                          },
                          noOnPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                          },
                          yes: "نعم",
                          no: "لا");
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => baseDialog);
                    },
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  document['DateTime'].toString().substring(17, 19) == 'AM'
                      ? 'التاريخ:' +
                          //   getArabicdays(document['DateTime'].toString()) +
                          ' ' +
                          document['DateTime'].toString().substring(0, 10) +
                          '\n'
                              '  الوقت: ' +
                          document['DateTime'].toString().substring(11, 16) +
                          ' صباحا '
                      : 'يوم ' +
                          getArabicdays(document['DateTime'].toString()) +
                          ' ' +
                          document['DateTime'].toString().substring(0, 10) +
                          '\n'
                              '  الوقت: ' +
                          document['DateTime'].toString().substring(11, 16) +
                          ' مساءً ',
                  style: TextStyle(height: 1.5, fontSize: 14),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          elevation: 6,
          shadowColor: Colors.deepPurple[500],

          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.transparent, width: 1)),
        ),

        ///
      ),
    );
  }

  Widget Date() => ButtonWidget(
        colorr: green,
        text: '+ إضافة ',
        onClicked: () {
          pickDateTime(context);
        },
      );

  Future<void> istrue(String a) async {
    if (date1 == a) {
      S = true;
    }
  }

  ////methods  METHOD1: deleteDate, METHOD2:addDate, METHOD3:pickDateTime ,METHOD4:pickTime, METHOD5:pickDate, METHOD6:getText, METHOD7:getday, METHOD8:getArabicdays
  /// method 1
  Future<void> deleteDate(String a) {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return AvaDates.doc(uid)
        .collection('Dates')
        .doc(a)
        .delete()
        .then((value) => print("time deleted"))
        .catchError((error) => print("Failed to delete time: $error"));
  }

  /// method 2
  Widget addDate() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    date1 = getText() + getday();
     AvaDates.doc(uid)
        .collection("Dates")
        .add({'DateTime': date1})
        .then((value) => print("time added"))
        .catchError((error) => print("Failed to add time: $error"));

        return Text('');
  }

  void nav1() async {
    Navigator.of(context).pop();
  }

  /// method 3
  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;
    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });

    var baseDialog = BaseAlertDialog(
        title: "",
        content: "هل أنت متأكد من إضافة الموعد؟",
        yesOnPressed: () async {
          date1= getText() + getday();
          print(getText() + getday());
        // addDate();
        // dayyy(context);
        isss();
          Navigator.of(context, rootNavigator: true).pop('dialog');

          var baseDialog = SignleBaseAlertDialog(
            title: "",
            content: "تم إضافة الموعد بنجاح",
            yesOnPressed: () async {
              Navigator.of(context, rootNavigator: true)
                  .pop('dialog'); //////////////////////////////////??????
              // nav1();
            },
            yes: "إغلاق",
          );
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  baseDialog); //////////////////////////////////??????
          // nav1();
        },
        noOnPressed: () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
        },
        yes: "نعم",
        no: "لا");
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  /// method 4
  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      // dateTime != null
      //      ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
      //     : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }

  /// method 5
  Future<DateTime?> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      //  initialDate: dateTime ?? initialDate,
      initialDate: initialDate,

      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(hours: 24 * 6)),
    );

    if (newDate == null) return null;

    return newDate;
  }

  /// method 6
  String getText() {
    return DateFormat('MM/dd/yyyy hh:mm aa').format(dateTime);
    // '${dateTime.day}/${dateTime.month}/${dateTime.year}  ' +
    //     ' ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// method 7
  String getday() {
    day = dateTime;
    return DateFormat('EEEE').format(day);
    // '${dateTime.day}/${dateTime.month}/${dateTime.year}  ' +
    //     ' ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// method 8
  String getArabicdays(String a) {
    switch (a.substring(19)) {
      case 'Saturday':
        return 'السبت';
      case 'Sunday':
        return 'الأحد';
      case 'Monday':
        return 'الأثنين';
      case 'Tuesday':
        return 'الثلاثاء';
      case 'Wednesday':
        return 'الأربعاء';
      case 'Thursday':
        return 'الخميس';
      case 'Friday':
        return 'الجمعة';
      default:
        return 'no day';
    }
  }

  Card buildCard() {
    var supportingText =
        'Beautiful home to rent, recently refurbished with modern appliances...';
    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            Container(
              decoration: new BoxDecoration(color: Colors.deepPurple[100]),
              child: ListTile(
                title: Text(
                  'السبت',
                  textAlign: TextAlign.right,
                ),
                //subtitle: Text(subheading),
                leading: Icon(Icons.favorite_outline),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: Text('التاريخ'),
            ),
          ],
        ));
  }
/*
  Future<bool> doesNameAlreadyExist(String name) async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    final Stream<QuerySnapshot> result = await FirebaseFirestore.instance
        .collection('Coach')
        .doc(uid)
        .collection('Dates')
        .where('DateTime', isEqualTo: name)
        .limit(1)
        .snapshots();

    // final List<DocumentSnapshot> documents = result.;
    if (result.isEmpty == true) {
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
    //documents.length == 1;
  }
  @override
  Widget buildd(BuildContext context) {
   final User? user = auth.currentUser;
    final uid = user!.uid;


  }*/ // what if i  call another page ?
 pmsg() {

var baseDialog=  SignleBaseAlertDialog(
            title: "",
            content: "لا يمكن إضافة الموعد ",
            yesOnPressed: () async {
              Navigator.of(context, rootNavigator: true)
                  .pop('dialog'); //////////////////////////////////??????
               nav1();
            },
            yes: "إغلاق",
          );
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  baseDialog); 
          
}


 isTrue() async {
    final User? user = auth.currentUser;
    final uid = user!.uid;

    //  return (date1 == a);
    
    FirebaseFirestore.instance
        .collection('Coach')
        .doc(uid)
        .collection('Dates')
        .get()
        .then((querySnapshot) async {
      //async
print(date1);
      querySnapshot.docs.forEach((value) {
        if (value.data()['DateTime'].toString() == date1) {
        
          count = count+1;
           print("hello sarah im here");
          print(count);
        }
        
      });
     
  count= 0;
    
    });
    // print(count);
    //  if (count != 0) 
    //   return false;
    //  else return true;
  }

isss() async {
 isTrue();
  { if (count>0)
    addDate();
    else pmsg();
    count= 0;}
}

}

  // Widget dayyy(
  //   BuildContext context,
  // ) {
  //   //final Puser = Provider.of<MyUser?>(context);
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user = auth.currentUser;
  //   dynamic userid = user!.uid;

  //   return FutureBuilder<List<bool>>(
  //       future: Future.wait([
  //         //isNull(context),
  //         isTrue() 
         
  //       ]),
  //       builder: (
  //         context,
  //         // List of booleans(results of all futures above)
  //         AsyncSnapshot<List<bool>> snapshot,
  //       ) {
  //         // Check hasData once for all futures.
  //         if (!snapshot.hasData) {
  //           return Loading();
  //         }
  //         // Access first Future's data:
  //         // snapshot.data[0]
  //         if (snapshot.data![0])
  //           return addDate(); 
  //         else {
  //           print('im actually in else');
  //           return pmsg();
  //           }
  //         // else if (snapshot.data![1])
  //         //   return ADcategory();
  //         // else if (snapshot.data![2])
  //         //   return Chome();
  //         // else if (snapshot.data![3])
  //         //   return notApproaved();
  //         // else
  //         //   return Rhome();
        

  //       });
  // }


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:meras/Controllers/Loading.dart';
// import 'package:meras/components/SingleBaseAlert.dart';
// import 'package:meras/screen/Admin/ADpages/coachProfile_admin.dart';
// import 'package:meras/screen/Admin/widget/BackgroundA.dart';
// import 'package:meras/screen/Admin/widget/button_widget.dart';
// import 'package:meras/screen/Coach/BackgroundC.dart';
// import 'package:meras/screen/home/BaseAlertDialog.dart';
// import 'package:meras/screen/home/navDrawer.dart';

// class CoachDate extends StatefulWidget {
//   @override
//   _CoachDate createState() => _CoachDate();
// }

// class _CoachDate extends State<CoachDate> {
//   late DateTime date;
//   late TimeOfDay time;
//   late DateTime dateTime;
//   late DateTime day;
//   late bool S = false;
//   late String date1;

//   //static const IconData clear_rounded =
//   //    IconData(0xf645, fontFamily: 'MaterialIcons');

//   final FirebaseAuth auth = FirebaseAuth.instance;
//   CollectionReference AvaDates = FirebaseFirestore.instance.collection('Coach');
//   final ScrollController _scrollController = ScrollController();

//   ///first null?

//   @override
//   Widget build(BuildContext context) {
//     final User? user = auth.currentUser;
//     final uid = user!.uid;

//     return Scaffold(
//       //extendBody: true,
//       extendBodyBehindAppBar: true,
//       drawer: NavDrawer(),
//       appBar: AppBar(
//         title: Text('          إضافة موعد جديد'
//             // textAlign: TextAlign.center,
//             ),
//         backgroundColor: Colors.deepPurple[100],
//       ),
//       body: Container(
//         child: SingleChildScrollView(
//           child: BackgroundA(
//             child: SafeArea(
//               child: Column(
//                 children: <Widget>[
//                   Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 30, vertical: 20)),

//                   Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 30, vertical: 5)),
//                   Date(),
//                   Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 30, vertical: 5)),
//                   // buildCard(),
//                   Text(
//                     'المواعيد المتاحة خلال الاسبوع القادم',
//                     style: TextStyle(height: 2, fontSize: 18),
//                     textAlign: TextAlign.right,
//                   ),

//                   Expanded(
//                     child: Container(
//                       child: SingleChildScrollView(
//                         child: BackgroundC(
//                           child: Scrollbar(
//                             isAlwaysShown: true,
//                             controller: _scrollController,
//                             child: StreamBuilder<QuerySnapshot>(
//                                 stream: FirebaseFirestore.instance
//                                     .collection('Coach')
//                                     .doc(uid)
//                                     .collection('Dates')
//                                     .snapshots(),
//                                 builder: (context, snapshot) {
//                                   if (!snapshot.hasData) return Loading();
//                                   return ListView.builder(
//                                     controller: _scrollController,

//                                     //      physics:
//                                     //          const NeverScrollableScrollPhysics(), //<--here

//                                     itemCount: snapshot.data!.docs.length,
//                                     itemBuilder: (context, index) =>
//                                         _buildListItem(context,
//                                             (snapshot.data!).docs[index]),
//                                   );
//                                 }),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//     //  ]),
//     //  );
//   }

//   Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
//     return SingleChildScrollView(
//       child: Container(
//         height: 160,
//         padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),

//         ///
//         child: Card(
//           //  elevation: 4.0,
//           child: Column(
//             children: [
//               Container(
//                 decoration: new BoxDecoration(
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(20.0)),
//                     color: Colors.deepPurple[100]),
//                 child: ListTile(
//                   title: Text(
//                       //  istrue(document['DateTime'].toString()) + i need to do this one
//                       'يوم ' + getArabicdays(document['DateTime'].toString()),
//                       textAlign: TextAlign.right,
//                       style: TextStyle(height: 1.5, fontSize: 15)),
//                   //subtitle: Text(subheading),
//                   leading: IconButton(
//                     icon: Icon(Icons
//                         .clear_rounded), // Image.asset("assets/icons/delete-icon1.jpg"),
//                     iconSize: 30,
//                     color: Colors.deepOrange[800],
//                     onPressed: () async {
//                       var baseDialog = BaseAlertDialog(
//                           title: "",
//                           content: "هل أنت متأكد من حذف الموعد؟",
//                           yesOnPressed: () async {
//                             deleteDate(document.id); ////

//                             Navigator.of(context, rootNavigator: true)
//                                 .pop('dialog');
//                             var baseDialog = SignleBaseAlertDialog(
//                               title: "",
//                               content: "تم حذف الدرس بنجاح",
//                               yesOnPressed: () async {
//                                 Navigator.of(context, rootNavigator: true).pop(
//                                     'dialog'); //////////////////////////////////??????
//                                 //   nav1();
//                               },
//                               yes: "إغلاق",
//                             );
//                             showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) => baseDialog);
//                           },
//                           noOnPressed: () {
//                             Navigator.of(context, rootNavigator: true)
//                                 .pop('dialog');
//                           },
//                           yes: "نعم",
//                           no: "لا");
//                       showDialog(
//                           context: context,
//                           builder: (BuildContext context) => baseDialog);
//                     },
//                   ),
//                 ),
//               ),
//               Container(
//                 alignment: Alignment.centerRight,
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   document['DateTime'].toString().substring(17, 19) == 'AM'
//                       ? 'التاريخ:' +
//                           //   getArabicdays(document['DateTime'].toString()) +
//                           ' ' +
//                           document['DateTime'].toString().substring(0, 10) +
//                           '\n'
//                               '  الوقت: ' +
//                           document['DateTime'].toString().substring(11, 16) +
//                           ' صباحا '
//                       : 'يوم ' +
//                           getArabicdays(document['DateTime'].toString()) +
//                           ' ' +
//                           document['DateTime'].toString().substring(0, 10) +
//                           '\n'
//                               '  الوقت: ' +
//                           document['DateTime'].toString().substring(11, 16) +
//                           ' مساءً ',
//                   style: TextStyle(height: 1.5, fontSize: 14),
//                   textAlign: TextAlign.right,
//                 ),
//               ),
//             ],
//           ),
//           elevation: 6,
//           shadowColor: Colors.deepPurple[500],

//           shape: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(18),
//               borderSide: BorderSide(color: Colors.transparent, width: 1)),
//         ),

//         ///
//       ),
//     );
//   }

//   Widget Date() => ButtonWidget(
//         colorr: green,
//         text: '+ إضافة ',
//         onClicked: () {
//           pickDateTime(context);
//         },
//       );

//   Future<void> istrue(String a) async {
//     if (date1 == a) {
//       S = true;
//     }
//   }

//   ////methods  METHOD1: deleteDate, METHOD2:addDate, METHOD3:pickDateTime ,METHOD4:pickTime, METHOD5:pickDate, METHOD6:getText, METHOD7:getday, METHOD8:getArabicdays
//   /// method 1
//   Future<void> deleteDate(String a) {
//     final User? user = auth.currentUser;
//     final uid = user!.uid;
//     return AvaDates.doc(uid)
//         .collection('Dates')
//         .doc(a)
//         .delete()
//         .then((value) => print("time deleted"))
//         .catchError((error) => print("Failed to delete time: $error"));
//   }

//   /// method 2
//   Future<void> addDate() {
//     final User? user = auth.currentUser;
//     final uid = user!.uid;
//     date1 = getText() + getday();
//     return AvaDates.doc(uid)
//         .collection("Dates")
//         .add({'DateTime': date1})
//         .then((value) => print("time added"))
//         .catchError((error) => print("Failed to add time: $error"));
//   }

//   void nav1() async {
//     Navigator.of(context).pop();
//   }

//   /// method 3
//   Future pickDateTime(BuildContext context) async {
//     final date = await pickDate(context);
//     if (date == null) return;

//     final time = await pickTime(context);
//     if (time == null) return;
//     setState(() {
//       dateTime = DateTime(
//         date.year,
//         date.month,
//         date.day,
//         time.hour,
//         time.minute,
//       );
//     });

//     var baseDialog = BaseAlertDialog(
//         title: "",
//         content: "هل أنت متأكد من إضافة الموعد؟",
//         yesOnPressed: () async {
//           print(getText() + getday());
//           addDate();
//           Navigator.of(context, rootNavigator: true).pop('dialog');

//           var baseDialog = SignleBaseAlertDialog(
//             title: "",
//             content: "تم إضافة الموعد بنجاح",
//             yesOnPressed: () async {
//               Navigator.of(context, rootNavigator: true)
//                   .pop('dialog'); //////////////////////////////////??????
//               // nav1();
//             },
//             yes: "إغلاق",
//           );
//           showDialog(
//               context: context,
//               builder: (BuildContext context) =>
//                   baseDialog); //////////////////////////////////??????
//           // nav1();
//         },
//         noOnPressed: () {
//           Navigator.of(context, rootNavigator: true).pop('dialog');
//         },
//         yes: "نعم",
//         no: "لا");
//     showDialog(context: context, builder: (BuildContext context) => baseDialog);
//   }

//   /// method 4
//   Future<TimeOfDay?> pickTime(BuildContext context) async {
//     final initialTime = TimeOfDay(hour: 9, minute: 0);
//     final newTime = await showTimePicker(
//       context: context,
//       initialTime: initialTime,
//       // dateTime != null
//       //      ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
//       //     : initialTime,
//     );

//     if (newTime == null) return null;

//     return newTime;
//   }

//   /// method 5
//   Future<DateTime?> pickDate(BuildContext context) async {
//     final initialDate = DateTime.now();
//     final newDate = await showDatePicker(
//       context: context,
//       //  initialDate: dateTime ?? initialDate,
//       initialDate: initialDate,

//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(Duration(hours: 24 * 6)),
//     );

//     if (newDate == null) return null;

//     return newDate;
//   }

//   /// method 6
//   String getText() {
//     return DateFormat('MM/dd/yyyy hh:mm aa').format(dateTime);
//     // '${dateTime.day}/${dateTime.month}/${dateTime.year}  ' +
//     //     ' ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
//   }

//   /// method 7
//   String getday() {
//     day = dateTime;
//     return DateFormat('EEEE').format(day);
//     // '${dateTime.day}/${dateTime.month}/${dateTime.year}  ' +
//     //     ' ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
//   }

//   /// method 8
//   String getArabicdays(String a) {
//     switch (a.substring(19)) {
//       case 'Saturday':
//         return 'السبت';
//       case 'Sunday':
//         return 'الأحد';
//       case 'Monday':
//         return 'الأثنين';
//       case 'Tuesday':
//         return 'الثلاثاء';
//       case 'Wednesday':
//         return 'الأربعاء';
//       case 'Thursday':
//         return 'الخميس';
//       case 'Friday':
//         return 'الجمعة';
//       default:
//         return 'no day';
//     }
//   }

//   Card buildCard() {
//     var supportingText =
//         'Beautiful home to rent, recently refurbished with modern appliances...';
//     return Card(
//         elevation: 4.0,
//         child: Column(
//           children: [
//             Container(
//               decoration: new BoxDecoration(color: Colors.deepPurple[100]),
//               child: ListTile(
//                 title: Text(
//                   'السبت',
//                   textAlign: TextAlign.right,
//                 ),
//                 //subtitle: Text(subheading),
//                 leading: Icon(Icons.favorite_outline),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.all(16.0),
//               alignment: Alignment.centerLeft,
//               child: Text('التاريخ'),
//             ),
//           ],
//         ));
//   }
// /*
//   Future<bool> doesNameAlreadyExist(String name) async {
//     final User? user = auth.currentUser;
//     final uid = user!.uid;
//     final Stream<QuerySnapshot> result = await FirebaseFirestore.instance
//         .collection('Coach')
//         .doc(uid)
//         .collection('Dates')
//         .where('DateTime', isEqualTo: name)
//         .limit(1)
//         .snapshots();

//     // final List<DocumentSnapshot> documents = result.;
//     if (result.isEmpty == true) {
//       return Future<bool>.value(true);
//     } else {
//       return Future<bool>.value(false);
//     }
//     //documents.length == 1;
//   }
//   @override
//   Widget buildd(BuildContext context) {
//    final User? user = auth.currentUser;
//     final uid = user!.uid;


//   }*/ // what if i  call another page ?
// }