import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class loginCard extends StatelessWidget {
  bool passwordInvisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold( body: 
    Align( 
      alignment: const Alignment(0.1, 0.1),
      child: Container(
      width: 300,
      height: 500,
      
      padding: EdgeInsets.only(bottom: 10, top: 100),
      decoration: 
     BoxDecoration(
     
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("معلومات المتدرب",
                style: TextStyle(
                    fontSize: 23,
                    //fontFamily: "Poppins-Bold",
                    letterSpacing: .6)),
            SizedBox(
              height:30,
            ),
           
            
            
          ],
        ),
      ),
    ),
    )
    );
    
    }
}