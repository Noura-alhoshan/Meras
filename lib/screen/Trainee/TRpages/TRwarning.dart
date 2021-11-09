import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';

import 'card_list_widget.dart';

class TRwarning extends StatefulWidget {
  AuthService aut = AuthService();
  @override
  State<StatefulWidget> createState() => new _TRwarning();
}

class _TRwarning extends State<TRwarning> {
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
          type: 'W',
        ));
  }
}
