import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meras/Controllers/MyUser.dart';
import 'package:meras/components/ADroundedTitle.dart';
import 'package:meras/components/SingleBaseAlert.dart';
import 'package:meras/components/rounded_button.dart';
import 'package:meras/constants.dart';
import 'package:meras/screen/Admin/ADpages/ADhome.dart';
import 'package:meras/screen/Admin/ADpages/manageGuidlines.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/authenticate/background2.dart';
import 'package:meras/screen/home/BaseAlertDialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:random_string/random_string.dart';

class AddGuidlines extends StatefulWidget {
  // final String uid;
  // AddGuidlines({required this.uid});
  //const AddGuidlines({ Key? key }) : super(key: key);

  @override
  _AddGuidlinesState createState() => _AddGuidlinesState();
}

class _AddGuidlinesState extends State<AddGuidlines> {
  CollectionReference Collection =
      FirebaseFirestore.instance.collection('Guidlines');

  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _controller = TextEditingController();

  void initState() {
    super.initState();
  }

  String dropdownValue = 'الإشارات التحذيرية';
  var items = [
    'الإشارات التحذيرية',
    'الإشارات التنظيمية - الممنوعات',
    'الإشارات التنظيمية - الإجبارية',
    'الإشارات العامة'
  ];

  final _formKey = GlobalKey<FormState>();
  String error = '';
  String imageUrl = '';
  String _message = '';

  String title = '';
  String type = 'W';
  String sp = '      ';

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('إضافة إشارات سير جديدة'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade100, Colors.deepPurple.shade200],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: BackgroundA(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 40.0),
                SizedBox(height: 40.0),
                SizedBox(height: 40.0),
                SizedBox(height: 30.0),
                // SizedBox(height: 40.0),
                // SizedBox(height: 40.0),
                Container(
                  width: 150,
                  height: 70,
                  padding: EdgeInsets.all(10),
                  decoration: new BoxDecoration(
                    color: Colors.deepPurple[50],
                    border: Border.all(color: Colors.white, width: 0.0),
                    borderRadius: new BorderRadius.all(Radius.circular(29.0)),
                  ),
                  child: Center(
                    child: FlatButton(
                      onPressed: () => {
                        uploadImage(),
                      },
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "إضافة صورة",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.add_a_photo_outlined,
                              color: kPrimaryColor,
                              size: 23,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  imageUrl,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11.0),
                ),
                Center(
                  child: ADroundedTitle(
                    hintText: sp + "        وصف إشارة السير",
                    validator: (val) {
                      if (val!.isEmpty) {
                        return '                  الرجاء إدخال الوصف';
                      } else if (val!.length == 1) {
                        return '        الرجاء إدخال الوصف بشكل صحيح';
                      }
                      // else if (RegExp(r'^[\u0621-\u064A]+$').hasMatch(val)) {
                      //   return '  الرجاء إدخال وصف صحيح بدون رموز خاصة';
                      // }
                    },
                    onChanged: (val) {
                      setState(() => title = val);
                    },
                  ),
                ),
                SizedBox(height: 40.0),
                Center(
                  child: Text(
                    ':نوع إشارة السير                                                                    ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Column(
                  children: <Widget>[
                    DropdownButton(
                      items: items.map((itemsName) {
                        return DropdownMenuItem(
                            value: itemsName,
                            child: Center(
                                child: Text(
                              itemsName,
                              textAlign: TextAlign.center,
                            )));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          type = newValue;
                          if (dropdownValue.contains('الإشارات التحذيرية')) {
                            type = 'W';
                          } else if (dropdownValue
                              .contains('الإشارات التنظيمية - الممنوعات')) {
                            type = 'N';
                          } else if (dropdownValue
                              .contains('الإشارات التنظيمية - الإجبارية')) {
                            type = 'Y';
                          } else {
                            type = 'G';
                          }
                        });
                      },
                      value: dropdownValue,
                      //isExpanded: true,
                      icon: Icon(
                        Icons.arrow_drop_down,
                      ),
                      iconEnabledColor: kPrimaryColor,
                    ),
                  ],
                ),
                // SizedBox(height: 40.0),
                SizedBox(height: 40.0),
                // Container(
                //   width: 150,
                //   height: 70,
                //   padding: EdgeInsets.all(10),
                //   decoration: new BoxDecoration(
                //     color: Colors.deepPurple[50],
                //     border: Border.all(color: Colors.white, width: 0.0),
                //     borderRadius: new BorderRadius.all(Radius.circular(29.0)),
                //   ),
                //   child: Center(
                //     child: FlatButton(
                //       onPressed: () => {
                //         uploadImage(),
                //       },
                //       padding: EdgeInsets.all(5.0),
                //       child: Center(
                //         child: Row(
                //           mainAxisSize: MainAxisSize.max,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: <Widget>[
                //             Text(
                //               "إضافة صورة",
                //               style: TextStyle(
                //                   color: kPrimaryColor,
                //                   fontSize: 19,
                //                   fontWeight: FontWeight.w500),
                //             ),
                //             Icon(
                //               Icons.add_a_photo_outlined,
                //               color: kPrimaryColor,
                //               size: 23,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Text(
                //   imageUrl,
                //   textAlign: TextAlign.center,
                //   style: TextStyle(fontSize: 11.0),
                // ),
                Text(_message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.red)),
                RoundedButton(
                    text: 'إضافة',
                    press: () async {
                      if (imageUrl.isEmpty) {
                        _message = 'الرجاء تحميل صورة';
                      } else {
                        if (_formKey.currentState!.validate()) {
                          try {
                            var baseDialog = BaseAlertDialog(
                                title: "",
                                content: "هل أنت متأكد من إضافة إشارة السير؟",
                                yesOnPressed: () async {
                                  // if(type){

                                  // }
                                  addGuidlines(title, type, imageUrl);
                                  var baseDialog2 = SignleBaseAlertDialog(
                                    title: '',
                                    content: "تم إضافة إشارة السير بنجاح",
                                    yesOnPressed: () async {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                      nav();
                                    },
                                    yes: "إغلاق",
                                  );
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          baseDialog2);
                                },
                                noOnPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                },
                                yes: "نعم",
                                no: "لا");
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => baseDialog);
                          } catch (e) {
                            var baseDialog2 = SignleBaseAlertDialog(
                              title: '',
                              content:
                                  "حدث خطأ ما أثناء عملية الإضافة! حاول مرة أخرى",
                              yesOnPressed: () async {
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                              },
                              yes: "إغلاق",
                            );
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => baseDialog2);
                          }
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    //Check for permissions
    await Permission.photos.request();
    image = (await _picker.getImage(source: ImageSource.gallery))!;
    var file = File(image.path);

    if (image != null) {
      //Upload to Firebase
      var snapshot =
          await _storage.ref().child('Guidlines/${image.path}').putFile(file);

      var downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        imageUrl = downloadUrl;
      });
    } else {
      print('No Path received');
    }
  }

  addGuidlines(String title, String type, String url) async {
    String id = randomAlpha(20);
    Map<String, dynamic> GuidlinesDataDemo = {
      'ID': id,
      'Title': title,
      'Type': type,
      'PicLink': url,
    };
    Collection.doc(id).set(GuidlinesDataDemo);
  }

  void nav() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return ADhome();
        //return RequestLessonPage(icd);
      }),
    );
  }
}
