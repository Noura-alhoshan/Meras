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
          title: Text('الإشارات العامة'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.shade100,
                  Colors.deepPurple.shade200
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
        ),
        body: CardListWidget(
          type: 'G',
        ));
  }
}
