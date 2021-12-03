import 'package:flutter/material.dart';
//import 'package:meras/screen/coachProfile_admin/coachProfile_admin.dart';

class ButtonWidgetEdit extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color colorr;
  final double verticalSize;

  final double horizontalSize;

  const ButtonWidgetEdit(
      {Key? key,
      required this.text,
      required this.onClicked,
      required this.colorr,
      this.verticalSize = 12,
      this.horizontalSize = 45})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(
          child: Text(
            text,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            primary: colorr,
            shape: StadiumBorder(),
            onPrimary:
                colorr == Colors.deepPurple ? Colors.white : Colors.white,
            padding: EdgeInsets.symmetric(
                horizontal: horizontalSize, vertical: verticalSize),
          ),

          onPressed: onClicked, //child: null,
        ),
      );
}
