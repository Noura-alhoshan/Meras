import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';

class EditAlertDialog extends StatelessWidget {
  //When creating please recheck 'context' if there is an error!

  String _title = '';
  String _content = '';
  String _yes = '';
  String _no = '';
  late Function _yesOnPressed;
  late Function _noOnPressed;
  late Function _onChange;

  EditAlertDialog(
      {required String title,
      required String content,
      required Function onChange,
      required Function yesOnPressed,
      required Function noOnPressed,
      String yes = "Yes",
      String no = "No"}) {
    this._title = title;
    this._content = content;
    this._onChange = onChange;
    this._yesOnPressed = yesOnPressed;
    this._noOnPressed = noOnPressed;
    this._yes = yes;
    this._no = no;
  }

  final TextEditingController _controller = TextEditingController();

  void dispose() {
    _controller.dispose();
    //super.dispose();
  }

  String sp = '                    ';

  @override
  Widget build(BuildContext context) {
    String space = '                       ';
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(top: 24.0),
      title: new Text(this._title,
          style: TextStyle(
            fontSize: 15.7,
          ),
          textAlign: TextAlign.center),
      content: TextField(
        onChanged: (value) {
          this._onChange(value);
        },
        controller: _controller,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: sp + _content,
          fillColor: kPrimaryColor,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
        inputFormatters: [
          new LengthLimitingTextInputFormatter(10),
        ],
      ),

      backgroundColor: Colors.white,
      //shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        new FlatButton(
          child: Text(
            this._no,
            style: TextStyle(fontSize: 15.3),
            textAlign: TextAlign.center,
          ),
          textColor: Colors.deepPurple[900],
          onPressed: () {
            this._noOnPressed();
          },
        ),
        new FlatButton(
          child: new Text(
            this._yes + space,
            style: TextStyle(fontSize: 15.3),
            textAlign: TextAlign.center,
          ),
          textColor: Colors.deepPurple[900],
          onPressed: () {
            this._yesOnPressed();
          },
        ),
      ],
    );
  }
}
