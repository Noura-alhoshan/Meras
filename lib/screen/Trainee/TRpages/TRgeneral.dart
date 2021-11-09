import 'package:meras/screen/Trainee/TRpages/card_list_widget.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';

class TRgeneral extends StatefulWidget {
  AuthService aut = AuthService();
  @override
  State<StatefulWidget> createState() => new _TRgeneral();
}

class _TRgeneral extends State<TRgeneral> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('الإشارات التحذيرية')),
          backgroundColor: Colors.deepPurple[100],
        ),
        body: CardListWidget(
          type: 'G',
        ));
  }
}
