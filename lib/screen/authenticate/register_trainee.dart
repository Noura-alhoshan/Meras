import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meras/screen/authenticate/sign_in.dart';
import 'package:meras/screen/authenticate/welcome_alert.dart';
import 'package:meras/screen/home/home.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:meras/constants.dart';
import 'package:meras/screen/authenticate/background2.dart';
import 'package:meras/components/rounded_button.dart';
import 'package:meras/components/rounded_input_field.dart';
import 'package:meras/components/rounded_password_field.dart';

class RegisterAsTrainee extends StatefulWidget {
  @override
  _RegisterAsTraineeState createState() => _RegisterAsTraineeState();
}

enum SingingCharacter { lafayette, jefferson }

class _RegisterAsTraineeState extends State<RegisterAsTrainee> {
  SingingCharacter? _character = SingingCharacter.lafayette;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String e = '';
  //bool enter = true;

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

  // text field state
  String Fname = '';
  String Lname = '';
  String email = '';
  String password = '';
  //String age = '';
  String phoneNumber = '';
  String neighborhood = 'الرمال وماحولها';
  String gender = 'ذكر';
  bool _passwordVisible = true;

  int _age = 0;
  String _message = '';
  String sp = '      ';

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
      body: SingleChildScrollView(
        child: Background(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 40.0),
                SizedBox(height: 40.0),
                Text(
                  "إنشاء حساب متعلم جديد",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 40.0),
                RoundedInputField(
                  //textAlign: TextAlign.right,
                  hintText: sp + "          الأسم الأول",
                  validator: (val) => val!.isEmpty
                      ? '           الرجاء إدخال الأسم الأول'
                      : null,
                  onChanged: (val) {
                    setState(() => Fname = val);
                  },
                ),
                RoundedInputField(
                  //textAlign: TextAlign.right,
                  hintText: sp + "          الأسم الأخير",
                  validator: (val) =>
                      val!.isEmpty ? 'الرجاء إدخال الأسم الأخير' : null,
                  onChanged: (val) {
                    setState(() => Lname = val);
                  },
                ),
                RoundedInputField(
                  hintText: sp + "         البريد الإلكتروني",
                  validator: (val) {
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(val)) {
                      return 'الرجاء إدخال بريد الكتروني صالح';
                    } else if (val!.isEmpty) {
                      return 'الرجاء إدخال البريد الإلكتروني';
                    } else
                      return null;
                  },

                  //=> val!.isEmpty? 'الرجاء إدخال البريد الإلكتروني' : null,//added ! to val
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                RoundedPasswordField(
                  obscure: _passwordVisible,
                  validator: (val) => val!.length < 6
                      ? 'الرجاء إدخال كلمة المرور بشكل صحيح، ٦ خانات وأكثر'
                      : null, //added ! to val
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
                          _message = "الرجاء إدخال العمر بشكل صحيح";
                        });
                      }
                    }, //ageOnSubmitted,
                    validator: (value) {
                      if (_age < 17) {
                        return 'الرجاء إدخال العمر، ١٧ سنة وأكثر';
                      } else if (value!.isEmpty) {
                        return 'الرجاء إدخال العمر';
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
                      return 'الرجاء إدخال رقم الجوال';
                    } else if (!regExp.hasMatch(val)) {
                      return 'الرجاء إدخال رقم جوال صحيح يبدأ بـ 05';
                    }
                    return null;
                  },
                  //=> val!.isEmpty? 'الرجاء إدخال رقم الجوال' : null,//added ! to val
                  onChanged: (val) {
                    setState(() => phoneNumber = val);
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
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 15.0),
                ),
                RoundedButton(
                    //color: Colors.pink[400],
                    text: 'إنشاء حساب متعلم',
                    press: () async {
                      //async
                      if (_formKey.currentState!.validate()) {
                        try {
                          dynamic result = await _auth.registerAsTrainee(
                              Fname,
                              Lname,
                              email,
                              password,
                              _age,
                              phoneNumber,
                              neighborhood,
                              gender); //await
                          if (result == null) {
                            setState(() {
                              error =
                                  'الرجاء التأكد من إدخال المعلومات بشكل صحيح';
                            });
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WelcomeAlert()), //CHANGE IT
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          // if (enter){
                          //
                          // }
                          if (e.code == 'email-already-in-use') {
                            error = 'البريد الالكتروني المدخل مسجل بالفعل';
                          }
                        }
                        //catch(signUpError){
                        //   if(signUpError is PlatformException) {
                        //     if(signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
                        //       setState(()  {
                        //         error = 'البريد الالكتروني المدخل مسجل بالفعل';
                        //       });
                        //     }
                        //   }
                        // }
                      }
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
}
