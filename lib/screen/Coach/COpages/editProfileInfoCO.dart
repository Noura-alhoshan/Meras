import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/services/editTitle_alert.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Admin/widget/FullScreen.dart';
import 'package:meras/screen/Coach/COpages/editNameCO.dart';
import 'package:meras/services/auth.dart';

class EditProfileInfoCo extends StatefulWidget {
  //const EditProfileInfoCo({ Key? key }) : super(key: key);
  final String id;
  EditProfileInfoCo(this.id);

  @override
  _EditProfileInfoCoState createState() => _EditProfileInfoCoState();
}

class _EditProfileInfoCoState extends State<EditProfileInfoCo> {
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

  final _formKey = GlobalKey<FormState>();
  String error = '';
  String imageUrl = '';

  // text field state
  String Fname = '';
  String Lname = '';
  String email = '';
  String password = '';
  String phoneNumber = '';
  String neighborhood = 'الرمال وماحولها';
  String description = '';
  String gender = 'ذكر';
  String price = '';
  bool _passwordVisible = true;

  int _age = 0;
  String _message = '';
  String sp = '      ';

  static final nameValidCharacters = RegExp(r'^[a-zA-Z0-9]+$');
  String patttern = r'(^(?:[+0]966)?[0-9]{10}$)';
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تعديل معلومات الملف الشخصي               ',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Coach')
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
      document['URL'],
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
            // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 00),
            child: Column(children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    child: ImageFullScreenWrapperWidget(
                      child: im,
                      dark: false,
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Card(
                      child: ListTile(
                        title: Text(
                          document['Fname'],
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Text(
                          'الاسم الأول',
                          textAlign: TextAlign.right,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              var baseDialog = EditNameAlertDialog(
                                title: 'تعديل الاسم الأول',
                                content: 'أدخل الاسم الجديد',
                                onChange: (value) {
                                  setState(() {
                                    Fname = value;
                                  });
                                },
                                yesOnPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('Coach')
                                      .doc(widget.id)
                                      .update({'Fname': Fname.trim()});

                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                },
                                noOnPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                },
                                yes: "حفظ",
                                no: "إلغاء",
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '                            الرجاء إدخال الأسم الأول          ';
                                  } else if (value!.length == 1) {
                                    return '                   الرجاء إدخال الأسم الأول بشكل صحيح  ';
                                  } else if (!RegExp(r"^[a-zA-Z0-9]+$")
                                          .hasMatch(value) &&
                                      !RegExp(r'^[\u0621-\u064A]+$')
                                          .hasMatch(value)) {
                                    return '             الرجاء إدخال اسم أول صحيح بدون رموز خاصة';
                                  }
                                },
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      baseDialog);
                            },
                          ),
                        ),
                      ),
                      elevation: 4,
                      shadowColor: Colors.deepPurple[500],
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          document['Lname'],
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Text(
                          'الاسم الأخير',
                          textAlign: TextAlign.right,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              var baseDialog = EditNameAlertDialog(
                                title: 'تعديل الاسم الأخير',
                                content: 'أدخل الاسم الجديد',
                                onChange: (value) {
                                  setState(() {
                                    Lname = value;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '                            الرجاء إدخال الأسم الأخير          ';
                                  } else if (value!.length == 1) {
                                    return '                   الرجاء إدخال الأسم الأخير بشكل صحيح  ';
                                  } else if (!RegExp(r"^[a-zA-Z0-9]+$")
                                          .hasMatch(value) &&
                                      !RegExp(r'^[\u0621-\u064A]+$')
                                          .hasMatch(value)) {
                                    return '             الرجاء إدخال اسم أخير صحيح بدون رموز خاصة';
                                  }
                                },
                                yesOnPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('Coach')
                                      .doc(widget.id)
                                      .update({'Lname': Lname.trim()});

                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                },
                                noOnPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                },
                                yes: "حفظ",
                                no: "إلغاء",
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      baseDialog);
                            },
                          ),
                        ),
                      ),
                      elevation: 4,
                      shadowColor: Colors.deepPurple[500],
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          document['Age'].toString(),
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Text(
                          'العمر',
                          textAlign: TextAlign.right,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      elevation: 4,
                      shadowColor: Colors.deepPurple[500],
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          document['Gender'],
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Text(
                          'الجنس',
                          textAlign: TextAlign.right,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      elevation: 4,
                      shadowColor: Colors.deepPurple[500],
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          document['Email'],
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        subtitle: Text(
                          'البريد الالكتروني',
                          textAlign: TextAlign.right,
                        ),
                      ),
                      elevation: 4,
                      shadowColor: Colors.deepPurple[500],
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          document['Neighborhood'],
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Text(
                          'الحي السكني',
                          textAlign: TextAlign.right,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      elevation: 4,
                      shadowColor: Colors.deepPurple[500],
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          document['Price'],
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Text(
                          'سعر التدريب',
                          textAlign: TextAlign.right,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      elevation: 4,
                      shadowColor: Colors.deepPurple[500],
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          document['Phone Number'],
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Text(
                          'رقم الجوال',
                          textAlign: TextAlign.right,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      elevation: 4,
                      shadowColor: Colors.deepPurple[500],
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          document['Discerption'],
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Text(
                          'الوصف',
                          textAlign: TextAlign.right,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              var baseDialog = EditAlertDialog(
                                title: 'تعديل الوصف',
                                content: 'أدخل الوصف الجديد',
                                onChange: (value) {
                                  setState(() {
                                    description = value;
                                  });
                                },
                                yesOnPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('Coach')
                                      .doc(widget.id)
                                      .update({'Discerption': description});

                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');

                                  // nav1();
                                },
                                noOnPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                },
                                yes: "حفظ",
                                no: "إلغاء",
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      baseDialog);
                            },
                          ),
                        ),
                      ),
                      elevation: 4,
                      shadowColor: Colors.deepPurple[500],
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              //Center(child: EditType(document)),
            ]),
          ),
        ),
      ),
    );
  }
}
