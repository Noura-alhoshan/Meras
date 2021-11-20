import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';

class EditPhoneAlertDialog extends StatelessWidget {
  //When creating please recheck 'context' if there is an error!

  String _title = '';
  String _content = '';
  String _yes = '';
  String _no = '';
  var _Inittext='';
  late Function _yesOnPressed;
  late Function _noOnPressed;
  late Function _onChange;
  late final FormFieldValidator _validator;

  EditPhoneAlertDialog(
      {required String title,
      required String content,
     required var Inittext,
      required Function onChange,
      required Function yesOnPressed,
      required Function noOnPressed,
      String yes = "Yes",
      String no = "No",
      required FormFieldValidator validator}) {
    this._title = title;
    this._content = content;
    this._onChange = onChange;
    this._Inittext=Inittext;
    this._yesOnPressed = yesOnPressed;
    this._noOnPressed = noOnPressed;
    this._yes = yes;
    this._no = no;
    this._validator = validator;
  }

  final TextEditingController _controller = TextEditingController();

  void dispose() {
    _controller.dispose();
    //super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  String sp = '                  ';

  @override
  Widget build(BuildContext context) {
    _controller.text=_Inittext ;
    String space = '                       ';
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(top: 14.0, right: 23,left: 23),
      title: new Text(this._title,
          style: TextStyle(
            fontSize: 15.7,
          ),
          textAlign: TextAlign.center),
      content: Form(
        key: _formKey,
        child: TextFormField(
          validator: this._validator,
          onChanged: (value) {
            this._onChange(value);
          },
          keyboardType: TextInputType.phone,
          controller: _controller,
          cursorColor: kPrimaryColor,
          //textDirection: TextDirection.rtl,
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
      ),
      backgroundColor: Colors.white,
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
            if (_formKey.currentState!.validate()) {
              this._yesOnPressed();
            }
          },
        ),
      ],
    );
  }
}
