import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../chatWidget.dart';
import '../constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Chat extends StatelessWidget {
  final String peerId;
  final String peerAvatar;
  final String peerName;
  final String currentUserId;
  final String Cname;
  final String Tname;
  final String Tid;
  final String Cid;
  final String phone;
   
  static const String id = "chat";

  Chat(
      {Key? key,
      required this.currentUserId,
      required this.peerId,
      required this.peerAvatar,
      required this.peerName,
      required this.Cname,
      required this.Tname,
      required this.Tid,
      required this.Cid,
       required this.phone,
      
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
         iconTheme: IconThemeData(
    color: Colors.white, //change your color here
  ),
        leading: null,
        actions: [
        Padding( padding:EdgeInsets.symmetric(horizontal: 17), 
        child: IconButton (icon: Icon (Icons.call), color: themeColor2, 
        onPressed: () 
        { 
          print(phone);
          launch("tel://$phone"); },//change the phone
        ),
         )
  ],
        title: Text(peerName, textAlign: TextAlign.center ,style: TextStyle(color: Colors.white, )),//fontWeight: FontWeight.bold)),
        //centerTitle: true,
        backgroundColor: Colors.deepPurple[100],//find the color
      ),
      body: new _ChatScreen(
        currentUserId: currentUserId,
        peerId: peerId,
        peerAvatar: peerAvatar,
        Cname: Cname,
        Tname: Tname,
        Tid: Tid,
        Cid: Cid,
      ),
    );
  }
}

class _ChatScreen extends StatefulWidget {
  final String peerId;
  final String peerAvatar;
  final String currentUserId;
  final String Cname;
  final String Tname;
  final String Tid;
  final String Cid;


  _ChatScreen(
      {Key? key,
      required this.peerId,
      required this.peerAvatar,
      required this.currentUserId,
       required this.Cname,
      required this.Tname,
       required this.Tid,
       required this.Cid,
      })
      : super(key: key);

  @override
  State createState() =>
      new _ChatScreenState(peerId: peerId, peerAvatar: peerAvatar, Cname: Cname, Tname:Tname, Tid:Tid, Cid:Cid);
}

class _ChatScreenState extends State<_ChatScreen> {
  _ChatScreenState({Key? key, required this.peerId, required this.peerAvatar, required this.Cname,
      required this.Tname, required this.Tid,
       required this.Cid,});

  String peerId;
  String peerAvatar;
  String Cname;
  String Tname;
  String Tid;
  String Cid;

  String id='';//trainee id

  var listMessage;
  late String groupChatId;

  late File imageFile;
 late bool isLoading;
 late bool isShowSticker;
 late String imageUrl;
  var stCollection = 'messages';

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);

    groupChatId = '';

    isLoading = false;
    isShowSticker = false;
    imageUrl = '';

    readLocal();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  readLocal() async {
    id = widget.currentUserId;//??
    if (id.hashCode <= peerId.hashCode) {
      groupChatId = '$id-$peerId';
    } else {
      groupChatId = '$peerId-$id';
    }

    // FirebaseFirestore.instance
    //     .collection('trainees')
    //     .doc(id)
    //     .update({'chattingWith': peerId});

    setState(() {});
  }

  Future getImage(int index) async {
    PickedFile selectedFile;

    if (kIsWeb) {
      //selectedFile=await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      selectedFile = (await ImagePicker().getImage(source: ImageSource.gallery))!;
    } else {
      if (index == 0)
        selectedFile =
            (await ImagePicker().getImage(source: ImageSource.gallery))!;
      else
        selectedFile = (await ImagePicker().getImage(source: ImageSource.camera))!;

      //imageFile =File(selectedFile.path);

    }

    if (selectedFile != null) {
      setState(() {
        //orFile=selectedFile;
        isLoading = true;
      });
      uploadFile(selectedFile);
    }
  }

  Future uploadFile(PickedFile orFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference reference =
        firebase_storage.FirebaseStorage.instance.ref().child(fileName);

    late File compressedFile;
    if (!kIsWeb)
      compressedFile = await FlutterNativeImage.compressImage(orFile.path,
          quality: 80, percentage: 90);

    try {
      firebase_storage.UploadTask uploadTask;

      final metadata = firebase_storage.SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': orFile.path});

      if (kIsWeb)
        uploadTask = reference.putData(await orFile.readAsBytes(), metadata);
      else
        uploadTask = reference.putFile(compressedFile);

      firebase_storage.TaskSnapshot storageTaskSnapshot = await uploadTask;

      storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
        imageUrl = downloadUrl;
        setState(() {
          isLoading = false;
          onSendMessage(imageUrl, 1);
        });
      }, onError: (err) {
        setState(() {
          isLoading = false;
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }




  void onSendMessage(String content, int type,) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();

      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'idFrom': id,
            'idTo': peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content.trim(),
            'type': type
          },
        );
      });
       Map<String, dynamic> Demo = {
      "lastMessage": content.trim(),
      "lastFrom": id,
      'Cname': Cname,
      "Cid":Cid,
      "Tid":Tid,
      'Tname': Tname,
      'lastTime': DateTime.now().millisecondsSinceEpoch.toString(),
      "ID": groupChatId,
      "peers": [id,peerId],
      'Time': DateTime.now(),
      'unread':true,

    };


      FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId).set(Demo);


      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: 'الرجاء كتابة رسالة');
    }
  }

  Future<bool> onBackPress() {
    Navigator.pop(context);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              ChatWidget.widgetChatBuildListMessage(
                  groupChatId,
                  listMessage,
                  widget.currentUserId,
                  peerAvatar,
                  listScrollController,
                  stCollection),

              // Input content
              buildInput(),
            ],
          ),

          // Loading
          buildLoading()
        ],
      ),
      onWillPop: onBackPress,
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple)),
              ),
              color: Colors.white.withOpacity(0.8),
            )
          : Container(),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
         Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
               child: new IconButton(
               icon:  Image.asset(
                            "assets/images/leftarrow.png",
                            width: 23,
                          ),
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
          Flexible(
            child: Container(
              child: TextField(
               // maxLength: 1000,
                
                 inputFormatters:[
      LengthLimitingTextInputFormatter(1000),
    ],
    
                maxLines: null,
                style: TextStyle(color: primaryColor, fontSize: 15.0,), textAlign: TextAlign.right,
                controller: textEditingController,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration.collapsed(
                  
                  hintText: '..اكتب رسالتك',
                  hintStyle: TextStyle(color: greyColor,),
                ),
                focusNode: focusNode,
              ),
            ),
          ),


          // Button send message
          
 Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.image),
                onPressed: () => getImage(0),
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
          Visibility(
            visible: !kIsWeb,
            child: Material(
              child: new Container(
                margin: new EdgeInsets.symmetric(horizontal: 1.0),
                child: new IconButton(
                  icon: new Icon(Icons.camera_alt),
                  onPressed: () => getImage(1),
                  color: primaryColor,
                ),
              ),
              color: Colors.white,
            ),
          ),
          // Edit text




        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: greyColor2, width: 0.5)),
          color: Colors.white),
    );
    
  }
}
