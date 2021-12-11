import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart' as ui;
import 'package:meras/Controllers/Loading.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'chatDB.dart';
import 'chatData.dart';
import 'constants.dart';
import 'screens/chat.dart';
import 'screens/zoomImage.dart';

class ChatWidget {
  // static getFriendList() {///////////////////////////////////////////////////////////////
  //   List<String> data = [
  //     "h7127ZCne0OzSRwNXtktMPei0CH3",
  //     "pdj9dlfEQMTUD6s954qiPeplEog2"
  //   ];
  //   return data;
  // }

//static Future<Widget> userListStack(String currentUserId, BuildContext context)  async{
//
//    //List<String> friendList=await getFriendList();
//    List<String> friendList=await getFriendList();
//
//    return
//  }

  static Widget userListbuildItem(
      BuildContext context, String currentUserId, DocumentSnapshot document) {
    //print('adgbasdg_userbuildItem');

    //print(currentUserId);
    if (document.get('ID') == currentUserId) {
      return Container();
    } else {
      return Container(
        child: ElevatedButton(
            child: Row(
              children: <Widget>[
                Material(
                  child: document.get('photoUrl') != null
                      ? widgetShowImages(document.get('photoUrl'), 50)
                      : Icon(
                          Icons.account_circle,
                          size: 50.0,
                          color: Colors.purple,
                        ),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  clipBehavior: Clip.hardEdge,
                ),
                Flexible(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Fname: ${document.get('Fname')}',
                            style: TextStyle(color: primaryColor),
                          ),
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(left: 20.0),
                  ),
                ),
                ConstrainedBox(
                  constraints: new BoxConstraints(
                    minHeight: 10.0,
                    minWidth: 10.0,
                    maxHeight: 30.0,
                    maxWidth: 30.0,
                  ),
                  child: new DecoratedBox(
                    decoration: new BoxDecoration(
                        color: document.get('online') == 'online'
                            ? Colors.greenAccent
                            : Colors.transparent),
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Chat(
                            currentUserId: currentUserId,
                            peerId: document.id,
                            peerName: document.get('Fname'),
                            peerAvatar: "assets/images/TF.png",
                            Cname: "nnn",
                            Tname: "nnnnn",
                            Tid: '',
                            Cid: "kk",
                            phone: '',
                          )));
            },
            style: ElevatedButton.styleFrom(
                primary: viewBg,
                onPrimary: viewBg,
                padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0))),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }

  

  static Widget getAppBar() {
    return AppBar(
      leading: null,
      title: Text(ChatData.appName),
      backgroundColor: Colors.deepPurple,
    );
  }


  static Widget widgetFullPhoto(BuildContext context, String url) {
    return Container(color: Colors.black, child: PhotoView(imageProvider: NetworkImage(url)));
  }


  static Widget widgetChatBuildItem(BuildContext context, var listMessage,
      String id, int index, DocumentSnapshot document, String peerAvatar) {
    if (document.get('idFrom') == id) {
      return Container(
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
         
          document.get('type') == 0
              ? chatText(document.get('content'), id, listMessage, index, true)
              : chatImage(context, id, listMessage, document.get('content'),
                  index, true),
               
              Align(
              alignment: Alignment.bottomRight,
              child:
                  Container(
                    //padding:EdgeInsets.symmetric(horizontal: 0, vertical: 0), 

                    child:  Text(
                      ui.DateFormat('kk:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(document.get('timestamp'))))+"  ",
                      style: TextStyle(
                          color: greyColor,
                          fontSize: 11.5,
                          fontStyle: FontStyle.italic),
                          textAlign: TextAlign.left,
                    ),
                   margin: EdgeInsets.only(right: 0, top: 0.0, bottom: 10.0),))
                 // ): Container()

                 ])
                 
        ],
        mainAxisAlignment: MainAxisAlignment.end,

       
      ));

      
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ChatData.isLastMessageLeft(listMessage, id, index)
                    ? Material(
                        child: widgetShowImages(peerAvatar, 35),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                        clipBehavior: Clip.hardEdge,
                      )
                    : Container(width: 35.0),
                document.get('type') == 0
                    ? chatText(
                        document.get('content'), id, listMessage, index, false)
                    : chatImage(context, id, listMessage,
                        document.get('content'), index, false)
              ],
            ),

            // Time
           // ChatData.isLastMessageLeft(listMessage, id, index)?
                Container(
                    child: Text(
                      ui.DateFormat('kk:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(document.get('timestamp')))),
                      style: TextStyle(
                          color: greyColor,
                          fontSize: 11.3,
                          fontStyle: FontStyle.italic),
                    ),
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                  )
               // : Container(),

                 
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        //margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  static Widget widgetChatBuildListMessage(groupChatId, listMessage,
      currentUserId, peerAvatar, listScrollController, var stCollection) {
    Stream<QuerySnapshot> _streamChatData;
    _streamChatData =
        ChatDBFireStore().streamChatDataList(stCollection, groupChatId);

    return Flexible(
      child: groupChatId == ''
          ? Center(
              child: Loading())
                  //valueColor: AlwaysStoppedAnimation<Color>(themeColor)))
          : StreamBuilder<QuerySnapshot>(
              stream: _streamChatData,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Loading());
                } else {
                  listMessage = snapshot.data!.docs;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        ChatWidget.widgetChatBuildItem(
                            context,
                            listMessage,
                            currentUserId,
                            index,
                            snapshot.data!.docs[index],
                            peerAvatar),
                    itemCount: snapshot.data!.docs.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }

  static Widget chatText(String chatContent, String id, var listMessage,
      int index, bool logUserMsg) {
    return Container(
      child: Linkify(
        onOpen: (link) async {
          if (await canLaunch(link.url)) {
            await launch(link.url);
          } else {
            throw 'Could not launch $link';
          }
        },
        text: chatContent,
               textDirection: TextDirection.rtl,

        style: TextStyle(color: logUserMsg ? Colors.black : Colors.white),///here sarah
        linkStyle: TextStyle(color: Colors.blueGrey),
      ),
      
      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
     // width: kIsWeb ? 400 : 200.0,
       constraints: BoxConstraints( maxWidth: 200),///////////////////////////////sarah
      decoration: BoxDecoration(
          color: logUserMsg ? greyColor2 : Colors.purple[900],
          borderRadius: BorderRadius.circular(8.0)),
      margin: logUserMsg
          ? EdgeInsets.only(
              bottom: ChatData.isLastMessageRight(listMessage, id, index)
                  ? 5.0
                  : 5.0,
              right: 0.0)
          : EdgeInsets.only(left: 10.0),
          
    );
    
  }

  static Widget chatImage(BuildContext context, String id, var listMessage,
      String chatContent, int index, bool logUserMsg) {
    return Container(
      
      child: ElevatedButton(
          child: Material(
            child: kIsWeb
                ? widgetShowImages(chatContent, 250)
                : widgetShowImages(chatContent, 100),
            //borderRadius: BorderRadius.all(Radius.circular(10.0)),
            clipBehavior: Clip.hardEdge,
          ),
          
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ZoomImage(url: chatContent)));
          },
          style: ElevatedButton.styleFrom(padding: EdgeInsets.all(10.0))),
      margin: logUserMsg
          ? EdgeInsets.only(
              bottom: ChatData.isLastMessageRight(listMessage, id, index)
                  ? 10.0
                  : 10.0,
              right: 10.0)
          : EdgeInsets.only(left: 10.0),
    //color: Colors.red,
    );
  }

  // Show Images from network
  static Widget widgetShowImages(String imageUrl, double imageSize) {
    return CachedNetworkImage(
      color: Colors.red,// primaryColor,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => 
      Container(
        decoration: BoxDecoration(
         color: Colors.transparent,
          //backgroundBlendMode:Colors.black ,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
            //colorFilter:ColorFilter.mode(Colors.red, BlendMode.colorBurn)
          ),
        ),
     
      
      ),
     
      height: imageSize,
      width: imageSize,
      placeholder: (context, url) =>  CircularProgressIndicator( 
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple)),/////////////////////////////////////////
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
    
  }

  static Widget widgetShowText(
      String text, dynamic textSize, dynamic textColor) {
    return Text(
      '$text',
       textDirection: TextDirection.rtl,
      style: TextStyle(
          color: (textColor == '') ? Colors.white70 : textColor,
          fontSize: textSize == '' ? 14.0 : textSize),
    );
  }
}







// static Widget widgetLoginScreen(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 24.0),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: <Widget>[
  //         Container(
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Container(
  //                 child: Icon(
  //                   Icons.message,
  //                   color: Colors.greenAccent,
  //                 ),
  //                 height: 25.0,
  //               ),
  //               Text(
  //                 ChatData.appName,
  //                 style: TextStyle(
  //                   fontSize: 25.0,
  //                   fontWeight: FontWeight.w900,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: 48.0,
  //         ),
  //         Center(
  //           child: ElevatedButton(
  //               onPressed: () {
  //                 ChatData.authUser(context);
  //               },
  //               child: Text(
  //                 'SIGN IN WITH GOOGLE',
  //                 style: TextStyle(fontSize: 16.0, color: Colors.white),
  //               ),
  //               style: ElevatedButton.styleFrom(
  //                   primary: Colors.red,
  //                   onPrimary: Colors.red,
  //                   padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0))),
  //         ),
  //       ],
  //     ),
  //   );
  // }




  //static Widget widgetWelcomeScreen(BuildContext context) {
  //   return Center(
  //     child: Container(
  //         child: Text(
  //       ChatData.appName,
  //       style: TextStyle(fontSize: 28),
  //     )),
  //   );
  // }