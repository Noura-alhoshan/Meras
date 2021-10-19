import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meras/screen/Admin/ADpages/coachProfile_admin.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Admin/widget/button_widget.dart';
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

  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference AvaDates = FirebaseFirestore.instance.collection('Coach');

  ///first null?

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user!.uid;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('اختيار الاوقات المتاحة'),
        backgroundColor: Colors.deepPurple[100],
      ),
      /*
      body: Container(
        child: Center(
          child: Date(),
        ),
      ), */

      //   /*
      body: Column(children: <Widget>[
        Expanded(
          child: Center(
            child: Container(
              child: SingleChildScrollView(
                // child: BackgroundA(
                child: Date(),
              ),
            ),
          ),
        ),
        // Container(height: 40, color: Colors.grey),
        Expanded(
          child: Container(
            child: SingleChildScrollView(
              child: BackgroundA(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Coach')
                        .doc(uid)
                        .collection('test')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return const Text('loading 7 ...');
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(), //<--here

                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) => _buildListItem(
                            context, (snapshot.data!).docs[index]),
                      );
                    }),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return SingleChildScrollView(
        child: Container(
      height: 100,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Card(
        child: ListTile(
          title: Text(
            document['DateTime'].toString().substring(16, 18) == 'AM'
                ? 'يوم ' +
                    getArabicdays(document['DateTime'].toString()) +
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
            style: TextStyle(height: 1.5, fontSize: 19),
            textAlign: TextAlign.right,
          ),
          leading: IconButton(
            icon: Image.asset("assets/icons/DeleteIcon.png"),
            iconSize: 50,
            onPressed: () async {
              var baseDialog = BaseAlertDialog(
                  title: "",
                  content: "هل أنت متأكد من حذف الموعد؟",
                  yesOnPressed: () async {
                    deleteDate(document.id); ////

                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                  noOnPressed: () {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                  yes: "نعم",
                  no: "لا");
              showDialog(
                  context: context,
                  builder: (BuildContext context) => baseDialog);
            },
          ),
        ),
        elevation: 6,
        shadowColor: Colors.deepPurple[500],
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.white, width: 1)),
      ),
    ));
  }

  Widget Date() => ButtonWidget(
        colorr: red,
        text: 'DATE',
        onClicked: () {
          pickDateTime(context);
        },
      );

  ////methods  METHOD1: deleteDate, METHOD2:addDate, METHOD3:pickDateTime ,METHOD4:pickTime, METHOD5:pickDate, METHOD6:getText, METHOD7:getday, METHOD8:getArabicdays
  /// method 1
  Future<void> deleteDate(String a) {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return AvaDates.doc(uid)
        .collection('test')
        .doc(a)
        .delete()
        .then((value) => print("time deleted"))
        .catchError((error) => print("Failed to delete time: $error"));
  }

  /// method 2
  Future<void> addDate() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return AvaDates.doc(uid)
        .collection("test")
        .add({'DateTime': getText() + getday()})
        .then((value) => print("time added"))
        .catchError((error) => print("Failed to add time: $error"));
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
    print(getText() + getday());
    addDate();
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
    return DateFormat('MM/dd/yyyy h:mm aa').format(dateTime);
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
    switch (a.substring(18)) {
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
}
