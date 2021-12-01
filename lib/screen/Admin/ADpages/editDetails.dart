import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/components/SingleBaseAlert.dart';
import 'package:meras/components/rounded_button.dart';
import 'package:meras/components/text_field_container.dart';
import 'package:meras/screen/Admin/ADpages/editGuidlines.dart';
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
String imageUrl = 'no';
String newTitle = 'no';
String newType = 'no';
String dropdownValue = 'الإشارات التحذيرية';
var items = [
  'الإشارات التحذيرية',
  'الإشارات التنظيمية - الممنوعات',
  'الإشارات التنظيمية - الإجبارية',
  'الإشارات العامة'
];
String type = 'W';
enum SingingCharacter {
  W,
  N,
  Y,
  G,
  none,
}

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

  SingingCharacter? _character = SingingCharacter.none;
  Widget _build(BuildContext context, DocumentSnapshot document) {
    //_character = document['Type'];
    //var _character = document['Type'];
    Image im = new Image.network(
      document['PicLink'],
      height: 230.0,
      width: 250.0,
    );
    return SingleChildScrollView(
      child: BackgroundA(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 40.0),
              //Center(child: EditImage(document)),

              Center(
                child: Container(
                  width: 170,
                  height: 70,
                  padding: EdgeInsets.all(10),
                  decoration: new BoxDecoration(
                    color: Colors.deepPurple[50],
                    border: Border.all(color: Colors.white, width: 0.0),
                    borderRadius: new BorderRadius.all(Radius.circular(29.0)),
                  ),
                  child: Center(
                    child: FlatButton(
                        onPressed: () async {
                          await uploadImage();
                        },
                        padding: EdgeInsets.all(5.0),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "تعديل الصورة",
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
                        )),
                  ),
                ),
              ),
              // Text(
              //   imageUrl,
              //   textAlign: TextAlign.center,
              //   style: TextStyle(fontSize: 11.0),
              // ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: TextFieldContainer(
                  child: TextFormField(
                    initialValue: document['Title'],
                    textDirection: TextDirection.rtl,
                    maxLines: null,
                    onChanged: (value) {
                      setState(() {
                        newTitle = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء إدخال وصف';
                      }
                    },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      labelText: 'الوصف',
                      //hintTextDirection: TextDirection.rtl,
                      labelStyle: TextStyle(
                        color: kPrimaryColor,
                      ),
                      border: InputBorder.none,
                    ),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(150),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(': النوع'),
                  RadioListTile<SingingCharacter>(
                    title: const Text(
                      'الإشارات التحذيرية',
                      textAlign: TextAlign.right,
                    ),
                    value: SingingCharacter.W,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                        newType = 'W';
                      });
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                    activeColor: kPrimaryColor,
                  ),
                  RadioListTile<SingingCharacter>(
                    title: const Text(
                      'الإشارات التنظيمية - الممنوعات',
                      textAlign: TextAlign.right,
                    ),
                    value: SingingCharacter.N,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                        newType = 'N';
                      });
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                    activeColor: kPrimaryColor,
                  ),
                  RadioListTile<SingingCharacter>(
                    title: const Text(
                      'الإشارات التنظيمية - الإجبارية',
                      textAlign: TextAlign.right,
                    ),
                    value: SingingCharacter.Y,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                        newType = 'Y';
                      });
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                    activeColor: kPrimaryColor,
                  ),
                  RadioListTile<SingingCharacter>(
                    title: const Text(
                      'الإشارات العامة',
                      textAlign: TextAlign.right,
                    ),
                    value: SingingCharacter.G,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                        newType = 'G';
                      });
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                    activeColor: kPrimaryColor,
                  ),
                ],
              )),
              SizedBox(
                height: 60,
              ),
              RoundedButton(
                  text: 'تعديل',
                  press: () async {
                    var baseDialog = BaseAlertDialog(
                      title: '',
                      content: 'هل أنت متأكد من إجراء التعديلات؟',
                      yesOnPressed: () async {
                        if (imageUrl != 'no') {
                          await FirebaseFirestore.instance
                              .collection('Guidlines')
                              .doc(widget.id)
                              .update({'PicLink': imageUrl});
                        }
                        if (newTitle != 'no') {
                          await FirebaseFirestore.instance
                              .collection('Guidlines')
                              .doc(widget.id)
                              .update({'Title': newTitle});
                        }
                        if (newType != 'no') {
                          await FirebaseFirestore.instance
                              .collection('Guidlines')
                              .doc(widget.id)
                              .update({'Type': type});
                        }
                        var baseDialog = SignleBaseAlertDialog(
                          title: '',
                          content: 'تم إجراء التعديلات بنجاح',
                          yesOnPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                            nav();
                          },
                          yes: "إغلاق",
                        );
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => baseDialog);
                      },
                      noOnPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      },
                      yes: 'نعم',
                      no: 'لا',
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => baseDialog);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  void nav() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return EditGuidlines();
        //return RequestLessonPage(icd);
      }),
    );
  }
}
