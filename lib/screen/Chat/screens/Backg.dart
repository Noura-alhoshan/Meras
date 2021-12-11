import 'package:flutter/material.dart';

class Backg extends StatelessWidget {
  final Widget child;
  const Backg({
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
            top: 35,
            left: 85,
            child: Text(
              'لا يوجد محادثات في الوقت الحالي',
              textAlign: TextAlign.center,
              style: TextStyle(height: 2, fontSize: 17, color: Colors.grey),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
