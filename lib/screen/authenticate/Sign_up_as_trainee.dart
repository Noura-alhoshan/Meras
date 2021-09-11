import 'package:flutter/material.dart';
import 'package:meras/services/auth.dart';

class RegisterAsTrainee extends StatefulWidget {
  final Function toggleView;
  RegisterAsTrainee({ required this.toggleView });

 // const RegisterAsTrainee({Key? key}) : super(key: key);

  @override
  _RegisterAsTraineeState createState() => _RegisterAsTraineeState();
}

class _RegisterAsTraineeState extends State<RegisterAsTrainee> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';
  String Fname = '';
  String Lname = '';
  String birthDate = '';
  String phoneNumber = '';
  String city = '';
  String gender = '';

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
                validator: (val) => val!.isEmpty? 'الرجاء إدخال تاريخ الميلاد' : null,//added ! to val
                onChanged: (val) {
                  setState(() => birthDate = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "الرمز السري"
                ),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'الرجاء إدخال الرمز السري' : null,//added ! to val
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "رقم الجوال"
                ),
                obscureText: true,
                validator: (val) => val!.length < 10 ? 'الرجاء إدخال رقم الجوال' : null,//added ! to val
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
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
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
