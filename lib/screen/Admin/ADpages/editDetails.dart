import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/components/rounded_button.dart';
import 'package:meras/screen/Admin/services/BaseAlertDialog.dart';
import 'package:meras/screen/Admin/services/editTitle_alert.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Admin/widget/FullScreen.dart';
import 'package:meras/screen/Admin/widget/button_widget_edit.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants.dart';

class EditDetails extends StatefulWidget {
  final String id;
  EditDetails(this.id);

  @override
  _EditDetailsState createState() => _EditDetailsState();
}

Color purple = Colors.deepPurple;
String imageUrl = '';
String newTitle = '';
String newType = '';
String dropdownValue = 'الإشارات التحذيرية';
var items = [
  'الإشارات التحذيرية',
  'الإشارات التنظيمية - الممنوعات',
  'الإشارات التنظيمية - الإجبارية',
  'الإشارات العامة'
];
String type = 'W';
var val = 'W';

class _EditDetailsState extends State<EditDetails> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تعديل معلومات إشارة المرور              ',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Guidlines')
              .where(FieldPath.documentId, isEqualTo: widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Loading(); //it was text 7.....
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) =>
                  _build(context, (snapshot.data!).docs[0]),
            );
          }),
    );
  }

  Widget _build(BuildContext context, DocumentSnapshot document) {
    Image im = new Image.network(
      document['PicLink'],
      height: 230.0,
      width: 250.0,
    );
    return BackgroundA(
      child: Container(
        height: 900,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.deepPurple.shade50,
                Colors.white10,
              ],
            )),
            //  height: 1200,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 00),
            child: Column(children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Container(
                    child: ImageFullScreenWrapperWidget(
                      child: im,
                      dark: false,
                    ),
                  ),
                ),
              ),
              Center(
                child: Center(child: EditImage(document)),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(color: Colors.deepPurple[900]),
              SizedBox(
                height: 10,
              ),
              Text(
                'الوصف: ' + document['Title'] + '  ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 23,
                    // color: kPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Center(child: EditTitle(document)),
              SizedBox(
                height: 20,
              ),
              Divider(color: Colors.deepPurple[900]),
              SizedBox(
                height: 10,
              ),
              Text(
                'النوع:' + ' ' + getType(document, document['Type']),
                style: TextStyle(height: 2, fontSize: 23),
                textAlign: TextAlign.right,
              ),
              SizedBox(
                height: 20,
              ),
              Center(child: EditType(document)),
            ]),
          ),
        ),
      ),
    );
  }

  Widget EditImage(DocumentSnapshot document) => ButtonWidgetEdit(
        colorr: purple,
        text: 'تعديل',
        onClicked: () async {
          await uploadImage();
          var baseDialog = BaseAlertDialog(
              title: "",
              content: "هل أنت متأكد من تغيير الصورة؟",
              yesOnPressed: () async {
                await FirebaseFirestore.instance
                    .collection('Guidlines')
                    .doc(widget.id)
                    .update({'PicLink': imageUrl});

                //nav1();
              },
              noOnPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              yes: "نعم",
              no: "لا");
          showDialog(
              context: context, builder: (BuildContext context) => baseDialog);
        },
      );

  Widget EditTitle(DocumentSnapshot document) => ButtonWidgetEdit(
        colorr: purple,
        text: 'تعديل',
        onClicked: () async {
          var baseDialog = EditAlertDialog(
            title: 'تعديل الوصف',
            content: 'أدخل الوصف الجديد',
            onChange: (value) {
              setState(() {
                newTitle = value;
              });
            },
            yesOnPressed: () async {
              await FirebaseFirestore.instance
                  .collection('Guidlines')
                  .doc(widget.id)
                  .update({'Title': newTitle});

              Navigator.of(context, rootNavigator: true).pop('dialog');

              // nav1();
            },
            noOnPressed: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
            yes: "حفظ",
            no: "إلغاء",
            validator: (value) {
              if (value!.isEmpty) {
                return '                                       ادخل وصف';
              } else if (value!.length == 1) {
                return '                            ادخل وصف بشكل صحيح';
              }
            },
          );
          showDialog(
              context: context, builder: (BuildContext context) => baseDialog);
        },
      );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> showInformationDialig(
      BuildContext context, DocumentSnapshot document) async {
    bool isSelected = false;
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(
                top: 24.0,
              ),
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('تغيير النوع'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '                     الإشارات التحذيرية',
                            textAlign: TextAlign.right,
                          ),
                          Radio(
                              value: 'W',
                              groupValue: val,
                              onChanged: (value) {
                                setState(() {
                                  val = value.toString();
                                  type = val;
                                });
                              }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('          الإشارات التنظيمية - الممنوعات'),
                          Radio(
                              value: 'N',
                              groupValue: val,
                              onChanged: (value) {
                                setState(() {
                                  val = value.toString();
                                  type = val;
                                });
                              }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('            الإشارات التنظيمية - الإجبارية'),
                          Radio(
                              value: 'Y',
                              groupValue: val,
                              onChanged: (value) {
                                setState(() {
                                  val = value.toString();
                                  type = val;
                                });
                              }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('                     الإشارات العامة'),
                          ),

                          //Text('الإشارات العامة'),
                          Radio(
                              value: 'G',
                              groupValue: val,
                              onChanged: (value) {
                                setState(() {
                                  val = value.toString();
                                  type = val;
                                });
                              }),
                        ],
                      ),
                    ],
                  )),
              actions: <Widget>[
                new FlatButton(
                  child: Text(
                    'إلغاء',
                    style: TextStyle(fontSize: 15.3),
                    textAlign: TextAlign.left,
                  ),
                  textColor: Colors.deepPurple[900],
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                ),
                SizedBox(
                  width: 45,
                ),
                new FlatButton(
                  child: Text(
                    'حفظ          ',
                    style: TextStyle(fontSize: 15.3),
                    textAlign: TextAlign.left,
                  ),
                  textColor: Colors.deepPurple[900],
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('Guidlines')
                        .doc(widget.id)
                        .update({'Type': type});
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        });
  }

  Widget EditType(DocumentSnapshot document) => ButtonWidgetEdit(
        colorr: purple,
        text: 'تعديل',
        onClicked: () async {
          await showInformationDialig(context, document);
          // await FirebaseFirestore.instance
          //     .collection('Guidlines')
          //     .doc(widget.id)
          //     .update({'Type': type});
        },
      );

  String getType(DocumentSnapshot document, String a) {
    switch (a) {
      case 'G':
        return 'الإشارات العامة';
      case 'N':
        return 'الإشارات التنظيمية - الممنوعات';
      case 'Y':
        return 'الإشارات التنظيمية - الإجبارية';
      case 'W':
        return 'الإشارات التحذيرية';
      default:
        return 'no type';
    }
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
}
