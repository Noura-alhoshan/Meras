import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/screen/Admin/ADpages/coachProfile_admin.dart';
import 'package:meras/screen/Admin/widget/button_widget.dart';
import 'package:meras/screen/authenticate/background2.dart';
import 'package:meras/screen/home/navDrawer.dart';

class CoachDate extends StatefulWidget {
  @override
  _CoachDate createState() => _CoachDate();
}

class _CoachDate extends State<CoachDate> {
  late DateTime date;
  late TimeOfDay time;
  late DateTime dateTime;

  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference AvaDates =
      FirebaseFirestore.instance.collection('TrainingDates');

  ///first null?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('اختيار الاوقات المتاحة'),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Container(
        child: Center(
          child: Date(),
        ),
        /* child: Column(children: <Widget>[
          Row(children: <Widget>[
            //Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5)),
            Center(
              child: Date(),
            ),
            // SizedBox(width: 24),
            Center(
              child: ButtonWidget(
                colorr: red,
                text: 'DATE',
                onClicked: () {
                  pickDate(context);
                },
              ),
            ),
          ]),
        ]),
      ),*/
      ),
    );
  }

  String getText() {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}  ' +
        ' ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Widget Date() => ButtonWidget(
        colorr: red,
        text: 'DATE',
        onClicked: () {
          pickDateTime(context);
        },
      );

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
  // print(getText());

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
  //print(getText());

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
    print(getText());
    addDate();
  }

  Future<void> addDate() {
    final User? user = auth.currentUser;
    final uid = user!.uid;

    // Call the user's CollectionReference to add a new user
    return AvaDates.add({
      'CID': uid, // John Doe
      'DateTime': getText(), // Stokes and Sons
    })
        .then((value) => print("time Added"))
        .catchError((error) => print("Failed to add time: $error"));
  }
}
