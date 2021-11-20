import 'package:flutter/material.dart';

class BackgroundProfileLight2 extends StatelessWidget {
  final Widget child;
  const BackgroundProfileLight2({
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
        //alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: 725,
            right: 0,
            child: Image.asset(
              "assets/images/BackgroundProfileLight2.jpeg",
              width: size.width * 1,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
