import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meras/services/database.dart';
import 'package:permission_handler/permission_handler.dart';

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
  String imageUrl = '';


  // text field state
  String Fname = '';
  String Lname = '';
  String email = '';
  String password = '';
  //String age = '';
  String phoneNumber = '';
  String neighborhood = '';
  String description = '';
  String gender = '';

  int _age = 0;
  String _message = '';

  void ageOnSubmitted(String value) {
    try {
      _age = int.parse(value);
    } on FormatException catch(ex) {
      setState(() {
        _message = "من فضلك أدخل عمرك بشكل صحيح";
      });
    }
  }

  void enterMeras() {
    setState(() {
      if (_age > 17) {
        _message = " ";
      }
      else {
        _message = "العمر المسموح به ١٧ وأكثر";
      }
    });
  }


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
                  validator: (val) => val!.length < 6 ? 'الرجاء إدخال كلمة المرور بشكل صحيح' : null,//added ! to val
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
                  validator: (val) => val!.isEmpty? 'الرجاء إدخال العمر' : null,
                  onChanged: ageOnSubmitted,
                ),
                Text(
                    _message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.red)
                ),

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
                SizedBox(height: 20.0),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2 ,color: Colors.deepPurple),
                      ),
                      hintText: "وصف"),
                  validator: (val) => val!.isEmpty? 'الرجاء إدخال وصف' : null,//added ! to val
                  onChanged: (val) {
                    setState(() =>  description = val);
                  },
                ),
                SizedBox(height: 20.0),
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
                SizedBox(height: 20.0),
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
                SizedBox(height: 20.0),
                Column(
                  children: <Widget>[
                    //(imageUrl != null)
                        // ? Image.network(imageUrl)
                        // : Placeholder(fallbackHeight: 100.0, fallbackWidth: 150.0,),
                    SizedBox(height: 20.0,),
                    ElevatedButton(
                        child: Text('تحميل صورة رخصة القيادة',textAlign: TextAlign.center,),
                      style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple[50],
                            onPrimary: Colors.deepPurple[900],
                          ),
                      onPressed: () => uploadImage(),

                    ),
                  ],
                ),

                Text(imageUrl, textAlign: TextAlign.center,),
                SizedBox(height: 20.0),
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
                        enterMeras();
                        dynamic result = _auth.registerAsCoach(Fname, Lname,email, password, _age,phoneNumber,neighborhood,description,gender,'P',imageUrl);//await
                        if(result == null) {
                          setState(() {
                            error = 'من فضلك تأكد من إدخال المعلومات بشكل صحيح';
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

  uploadImage () async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    //Check for permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;
    if(permissionStatus.isGranted){
      //Select Image
      image = (await _picker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);

      if(image != null){
        //Upload to Firebase
        var snapshot = await _storage.ref()
            .child('Coaches Licenses/license')
            .putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      }else{
        print('No Path received');
      }

    }else{
      print('تم رفض الوصول لألبوم الكاميرا، فضلًا حاول مرة أخرى');
    }
  }
}
