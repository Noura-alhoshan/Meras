import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:meras_sprint1/TRcategory.dart';
import 'NotificationsHandler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //App is terminated
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  //App is closed(Inside the RAM)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    await handleNetworkNotification(message);
  });

  // App is opened
  FirebaseMessaging.onMessageOpenedApp.listen((message) async {
    await handleNetworkNotification(message);
  });

  initializeLocalNotification();

  runApp(MaterialApp(
    home: TRcategory(),
  ));
}
