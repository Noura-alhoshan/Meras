import 'package:flutter/material.dart';

class BackgroundC2 extends StatelessWidget {
  final Widget child;
  const BackgroundC2({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        // alignment: Alignment.center,
        children: <Widget>[
          //   Positioned(
          //  //   top: 0,
          //   left: 0,
          //  child: Image.asset(
          //   "assets/images/main_top.png",
          //   width: size.width * 0.35,
          //   ),
          //   ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.8,
            ),
          ),
          Positioned(
            top: 80,
            left: 143,
            child: Text(
              'لا يوجد مواعيد حالية',
              textAlign: TextAlign.left,
              style: TextStyle(height: 2, fontSize: 19, color: Colors.grey),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
