import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../constants.dart';

class EditAlertType extends StatelessWidget {
  //When creating please recheck 'context' if there is an error!

  String _title = '';
  String _content = '';
  String _yes = '';
  String _no = '';
  late Function _yesOnPressed;
  late Function _noOnPressed;
  late Function _onChange;

  EditAlertType(
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

  String dropdownValue = 'الإشارات التحذيرية';
  var items = [
    'الإشارات التحذيرية',
    'الإشارات التنظيمية - الممنوعات',
    'الإشارات التنظيمية - الإجبارية',
    'الإشارات العامة'
  ];
  String type = 'W';

  String sp = '                    ';
  var _result;

  @override
  Widget build(BuildContext context) {
    String space = '                       ';
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(
        top: 24.0,
      ),
      title: new Text(this._title,
          style: TextStyle(
            fontSize: 15.7,
          ),
          textAlign: TextAlign.center),
      content:
          // Column(
          //   children: <Widget>[
          //     DropdownButton(
          //       items: items.map((itemsName) {
          //         return DropdownMenuItem(
          //             value: itemsName,
          //             child: Center(
          //                 child: Text(
          //               itemsName,
          //               textAlign: TextAlign.center,
          //             )));
          //       }).toList(),
          //       onChanged: (newValue) {
          //         this._onChange(newValue);
          //       },
          //       value: dropdownValue,
          //       //isExpanded: true,
          //       elevation: 4,
          //       icon: Icon(
          //         Icons.arrow_drop_down,
          //       ),
          //       iconEnabledColor: kPrimaryColor,
          //     ),
          //   ],
          // ),
          // Padding(
          //padding: EdgeInsets.all(25),
          // child:
          Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RadioListTile(
              title: Text('الإشارات التحذيرية'),
              value: 'W',
              groupValue: _result,
              activeColor: kPrimaryColor,
              onChanged: (value) {
                this._onChange(value);
              }),
          RadioListTile(
              title: Text(
                'الإشارات التنظيمية - الممنوعات',
              ),
              value: 'N',
              groupValue: _result,
              activeColor: kPrimaryColor,
              onChanged: (value) {
                this._onChange(value);
              }),
          RadioListTile(
              title: Text('الإشارات التنظيمية - الإجبارية'),
              value: 'Y',
              groupValue: _result,
              activeColor: kPrimaryColor,
              onChanged: (value) {
                this._onChange(value);
              }),
          RadioListTile(
              title: Text('الإشارات العامة'),
              value: 'G',
              groupValue: _result,
              activeColor: kPrimaryColor,
              onChanged: (value) {
                this._onChange(value);
              }),
        ],
      ),
      //),

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
