import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

Color? getColorFromHex(String? hexColor, Color? defaultColor) {
  String? currentHexColor =
      hexColor == null ? '' : hexColor.replaceAll('#', '');
  if (currentHexColor.length == 6) {
    currentHexColor = 'FF$currentHexColor';
    return Color(int.parse('0x$currentHexColor'));
  }
  if (currentHexColor.length == 8) {
    return Color(int.parse('0x$currentHexColor'));
  }
  return defaultColor;
}

enum Status { WATING, FAILED, SUCCESS }

void showMessage(String message, Status status) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: status == Status.SUCCESS
          ? Colors.green
          : status == Status.WATING
              ? Colors.orange
              : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
