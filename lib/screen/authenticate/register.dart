import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ required this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String Fname= '';
  String Lname= '';
  String Gender= '';
  //late DateTime Birth;//late?
  String Neigh= ''; 
  String Email= '';
  String Pass= ''; 
//  final DateTime now = DateTime.now();
//   final DateFormat formatter = DateFormat('yyyy-MM-dd');
//   final String formatted = formatter.format(now);
 
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.deepPurple[200],
            appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
         //title: Text('انشاء حساب مراس'),
        elevation: 0.0,
        //title: Text('مراس'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('تسجيل الدخول'),
            
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: 
       SingleChildScrollView( 
         child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => Fname = val);
                },
              ),
              SizedBox(height: 20.0),
                 TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => Lname = val);
                },
              ),
              SizedBox(height: 20.0),

                       TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => Email = val);
                },
              ),
              SizedBox(height: 20.0),

                TextFormField(
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => Pass = val);
                },
              ),
              SizedBox(height: 20.0),

                      TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => Gender = val);
                },
              ),
              SizedBox(height: 20.0),
              //         TextFormField(
              //   validator: (val) => val!.isEmpty ? 'Enter an email' : null,
              //   onChanged: (val) {
              //     setState(() => Birthdate = val);
              //   },
              // ),
              // SizedBox(height: 20.0),
         TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => Neigh = val);
                },
              ),
              SizedBox(height: 20.0),
           
              ElevatedButton(
                //color: Colors.pink[400],
            child: Text('إنشاء'),
                  style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple[50],
                  onPrimary: Colors.deepPurple[900],
                  //textStyle: TextStyle(color: Colors.black),
                ),
                onPressed: () {//async
                  if(_formKey.currentState!.validate()){
                    dynamic result = _auth.registerWithEmailAndPassword(Fname, Lname,Gender, Neigh, Email,Pass);//await
                    if(result == null) {
                      setState(() {
                        error = 'Please supply a valid email';
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
       ),
    );
  }
}