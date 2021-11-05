import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:meras/Controllers/NotificationsHandler.dart';
import 'package:meras/constants.dart';
import 'package:meras/screen/Admin/ADpages/ADlist.dart';
import 'package:meras/screen/Coach/COcategory.dart';
import 'package:meras/screen/Trainee/TRcategory.dart';
import 'package:meras/screen/Trainee/TRpages/DraftF.dart';
import 'package:meras/screen/Trainee/TRpages/SendRequest.dart';
import 'package:meras/screen/Trainee/TRpages/TRnotification.dart';
import 'package:meras/screen/authenticate/sign_in.dart';
import 'package:meras/screen/home/home.dart';
import 'screen/Admin/ADcategory.dart';
import 'screen/wrapper.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meras/controllers/MyUser.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //check the pull
  await Firebase.initializeApp();

  //Get Storage initialised
  await GetStorage.init();

//App is terminated
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

//App is closed(Inside the RAM)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    await createLocalNotification(message: message.data);
  });

// App is opened
  FirebaseMessaging.onMessageOpenedApp.listen((message) async {
    await createLocalNotification(message: message.data);
  });

  initializeLocalNotification();
  AwesomeNotifications().actionStream.listen((receivedNotification) {
    Get.to(ADlistScreen());
    // GetStorage().write("NewNotification", false);
  });

  AwesomeNotifications().createdStream.listen((event) async {
    GetStorage().write("NewNotification", true);
  });

  AwesomeNotifications().dismissedStream.listen((event) {
    // GetStorage().write("NewNotification", false);
  });
  FirebaseMessaging.instance.getToken().then((token) {
    print(token);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      //catchError: () =>null,
      initialData: null,
      value: AuthService().user,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        //title: 'Flutter Auth',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home:
            //SignIn(),
            // ADcategory(),
            TRcategory(traineeId: "WmgSYdymxxdbzCaCstS8aFKqYhT2"),
        //ViewLessonRequest("BtQOpVTIjSAsLpOJVtMN"), //this is a comment to test

        ///wrapper
      ),
    );
  }
}

//Directionality( // add this
//textDirection: TextDirection.rtl,
//child:
