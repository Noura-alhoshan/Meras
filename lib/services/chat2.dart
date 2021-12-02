import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cocode/Auth.dart';
import 'package:meras/services/auth.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class Chat2 extends StatefulWidget {
  var projectId;
  var channleId;
  Chat2({Key? key, @required this.projectId, @required this.channleId})
      : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat2> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  String userName = "soso";//Auth.getCurrentUsername();
  String userID = "b6J60NW8fEU2bVWoFETnRX0HyYE3";//Auth.getCurrentUserID();
  ValueNotifier<String> Pname = new ValueNotifier<String>("");

  Future<void> callback() async {
    if (messageController.text.length > 0) {
      await firestore
          .collection('trainees')
          .doc("b6J60NW8fEU2bVWoFETnRX0HyYE3")//widget.projectId)
          .collection('messages')
          .doc(widget.channleId)
          .collection('chat')
          .add({
        'text': messageController.text,
        'from': userName,
        'date': DateTime.now().toIso8601String().toString(),
        'userID': userID,
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    firestore
        .collection('projects')
        .doc(widget.projectId)
        .collection('messages')
        .doc(widget.channleId)
        .get()
        .then((snapshot) {
      Pname.value = snapshot['name'];
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.deepOrangeAccent,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: ValueListenableBuilder(
          builder: (BuildContext context, value, Widget? child) {
            return Text(
              Pname.value,
              style: TextStyle(color: Colors.indigo),
            );
          },
          valueListenable: Pname,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('projects')
                    .doc(widget.projectId)
                    .collection('messages')
                    .doc(widget.channleId)
                    .collection('chat')
                    .orderBy('date')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  List<DocumentSnapshot> docs = snapshot.data!.docs;

                  List<Widget> messages = docs
                      .map(
                        (doc) => Message(
                          from: doc['from'],
                          text: doc['text'],
                          currentUser: userID == doc['userID'],
                          date: doc['date'],
                        ),
                      )
                      .toList();

                  return ListView(
                    controller: scrollController,
                    children: <Widget>[
                      ...messages,
                    ],
                  );
                },
              ),
            ),
            // send massage container

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: 0.1 * MediaQuery.of(context).size.height,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 0.05 * MediaQuery.of(context).size.width,
                  ),
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) => callback(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10),
                        hintText: "Enter a Message...",
                        border: const OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                      ),
                      controller: messageController,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SendButton(
                    callback: callback,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// here button color setting
class SendButton extends StatelessWidget {
  final VoidCallback callback;

  const SendButton({Key? key, required this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(13.0),
      textColor: Colors.indigo,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0)),
      splashColor: Colors.blueAccent,
      color: Colors.deepOrangeAccent,
      onPressed: callback,
      child: Icon(Icons.send),
    );
  }
}

// massages duration
class Message extends StatelessWidget {
  final String from; // user how sent the massage
  final String text; // body of the massage
  final bool currentUser;
  final String date;
  const Message({Key? key, required this.from, required this.text, required this.currentUser, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var Date = DateTime.parse(date);
    final DateFormat formatter = DateFormat('yMMMd');

    return Container(
      child: Column(
        crossAxisAlignment:
            currentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 0.02 * MediaQuery.of(context).size.height,
          ),
          Container(
            padding: currentUser
                ? EdgeInsets.only(
                    right: 0.05 * MediaQuery.of(context).size.width,
                  )
                : EdgeInsets.only(
                    left: 0.05 * MediaQuery.of(context).size.width,
                  ),
            child: Text(
              from,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
            child: Material(
              color: currentUser ? Colors.teal[100] : Colors.blue[100],
              borderRadius: currentUser
                  ? BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
              elevation: 6.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Column(
                  children: [
                    Text(text,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                    Text(
                      DateFormat.jm().format(
                          DateFormat("hh:mm:ss").parse(date.substring(11, 19))),
                      style: TextStyle(color: Colors.blueGrey, fontSize: 10),
                    ),
                    Text(formatter.format(Date),
                        style: TextStyle(color: Colors.blueGrey, fontSize: 10)),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
