import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/components/SingleBaseAlert.dart';
import 'package:meras/screen/Admin/services/editTitle_alert.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Admin/widget/FullScreen.dart';
import 'package:meras/screen/Coach/COpages/editNameCO.dart';
import 'package:meras/screen/Coach/COpages/editPhoneDialog.dart';

 
class EditProfileInfoTr extends StatefulWidget {
  //const EditProfileInfoCo({ Key? key }) : super(key: key);
  final String id;
 
  final String aaa;//age
  EditProfileInfoTr(this.id, this.aaa);

  @override
  _EditProfileInfoTrState createState() => _EditProfileInfoTrState();
}

class _EditProfileInfoTrState extends State<EditProfileInfoTr> {
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
  
  
  // text field state
  String Fname = '';
  String Lname = '';
  String email = '';
  String password = '';
  String phoneNumber = '';
  String neighborhood = 'الرمال وماحولها';
  String description = '';
  String price = '';
  String emailnew='';

int _age = 0;
  String _message = 'cool';
  String sp = '      ';

  TextEditingController _controller = TextEditingController();
  TextEditingController _controller1111 = TextEditingController();

  void initState() {
    super.initState();
    //_controller.text = widget.ppp; 
    _controller1111.text=widget.aaa;// Setting the initial value for the field.
  }

  static final nameValidCharacters = RegExp(r'^[a-zA-Z0-9]+$');
  String patttern = r'(^(?:[+0]966)?[0-9]{10}$)';
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تعديل معلومات الملف الشخصي    ',
          textAlign: TextAlign.center,
        ),
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('trainees')
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
    neighborhood = document['Neighborhood'];
    // Image im = new Image.network(
    //   document['URL'],
    //   height: 230.0,
    //   width: 250.0,
    // );
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
                 child: ClipOval(
              child: document['Gender'] == 'أنثى'
                  ? Image.asset(
                      "assets/images/TF.png",
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      "assets/images/TM.png",
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
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
                                Inittext: document['Fname'],
                                content: 'أدخل الاسم الجديد',
                                onChange: (value) {
                                  setState(() {
                                    Fname = value.trim();
                                  });
                                },
                                yesOnPressed: () async {
                                   var baseDialog = SignleBaseAlertDialog(
                                      title: "",
                                      content: "تم تعديل الاسم الأول بنجاح",
                                      yesOnPressed: () async {
                                        Navigator.of(context, rootNavigator: true).pop('dialog'); //////////////////////////////////??????
                                        Navigator.of(context, rootNavigator: true).pop('dialog');
                                      },
                                      yes: "إغلاق",
                                    );
                                    showDialog(context: context,builder: (BuildContext context) =>baseDialog);
                                  await FirebaseFirestore.instance
                                      .collection('trainees')
                                      .doc(widget.id)
                                      .update({'Fname': Fname.trim()});

                                  
                                },
                                noOnPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                },
                                yes: "حفظ",
                                no: "إلغاء",
                                validator: (value) {
                                  if (value.trim()!.isEmpty) {
                                    return '                            الرجاء إدخال الأسم الأول          ';
                                  } else if (value.trim()!.length == 1) {
                                    return '                   الرجاء إدخال الأسم الأول بشكل صحيح  ';
                                  } else if (!RegExp(r"^[a-zA-Z]+$")
                                          .hasMatch(value) &&
                                      !RegExp(r'^[\u0621-\u064A]+$')
                                          .hasMatch(value)) {
                                    return '         الرجاء إدخال اسم أول صحيح بدون رموز خاصة وأرقام';
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
                                 Inittext: document['Lname'],
                                content: 'أدخل الاسم الجديد',
                                onChange: (value) {
                                  setState(() {
                                    Lname = value;
                                  });
                                },
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return '                            الرجاء إدخال الأسم الأخير          ';
                                  } else if (value!.trim().length == 1) {
                                    return '                   الرجاء إدخال الأسم الأخير بشكل صحيح  ';
                                  } else if (!RegExp(r"^[a-zA-Z]+$")
                                          .hasMatch(value) &&
                                      !RegExp(r'^[\u0621-\u064A]+$')
                                          .hasMatch(value)) {
                                    return '        الرجاء إدخال اسم أخير صحيح بدون رموز خاصة وأرقام';
                                  }
                                },
                                yesOnPressed: () async {
                                   var baseDialog = SignleBaseAlertDialog(
                                      title: "",
                                      content: "تم تعديل الاسم الأخير بنجاح",
                                      yesOnPressed: () async {
                                        Navigator.of(context, rootNavigator: true).pop('dialog'); //////////////////////////////////??????
                                        Navigator.of(context, rootNavigator: true).pop('dialog');
                                      },
                                      yes: "إغلاق",
                                    );
                                    showDialog(context: context,builder: (BuildContext context) =>baseDialog);
                                  await FirebaseFirestore.instance
                                      .collection('trainees')
                                      .doc(widget.id)
                                      .update({'Lname': Lname.trim()});

                               
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
                            onPressed: () async {
                              await showInformationDialig3(context, document);
                        
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
                          document['Gender'],
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        subtitle: Text(
                          'الجنس',
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

                   // #######################################################################
                    Card(
                      child: ListTile(
                        title: Text(
                          document['Email'],
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            //color: Colors.grey,
                          ),
                        ),
                        subtitle: Text(
                          'البريد الالكتروني',
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
                                Inittext: document['Email'],
                                title: 'تعديل البريد الإلكتروني',
                                content: 'أدخل البريد الإلكتروني الجديد',
                                onChange: (value) {
                                  setState(() {
                                    emailnew = value.trim();
                                  });
                                },
                                yesOnPressed: () async {
                                  var baseDialog = SignleBaseAlertDialog(
                                      title: "",
                                      content: " تم تعديل البريد الإلكتروني بنجاح \n الرجاء الدخول على الرابط المرسل لبريدك الإلكتروني الجديد لإثبات ملكية الحساب",
                                      yesOnPressed: () async {
                                        Navigator.of(context, rootNavigator: true).pop('dialog'); 
                                        Navigator.of(context, rootNavigator: true).pop('dialog');
                                      },
                                      yes: "إغلاق",
                                    );
                                    showDialog(context: context,builder: (BuildContext context) =>baseDialog);
                                     

                                     /////////////////////////////////////////////////////////
                                     var message;
                                    FirebaseAuth auth = FirebaseAuth.instance;
                                    User? user13 = auth.currentUser;
                                    user13!
                                        .updateEmail(emailnew)
                                        .then(
                                          (value) => message = 'Success',
                                        )
                                        .catchError((onError) => message = 'error');
                                        print(message);
                                  await FirebaseFirestore.instance
                                      .collection('trainees')
                                      .doc(widget.id)
                                      .update({'Email': emailnew.trim()});                             
                                },
                                noOnPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                },
                                yes: "حفظ",
                                no: "إلغاء",
                               validator: (val) {
                    RegExp regex = new RegExp(pattern);
                    if (val.trim()==document['Email'])
                    return '                الرجاء إدخال بريد إلكتروني جديد';
                   else if (val.trim().isEmpty) {
                    return '               الرجاء إدخال البريد الإلكتروني';
                    } else if (!regex.hasMatch(val.trim())) {
                      return '               الرجاء إدخال بريد الكتروني صالح';
                    } else
                      return null;
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
                    //##############################################################################
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
                            onPressed: () async {
                              await showInformationDialig(context, document);
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
                    // Card(
                    //   child: ListTile(
                    //     title: Text(
                    //       document['Price'],
                    //       textAlign: TextAlign.right,
                    //     ),
                    //     subtitle: Text(
                    //       'سعر التدريب لساعتين',
                    //       textAlign: TextAlign.right,
                    //     ),
                    //     leading: CircleAvatar(
                    //       backgroundColor: Colors.black54,
                    //       child: IconButton(
                    //         icon: Icon(
                    //           Icons.edit,
                    //           color: Colors.white,
                    //         ),
                    //         onPressed: () async {
                    //           await showInformationDialig2(context, document);
                    //         },
                    //       ),
                    //     ),
                    //   ),
                    //   elevation: 4,
                    //   shadowColor: Colors.deepPurple[500],
                    //   shape: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(18),
                    //       borderSide:
                    //           BorderSide(color: Colors.white, width: 1)),
                    // ),
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
                            onPressed: () async {
                              var baseDialog = EditPhoneAlertDialog(
                                title: 'تعديل رقم الجوال',
                                Inittext: document['Phone Number'],
                                content: 'أدخل رقم الجوال الجديد       ',
                                onChange: (value) {
                                  setState(() {
                                    phoneNumber = value;
                                  });
                                },
                                validator: (value) {
                                  RegExp regExp = new RegExp(r"^\+?0[0-9]{9}$");
                                  if (value.trim().length == 0) {
                                    return '                              الرجاء إدخال رقم الجوال';
                                  } else if (value.trim().length < 10) {
                                    return '                  الرجاء إدخال رقم جوال صحيح';
                                  } else if (!regExp.hasMatch(value.trim())) {
                                    return '                  الرجاء إدخال رقم جوال يبدأ بـ 05';
                                  }
                                  return null;
                                },
                                yesOnPressed: () async {
                                var baseDialog = SignleBaseAlertDialog(
                                      title: "",
                                      content: "تم تعديل رقم الجوال بنجاح",
                                      yesOnPressed: () async {
                                        Navigator.of(context, rootNavigator: true).pop('dialog'); //////////////////////////////////??????
                                        Navigator.of(context, rootNavigator: true).pop('dialog');
                                      },
                                      yes: "إغلاق",
                                    );
                                    showDialog(context: context,builder: (BuildContext context) =>baseDialog);
                                  await FirebaseFirestore.instance
                                      .collection('trainees')
                                      .doc(widget.id)
                                      .update(
                                          {'Phone Number': phoneNumber.trim()});

                                  // Navigator.of(context, rootNavigator: true)
                                  //     .pop('dialog');
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

  Future<void> showInformationDialig(
      BuildContext context, DocumentSnapshot document) async {
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
                      Text('تعديل الحي السكني'),
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
                                neighborhood = newValue;
                              });
                              print(newValue);
                            },
                            value: neighborhood,
                            icon: Icon(
                              Icons.arrow_drop_down,
                            ),
                            iconEnabledColor: Colors.black,
                          )
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
                    var baseDialog = SignleBaseAlertDialog(
                                      title: "",
                                      content: "تم تعديل الحي السكني بنجاح",
                                      yesOnPressed: () async {
                                        Navigator.of(context, rootNavigator: true).pop('dialog'); //////////////////////////////////??????
                                        Navigator.of(context, rootNavigator: true).pop('dialog');
                                      },
                                      yes: "إغلاق",
                                    );
                                    showDialog(context: context,builder: (BuildContext context) =>baseDialog);
                    await FirebaseFirestore.instance
                        .collection('trainees')
                        .doc(widget.id)
                        .update({'Neighborhood': neighborhood});
                   
                  },
                ),
              ],
            );
          });
        });
  }

  
    Future<void> showInformationDialig3(
      BuildContext context, DocumentSnapshot document) async {
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
                      Text('تعديل العمر'),
                      Center(
                        child: Container(
                          width: 120.0,
                          foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            // border: Border.all(
                            //   color: Colors.white,
                            //   width: 0.0,
                            // ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8.0),
                                    // border: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(10.0),
                                    // ),
                                  ),
                                  controller: _controller1111,
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: false,
                                    signed: true,
                                  ),
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              Container(
                                height: 38.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: InkWell(
                                        child: Icon(
                                          Icons.arrow_drop_up,
                                          size: 18.0,
                                        ),
                                        onTap: () {
                                          int currentValue =
                                              int.parse(_controller1111.text);
                                          setState(() {
                                            currentValue = currentValue + 1;
                                            _controller1111.text =
                                                (currentValue < 70
                                                        ? currentValue
                                                        : 70)
                                                    .toString();
                                            //_controller.text = (currentValue).toString(); // incrementing value
                                          });
                                        },
                                      ),
                                    ),
                                    InkWell(
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 18.0,
                                      ),
                                      onTap: () {
                                        int currentValue =
                                            int.parse(_controller1111.text);
                                        setState(() {
                                          //print("hello state");
                                          currentValue = currentValue - 1;
                                          _controller1111.text = (currentValue > 17
                                                  ? currentValue
                                                  : 17)
                                              .toString();
                                          // decrementing value
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
                     var baseDialog = SignleBaseAlertDialog(
                                      title: "",
                                      content: "تم تعديل العمر بنجاح",
                                      yesOnPressed: () async {
                                        Navigator.of(context, rootNavigator: true).pop('dialog'); //////////////////////////////////??????
                                        Navigator.of(context, rootNavigator: true).pop('dialog');
                                      },
                                      yes: "إغلاق",
                                    );
                                    showDialog(context: context,builder: (BuildContext context) =>baseDialog);
                    await FirebaseFirestore.instance
                        .collection('trainees')
                        .doc(widget.id)
                        .update({'Age': int.parse(_controller1111.text)});
                   
                  },
                ),
              ],
            );
          });
        });
      }
}
