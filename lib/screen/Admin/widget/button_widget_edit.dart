import 'package:flutter/material.dart';
//import 'package:meras/screen/coachProfile_admin/coachProfile_admin.dart';

class ButtonWidgetEdit extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  final Color colorr;

  const ButtonWidgetEdit(
    show, {
    Key? key,
    required this.text,
    required this.onClicked,
    required this.colorr,
  }) : super(key: key);

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
            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 12),
          ),

          onPressed: onClicked, //child: null,
        ),
      );
}
