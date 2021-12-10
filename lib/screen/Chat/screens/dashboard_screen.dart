import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../chatDB.dart';
import '../chatData.dart';
import '../chatWidget.dart';
import '../constants.dart';
import 'chat.dart';
import 'package:fluttertoast/fluttertoast.dart';

List<dynamic> friendList = ['rR3m3ViSYcO21IV4va4Xb41XFuz2'];

class DashboardScreen extends StatefulWidget {
  static const String id = "dashboard_screen";
  final String currentUserId;

  DashboardScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // ignore: unused_element
  _DashboardScreenState({Key? key});
  List<StreamSubscription> unreadSubscriptions = [];
  List<StreamController> controllers = [];

  bool isLoading = false;
  bool addNewFriend = false;
  List<Choice> choices = const <Choice>[
    const Choice(title: 'Settings', icon: Icons.settings),
    const Choice(title: 'Log out', icon: Icons.exit_to_app),
  ];

  final friendController = TextEditingController();

  late Stream<QuerySnapshot> _streamFriendList;

  @override
  void initState() {
    super.initState();
  }

  Future<List<dynamic>> getFriendList(bool onLoad) async {
    await FirebaseFirestore.instance
        .collection('trainees')
        .doc(widget.currentUserId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {

        //print('Document data: ${documentSnapshot.data()}');
        //setState(() {
        friendList = documentSnapshot.get('friends');
        return ['rR3m3ViSYcO21IV4va4Xb41XFuz2'];
        //});
      } else {
        return ['rR3m3ViSYcO21IV4va4Xb41XFuz2'];
      }
    });
    return ['rR3m3ViSYcO21IV4va4Xb41XFuz2'];
  }

  // void goExit() async {
  //   await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('Confirmation'),
  //           content: Text('Do you want to logout?'),
  //           actions: <Widget>[
  //             new TextButton(
  //               onPressed: () {
  //                 Navigator.of(context, rootNavigator: true).pop(
  //                     false); // dismisses only the dialog and returns false
  //               },
  //               child: Text('No'),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 ChatData.handleSignOut(context);
  //               },
  //               child: Text('Yes'),
  //             ),
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    print('hey bro');
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
          child: showFriendList(widget.currentUserId),
          onWillPop: onBackPress,
        ),
      ),
    );
  }

  Future<bool> onBackPress() {
    ChatData.openDialog(context);
    return Future.value(false);
  }

  Widget showAddFriend() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: TextButton(
        child: Text('Add New Friend'),
        onPressed: _showAddFriendDialog,
      ),
    );
  }

  _showAddFriendDialog() async {
    await showDialog<String>(
        context: context,
        builder: (context) {
          return _SystemPadding(
            child: new AlertDialog(
              contentPadding: const EdgeInsets.all(16.0),
              content: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new TextField(
                      autofocus: true,
                      controller: friendController,
                      decoration: new InputDecoration(
                          labelText: 'user Email',
                          hintText: 'smartmobilevilla@gmail.com'),
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                new TextButton(
                    child: const Text('CANCEL'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                new TextButton(
                    child: const Text('Add'),
                    onPressed: () {
                      Navigator.pop(context);
                      //if (friendController.text != '') _addNewFriend();
                    })
              ],
            ),
          );
        });
  }


  showToast(var text, bool error) {
    // if (error == false){
    //
    // }

    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: error ? Colors.red : Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Widget showFriendList(var currentUserId) {
    return Stack(
      children: <Widget>[
        // List
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              showAddFriend(),
            ],
          ),
        ),

        FutureBuilder<List<dynamic>>(
            future: getFriendList(true),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<dynamic>? newFrList = snapshot.data;
                if (newFrList!.length > 0) {
                  return widgetFriendList(currentUserId, newFrList);
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        'No Friend in your list\nAdd New Friend to start chat',
                        style: TextStyle(fontSize: 16.0),
                      )),
                    ],
                  );
                }
              } else {
                return Center(
                  child: Text('Loading FriendList'),
                );
              }
            }),
      ],
    );
  }

  Widget widgetFriendList(var currentUserId, List<dynamic> friendLists) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
      child: StreamBuilder<QuerySnapshot>(
        stream: streamFriendList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(themeColor),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return new ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
            return (document.get('ID') == currentUserId)
                ? SizedBox(
                    height: 2,
                  )
                : new ListTile(
                    leading: Material(
                      child: document.get('Lname') == null
                          ? ChatWidget.widgetShowImages(
                              document.get('photoUrl'), 50)
                          : Icon(
                              Icons.account_circle,
                              size: 50.0,
                              color: colorPrimaryDark,
                            ),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      clipBehavior: Clip.hardEdge,
                    ),
                    title: new Text(document.get('Fname')),
                    subtitle: new Text(document.get('Fname')),
                    trailing: Wrap(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                                width: 10,
                                child: new DecoratedBox(
                                  decoration: new BoxDecoration(
                                      color: document.get('online') == 'online'
                                          ? Colors.greenAccent
                                          : Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        StreamBuilder(
                            stream: getUnread(document.get('ID')),
                            builder: (context,
                                AsyncSnapshot<MessageData> unreadData) {
                              int unreadMsg =
                                  0; //unreadData.data.snapshot.docs.length -1;
                              if (unreadData.hasData &&
                                  unreadData.data!.snapshot.docs.isNotEmpty) {
                                for (int i = 0;
                                    i < unreadData.data!.snapshot.docs.length;
                                    i++) {
                                  try {
                                    if (int.parse(unreadData.data!.lastSeen
                                                .toString()) <
                                            int.parse(unreadData.data!.snapshot
                                                .docs[i]['timestamp']
                                                .toString()) &&
                                        unreadData
                                                .data!.snapshot.docs[i]['idFrom']
                                                .toString() !=
                                            currentUserId.toString())
                                      unreadMsg = unreadMsg + 1;
                                  } catch (ex) {
                                    print('exception' + ex.toString());
                                  }
                                }
                              }
                              return unreadMsg > 0
                                  ? Container(
                                      height: 40,
                                      width: 40,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(unreadMsg.toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        ],
                                      ),
                                      //: Container(width: 0, height: 0),

                                      decoration: BoxDecoration(
                                        border: Border.all(width: 2),
                                        shape: BoxShape.circle,
                                        color: Colors.amber,
                                      ),
                                    )
                                  : SizedBox(
                                      height: 10,
                                    );
                            }),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Chat(
                                    currentUserId: widget.currentUserId,
                                    peerId: document.get('ID'),
                                    peerName: document.get('Fname'),
                                    peerAvatar: document.get('photoUrl'),
                                    Cname: "mmm",
                                    Tname: 'mmmm',
                                    Tid: "jj",
                                    Cid: "",
                                    phone: '',
                                  )));
                    },
                  );
          }).toList());
        },
      ),
    );
  }

  Stream<MessageData>? getUnread(var peerId) {
    var id = widget.currentUserId;
    var groupChatId = ChatData.getGroupChatID(id, peerId);

    //ChatDBFireStore().setChatLastSeen(widget.currentUserId,'messages',groupChatId);
    //ChatDBFireStore().setChatLastSeen(peerId,'messages',groupChatId);

    try {
      print('unreadData ' + groupChatId);
      var controller = StreamController<MessageData>.broadcast();

      unreadSubscriptions.add(FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .snapshots()
          .listen((doc) {
        if (doc[id] != null) {
          unreadSubscriptions.add(FirebaseFirestore.instance
              .collection('messages')
              .doc(groupChatId)
              .collection(groupChatId)
              .snapshots()
              .listen((snapshot) {
            controller.add(MessageData(snapshot: snapshot, lastSeen: doc[id]));
          }));
        }
      }));
      controllers.add(controller);
      return controller.stream;
    } catch (e) {
      print('unreadExcept' + e.toString());
    }
    return null;
  }

  Stream<QuerySnapshot> streamFriendList() {
    return FirebaseFirestore.instance
        .collection('Coach')
        .where('ID', whereIn: friendList)
        .snapshots();

    // friendList = documentSnapshot.data()['friends'];
  }
}

class MessageData {
  int lastSeen;
  QuerySnapshot snapshot;
  MessageData({required this.snapshot, required this.lastSeen});
}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets / 2,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}

class Choice {
  const Choice({required this.title, required this.icon});

  final String title;
  final IconData icon;
}
