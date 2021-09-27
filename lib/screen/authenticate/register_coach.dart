import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meras/services/database.dart';

class RegisterAsCoatch extends StatefulWidget {

  final Function toggleView;
  RegisterAsCoatch({ required this.toggleView });

  @override
  _RegisterAsCoatchState createState() => _RegisterAsCoatchState();
}
enum SingingCharacter { lafayette, jefferson }
class _RegisterAsCoatchState extends State<RegisterAsCoatch> {

  SingingCharacter? _character = SingingCharacter.lafayette;

  String dropdownValue = 'الرمال وماحولها';
  var items = ['الرمال وماحولها','اليرموك وماحولها','الملقا وماحوله','العارض وماحوله',
    'الملز وماحولها','ظهرة لبن وماحولها','السويدي وماحوله','العزيزية وماحولها',
    'السلي وماحولها','طويق وماحولها','الدرعية وماحولها','الملك فهد وماحوله', 'عرقة وماحولها',
    'العقيق وماحولها','العليا وماحولها'];

  //late File License;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';


  // text field state
  String Fname = '';
  String Lname = '';
  String email = '';
  String password = '';
  String age = '';
  String phoneNumber = '';
  String neighborhood = '';
  String description = '';
  String gender = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
        title: Text('!مدرب جديد'),
        elevation: 0.0,
        //title: Text('مراس'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('تسجيل الدخول'),

            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body:
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2 ,color: Colors.deepPurple),
                      ),

                      hintText: "الأسم الأول"),
                  validator: (val) => val!.isEmpty ? 'الرجاء إدخال الأسم الأول' : null,
                  onChanged: (val) {
                    setState(() => Fname = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2 ,color: Colors.deepPurple),
                      ),

                      hintText: "الأسم الأخير"),
                  validator: (val) => val!.isEmpty ? 'الرجاء إدخال الأسم الأخير' : null,
                  onChanged: (val) {
                    setState(() => Lname = val);
                  },
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2 ,color: Colors.deepPurple),
                      ),
                      hintText: "البريد الإلكتروني"),
                  validator: (val) => val!.isEmpty? 'الرجاء إدخال البريد الإلكتروني' : null,//added ! to val
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2 ,color: Colors.deepPurple),
                      ),

                      hintText: "كلمة المرور"
                  ),
                  obscureText: true,
                  validator: (val) => val!.length < 6 ? '   الرجاء إدخال كلمة المرور بشكل صحيح' : null,//added ! to val
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2 ,color: Colors.deepPurple),
                      ),
                      hintText: "العمر"),
                  validator: (val) => val!.length < 2 ? 'العمر المسموح ١٧ وأعلى' : null,//added ! to val
                  onChanged: (val) {
                    setState(() => age = val);
                  },
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2 ,color: Colors.deepPurple),
                      ),
                      hintText: "رقم الجوال"),
                  validator: (val) => val!.isEmpty? 'الرجاء إدخال رقم الجوال' : null,//added ! to val
                  onChanged: (val) {
                    setState(() => phoneNumber = val);
                  },
                ),
                Text(""),
                TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2 ,color: Colors.deepPurple),
                      ),
                      hintText: "وصف"),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,//Normal textInputField will be displayed
                  maxLines: 5,// when user presses enter it will adapt to it
                  onChanged: (val){
                    setState(() {
                      description = val;
                    });
                  },
                ),
                Text(""),
                Text(""),
                Text(':اختر منطقتك السكنيةأو المنطقة التي تريد التدريب فيها', textAlign: TextAlign.right,),
                Column(
                  children: <Widget>[
                    DropdownButton(
                      items: items.map((itemsName) {
                        return DropdownMenuItem(
                            value: itemsName,
                            child: Text(itemsName)
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          neighborhood = newValue;
                        });
                      },
                      value: dropdownValue,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down_circle),
                      iconEnabledColor: Colors.deepPurple,
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Text(""),
                Text(':الجنس                                                                             ',
                  textAlign: TextAlign.right,),
                Column(
                  children: <Widget>[
                    RadioListTile<SingingCharacter>(
                      title: const Text('ذكر', textAlign: TextAlign.right,),
                      value: SingingCharacter.lafayette,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                          gender = 'ذكر';
                        });
                      },
                      controlAffinity: ListTileControlAffinity.trailing,
                      activeColor: Colors.deepPurple,
                    ),
                    RadioListTile<SingingCharacter>(
                      title: const Text('أنثى', textAlign: TextAlign.right,),
                      value: SingingCharacter.jefferson,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                          gender = 'أنثى';
                        });
                      },
                      controlAffinity: ListTileControlAffinity.trailing,
                      activeColor: Colors.deepPurple,
                    ),
                  ],
                ),
                Text(""),
                ElevatedButton(
                  //color: Colors.pink[400],
                    child: Text('تحميل صورة رخصة القيادة'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple[50],
                      onPrimary: Colors.deepPurple[900],
                      //textStyle: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async{
                      // getImage();
                      // uploadImage();
                    }
                ),

                ElevatedButton(
                  //color: Colors.pink[400],
                    child: Text('إنشاء حساب مدرب'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple[50],
                      onPrimary: Colors.deepPurple[900],
                      //textStyle: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {//async
                      if(_formKey.currentState!.validate()){
                        dynamic result = _auth.registerAsCoach(Fname, Lname,email, password, age,phoneNumber,neighborhood,description,gender,'P');//await
                        if(result == null) {
                          setState(() {
                            error = 'Please supply a valid email';
                          });
                        }
                      }
                    }
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  // void uploadImage() async{
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   Reference ref = storage.ref().child("Licenses"+ DateTime.now().toString()+".jpg");
  //   UploadTask uploadTask = ref.putFile(License);
  //   uploadTask.whenComplete(() {
  //     url = ref.getDownloadURL() as String;
  //   }).catchError((onError) {
  //     print(onError);
  //   });
  // }
  //
  // Future getImage() async {
  //   File image = (await ImagePicker.platform.getImage(source: ImageSource.gallery)) as File;
  //   setState(() {
  //     License = image;
  //   });
  // }
}
