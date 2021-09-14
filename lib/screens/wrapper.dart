import 'package:flutter/material.dart';
import 'package:meras/models/MyUser.dart';
import 'package:meras/screens/authenticate/authenticate.dart';
import 'package:meras/screens/home/home.dart';
import 'package:provider/provider.dart';

class wrapper extends StatelessWidget {
  const wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);
    //print(user);

    //return either home or authenticate widget
    if(user == null){
      return authenticate();
    }
    else {
      return home();
    }
  }
}
