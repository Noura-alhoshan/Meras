import 'package:flutter/material.dart';

class SignleBaseAlertDialog extends StatelessWidget {

  //When creating please recheck 'context' if there is an error!

 

  String _title='';
  String _content='';
  String _yes=''; 
  String _no='';
  late Function _yesOnPressed ;
  //late Function _noOnPressed;

  SignleBaseAlertDialog({required String title,required String content,  
  
                        required Function yesOnPressed, String yes = "Yes",}){
    this._title = title;
    this._content = content;
    this._yesOnPressed = yesOnPressed;
   // this._noOnPressed = noOnPressed;
    this._yes = yes;
    //this._no = no;
  }

  @override
  Widget build(BuildContext context) {
    String space='                       ';
    return AlertDialog(
      shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 24.0),
      content: new Text(this._content,style: TextStyle(fontSize: 15.7,fontWeight: FontWeight.bold,),textAlign: TextAlign.center ),
      backgroundColor: Colors.white,
      //shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
       
        // new FlatButton(
        // child: Text(this._no, style: TextStyle(fontSize: 15.3),textAlign: TextAlign.center,),
          
        //   textColor: Colors.deepPurple[900],
        //   onPressed: () {
        //     this._noOnPressed();
        //   },
        // ),
        Center(child: 
         new FlatButton(
          child: new Text(this._yes+space,style: TextStyle(fontSize: 15.3),textAlign: TextAlign.center,),
          textColor: Colors.deepPurple[900],
          onPressed: () {
            this._yesOnPressed();
          },
        ),
        )
      ],
    );
  }
}