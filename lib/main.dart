import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meras_sprint1/TRcategory.dart';
import 'ADcategory.dart';
import 'ADpages/ADlist.dart';
import 'NotificationsHandler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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

  //initializeLocalNotification();
  //AwesomeNotifications().actionStream.listen((receivedNotification) {
  //Get.to(ADlist());
  //});

  initializeLocalNotification();

  runApp(MaterialApp(
    home: TRcategory(),
  ));
}
