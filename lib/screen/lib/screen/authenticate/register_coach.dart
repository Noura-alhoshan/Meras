import 'dart:io';

import 'package:meras/screen/Welcome/welcome_screen.dart';
import 'package:meras/screen/authenticate/background2.dart';
import 'package:meras/components/rounded_button.dart';
import 'package:meras/components/rounded_input_field.dart';
import 'package:meras/components/rounded_password_field.dart';
import 'package:meras/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meras/screen/authenticate/sign_in.dart';
import 'package:meras/screen/home/home.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meras/services/database.dart';
import 'package:permission_handler/permission_handler.dart';

import 'NotApproaved.dart';

class RegisterAsCoatch extends StatefulWidget {


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
  bool _passwordVisible=true;

  int _age = 0;
  String _message = '';
  String sp='      ';

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


      body:
      SingleChildScrollView(

        child: Background(

          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 40.0),
                SizedBox(height: 40.0),
                Text(
                  "إنشاء حساب مدرب جديد",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 40.0),
                RoundedInputField(
                  //textAlign: TextAlign.right,
                  hintText: sp+"          الأسم الأول",
                  validator: (val) => val!.isEmpty ? 'الرجاء إدخال الأسم الأول' : null,
                  onChanged: (val) {
                    setState(() => Fname = val);
                  },
                ),
                RoundedInputField(
                  //textAlign: TextAlign.right,
                  hintText: sp+"          الأسم الأخير",
                  validator: (val) => val!.isEmpty ? 'الرجاء إدخال الأسم الأخير' : null,
                  onChanged: (val) {
                    setState(() => Lname = val);
                  },
                ),
                RoundedInputField(

                  hintText: sp+"         البريد الاكتروني",
                  validator: (val) => val!.isEmpty? 'الرجاء إدخال البريد الإلكتروني' : null,//added ! to val
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                RoundedPasswordField(
                  obscure:_passwordVisible ,
                  validator: (val) => val!.length < 6 ? 'الرجاء إدخال كلمة المرور بشكل صحيح، ٦ خانات وأكثر' : null,//added ! to val
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  icons: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: kPrimaryColor,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                RoundedInputField(
                  hintText: sp+"                العمر",
                  onChanged: ageOnSubmitted,
                  validator: (value) {  },
                ),
                Text(
                    _message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.red)
                ),
                RoundedInputField(
                  hintText: sp+"          رقم الجوال",
                  validator: (val) => val!.isEmpty? 'الرجاء إدخال رقم الجوال' : null,//added ! to val
                  onChanged: (val) {
                    setState(() => phoneNumber = val);
                  },
                ),
                RoundedInputField(
                  hintText: sp+"               وصف",
                  validator: (val) => val!.isEmpty? 'الرجاء إدخال وصف' : null,//added ! to val
                  onChanged: (val) {
                    setState(() =>  description = val);
                  },
                ),
                SizedBox(height: 40.0),
                Text(':اختر منطقتك السكنية أو المنطقة التي تريد التدرب فيها', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),),
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
                      //isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down_circle),
                      iconEnabledColor: Colors.deepPurple,
                    )
                  ],
                ),
                SizedBox(height: 40.0),
                Text(':الجنس                                                                    ',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 16.0),),
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
                Column(
                  children: <Widget>[
                    //(imageUrl != null)
                        // ? Image.network(imageUrl)
                        // : Placeholder(fallbackHeight: 100.0, fallbackWidth: 150.0,),
                    SizedBox(height: 20.0,),
                    RoundedButton(
                      text: 'تحميل صورة رخصة القيادة',
                      textColor: kPrimaryColor,
                      color: kPrimaryLightColor,
                      press: () => uploadImage(),

                    ),
                  ],
                ),
                Text(imageUrl, textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11.0),),
                RoundedButton(
                  //color: Colors.pink[400],
                    text: 'إنشاء حساب مدرب',
                    press: () {//async
                      if(_formKey.currentState!.validate()){
                        enterMeras();
                        dynamic result = _auth.registerAsCoach(Fname, Lname,email, password, _age,phoneNumber,neighborhood,description,gender,'P',imageUrl);//await
                        if(result == null) {
                          setState(() {
                            error = 'من فضلك تأكد من إدخال المعلومات بشكل صحيح';
                          });
                        }
                      }
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => notApproaved()),
                      );
                    }
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 15.0),
                ),
                Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text('سجل دخول',style: TextStyle(fontSize: 15.5,color: kPrimaryColor,fontWeight: FontWeight.bold),),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignIn()),//CHANGE IT
                      ),
                    ),

                    Text(' هل لديك حساب؟ ',style: TextStyle(fontSize: 15.5,color: kPrimaryColor)),
                  ],
                ),
                SizedBox(height: 40.0),
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
