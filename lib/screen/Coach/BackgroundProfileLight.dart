import 'package:flutter/material.dart';

class BackgroundProfileLight extends StatelessWidget {
  final Widget child;
  const BackgroundProfileLight({
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
            bottom: 590,
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
