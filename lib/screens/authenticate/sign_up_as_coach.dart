import 'package:flutter/material.dart';
import 'package:meras/services/auth.dart';

class RegisterAsCoach extends StatefulWidget {
  //const RegisterAsCoach({Key? key}) : super(key: key);
  final Function toggleView;
  RegisterAsCoach({ required this.toggleView });

  @override
  _RegisterAsCoachState createState() => _RegisterAsCoachState();
}

class _RegisterAsCoachState extends State<RegisterAsCoach> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';
  String Fname = '';
  String Lname = '';
  int age = 0;
  String phoneNumber = '';
  String city = '';
  String gender = '';
  String location = '';
  String bio = '';
  String brivingLicense = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        elevation: 0.0,
        title: Text('مِرَاس حيث تكون القيادة أسهل'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('تسجيل دخول'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "الأسم الأول"
                ),
                validator: (val) => val!.isEmpty? 'الرجاء ادخال الأسم الأول' : null,//added ! to val
                onChanged: (val) {
                  setState(() => Fname = val);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "الأسم الأخير"
                ),
                validator: (val) => val!.isEmpty? 'الرجاء ادخال الأسم الأخير' : null,//added ! to val
                onChanged: (val) {
                  setState(() => Lname = val);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "البريد الإلكتروني"
                ),
                validator: (val) => val!.isEmpty? 'الرجاء إدخال البريد الإلكتروني' : null,//added ! to val
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              TextFormField( // @@i should set the constrain for the age@@
                decoration: InputDecoration(
                    hintText: "تاريخ الميلاد"
                ),
                validator: (val) => val! as int < 17 ? 'العمر المسموح ١٧ واكثر!' : null,//added ! to val
                onChanged: (val) {
                  setState(() => age = val as int);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "الرمز السري"
                ),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'الرجاء إدخال الرمز السري لايقل عن ٦ خانات' : null,//added ! to val
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "رقم الجوال"
                ),
                obscureText: true,
                validator: (val) => val!.length < 10 ? 'الرجاء إدخال رقم الجوال بشكل صحيح' : null,//added ! to val
                onChanged: (val) {
                  setState(() => phoneNumber = val);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "المدينة"
                ),
                obscureText: true,
                validator: (val) => val!.isEmpty ? 'الرجاء إدخال مدينتك' : null,//added ! to val
                onChanged: (val) {
                  setState(() => city = val);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "الجنس"
                ),
                obscureText: true,
                validator: (val) => val!.isEmpty ? 'الرجاء الجنس' : null,//added ! to val
                onChanged: (val) {
                  setState(() => gender = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                //color: Colors.pink[400],
                  child: Text('تسجيل'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){//added a ! check
                      dynamic result = await _auth.registerAsCoach(Fname,Lname,email,age,password,phoneNumber,city,gender);
                      if(result == null) {
                        setState(() {
                          error = 'لا يمكن تسجيل الدخول بالمعلومات المعطاة';
                        });
                      }
                    }
                  }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
