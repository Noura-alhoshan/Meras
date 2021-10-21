import 'dart:io';

import 'package:flutter/services.dart';
import 'package:meras/components/name_rounded_input.dart';
import 'package:meras/screen/authenticate/background2.dart';
import 'package:meras/components/rounded_button.dart';
import 'package:meras/components/rounded_input_field.dart';
import 'package:meras/components/rounded_input_field2.dart';
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
  var items = [
    'الرمال وماحولها',
    'اليرموك وماحولها',
    'الملقا وماحوله',
    'العارض وماحوله',
    'الملز وماحولها',
    'ظهرة لبن وماحولها',
    'السويدي وماحوله',
    'العزيزية وماحولها',
    'السلي وماحولها',
    'طويق وماحولها',
    'الدرعية وماحولها',
    'الملك فهد وماحوله',
    'عرقة وماحولها',
    'العقيق وماحولها',
    'العليا وماحولها'
  ];

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
  String neighborhood = 'الرمال وماحولها';
  String description = '';
  String gender = 'ذكر';
  bool _passwordVisible = true;

  int _age = 0;
  String _message = '';
  String sp = '      ';

  static final nameValidCharacters = RegExp(r'^[a-zA-Z0-9]+$');
  String patttern = r'(^(?:[+0]966)?[0-9]{10}$)';
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  // void ageOnSubmitted(String value) {
  //   try {
  //     _age = int.parse(value);
  //   } on FormatException catch(ex) {
  //     setState(() {
  //       _message = "من فضلك أدخل عمرك بشكل صحيح";
  //     });
  //   }
  // }

  // void enterMeras() {
  //   setState(() {
  //     if (_age > 17) {
  //       _message = " ";
  //     }
  //     else {
  //       _message = "العمر المسموح به ١٧ وأكثر";
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.deepPurple[200],

      body: SingleChildScrollView(
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
                NameRoundedInputField(
                  //textAlign: TextAlign.right,
                  hintText: sp + "           الأسم الأول",
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '                  الرجاء إدخال الأسم الأول';
                    } else if (val!.length == 1) {
                      return '        الرجاء إدخال الأسم الأول بشكل صحيح';
                    } else if (!RegExp(r"^[a-zA-Z0-9]+$").hasMatch(val) &
                        RegExp(r'^[\p{Arabic}\s\p{N}]+$').hasMatch(val)) {
                      return '  الرجاء إدخال اسم أول صحيح بدون رموز خاصة';
                    }
                  },
                  onChanged: (val) {
                    setState(() => Fname = val.trim());
                  },
                ),
                NameRoundedInputField(
                  //textAlign: TextAlign.right,
                  hintText: sp + "          الأسم الأخير",
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '                  الرجاء إدخال الأسم الأخير';
                    } else if (val!.length == 1) {
                      return '        الرجاء إدخال الأسم الأخير بشكل صحيح';
                    } else if (!RegExp(r"^[a-zA-Z0-9]+$").hasMatch(val) &
                        RegExp(r'^[\p{Arabic}\s\p{N}]+$').hasMatch(val)) {
                      return '  الرجاء إدخال اسم أخير صحيح بدون رموز خاصة';
                    }
                  },
                  onChanged: (val) {
                    setState(() => Lname = val.trim());
                  },
                ),
                RoundedInputField(
                  hintText: sp + "         البريد الإلكتروني",
                  validator: (val) {
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(val)) {
                      return '            الرجاء إدخال بريد الكتروني صالح';
                    } else if (val!.isEmpty) {
                      return '               الرجاء إدخال البريد الإلكتروني';
                    } else
                      return null;
                  },

                  //=> val!.isEmpty? 'الرجاء إدخال البريد الإلكتروني' : null,//added ! to val
                  onChanged: (val) {
                    setState(() => email = val.trim());
                  },
                ),
                RoundedPasswordField(
                  obscure: _passwordVisible,
                  validator: (val) {
                    if (!isPasswordCompliant(val)) {
                      return 'الرجاء إدخال كلمة مرور تحتوي على حرف كبير وصغير ورقم';
                    } else if (!isPasswordCompliant2(val)) {
                      return '    الرجاء إدخال كلمة مرور تحتوي على ٨ خانات';
                    } else {
                      return null;
                    }
                  },
                  // val!.length < 6
                  //     ? 'الرجاء إدخال كلمة المرور بشكل صحيح، ٦ خانات وأكثر'
                  //     : null, //added ! to val
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
                    hintText: sp + "                العمر",
                    onChanged: (value) {
                      try {
                        _age = int.parse(value);
                        //enterMeras();
                      } on FormatException catch (ex) {
                        setState(() {
                          _message = "     الرجاء إدخال العمر بشكل صحيح";
                        });
                      }
                    }, //ageOnSubmitted,
                    validator: (value) {
                      if (_age < 17) {
                        return '              الرجاء إدخال العمر، ١٧ سنة وأكثر';
                      } else if (value!.isEmpty) {
                        return '             الرجاء إدخال العمر';
                      } else
                        return null;
                    }
                    //=> _age < 17 || value!.isEmpty ? 'العمر المسموح به ١٧ وأكثر' : null,
                    ),
                Text(_message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.red)),
                RoundedInputField(
                  hintText: sp + '          رقم الجوال',
                  validator: (val) {
                    RegExp regExp = new RegExp(patttern);
                    if (val.length == 0) {
                      return '                 الرجاء إدخال رقم الجوال';
                    } else if (!regExp.hasMatch(val)) {
                      return '     الرجاء إدخال رقم جوال صحيح يبدأ بـ 05';
                    }
                    return null;
                  },
                  //=> val!.isEmpty? 'الرجاء إدخال رقم الجوال' : null,//added ! to val
                  onChanged: (val) {
                    setState(() => phoneNumber = val);
                  },
                ),
                RoundedInputField2(
                  hintText: sp + "               وصف",
                  validator: (val) => val!.isEmpty
                      ? '                     الرجاء إدخال وصف'
                      : null, //added ! to val
                  onChanged: (val) {
                    setState(() => description = val);
                  },
                ),
                SizedBox(height: 40.0),
                Text(
                  ':اختر منطقتك السكنية أو المنطقة التي تريد التدرب فيها',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
                Column(
                  children: <Widget>[
                    DropdownButton(
                      items: items.map((itemsName) {
                        return DropdownMenuItem(
                            value: itemsName, child: Text(itemsName));
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
                Text(
                  ':الجنس                                                                    ',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 16.0),
                ),
                Column(
                  children: <Widget>[
                    RadioListTile<SingingCharacter>(
                      title: const Text(
                        'ذكر',
                        textAlign: TextAlign.right,
                      ),
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
                      title: const Text(
                        'أنثى',
                        textAlign: TextAlign.right,
                      ),
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
                    SizedBox(
                      height: 20.0,
                    ),
                    RoundedButton(
                      text: 'تحميل صورة رخصة القيادة',
                      textColor: kPrimaryColor,
                      color: kPrimaryLightColor,
                      press: () => uploadImage(),
                    ),
                  ],
                ),
                Text(
                  imageUrl,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 15.0),
                ),
                RoundedButton(
                    //color: Colors.pink[400],
                    text: 'إنشاء حساب مدرب',
                    press: () async {
                      //async
                      // if(imageUrl.isEmpty){
                      //   error='الرجاء تحميل صورة رخصة القيادة';
                      // } else{
                      if (_formKey.currentState!.validate()) {
                        try {
                          // if(imageUrl.isEmpty){
                          //   imageUrl=null;
                          // }
                          dynamic result = await _auth.registerAsCoach(
                              Fname,
                              Lname,
                              email,
                              password,
                              _age,
                              phoneNumber,
                              neighborhood,
                              description,
                              gender,
                              'P',
                              imageUrl); //await
                          if (result == null) {
                            setState(() {
                              error =
                                  'الرجاء التأكد من إدخال المعلومات بشكل صحيح';
                            });
                          } else
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => notApproaved()),
                            );
                        } catch (signUpError) {
                          if (signUpError is PlatformException) {
                            if (signUpError.code ==
                                'ERROR_EMAIL_ALREADY_IN_USE') {
                              error = 'البريد الالكتروني المدخل مسجل بالفعل';
                            }
                          }
                        }
                      }
                      // }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text(
                        'سجل دخول',
                        style: TextStyle(
                            fontSize: 15.5,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => SignIn()), //CHANGE IT
                      ),
                    ),
                    Text(' هل لديك حساب؟ ',
                        style: TextStyle(fontSize: 15.5, color: kPrimaryColor)),
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

  bool isPasswordCompliant(String password, [int minLength = 8]) {
    if (password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    //bool hasMinLength = password.length > minLength;

    return hasDigits & hasUppercase & hasLowercase;
  }

  bool isPasswordCompliant2(String password, [int minLength = 8]) {
    if (password.length > minLength) {
      return true;
    } else
      return false;
  }

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    //Check for permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      //Select Image
      image = (await _picker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _storage
            .ref()
            .child('Coaches Licenses/license')
            .putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path received');
      }
    } else {
      print('تم رفض الوصول لألبوم الكاميرا، فضلًا حاول مرة أخرى');
    }
  }
}
