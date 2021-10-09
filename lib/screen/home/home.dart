import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meras/constants.dart';
import 'package:meras/controllers/MyUser.dart';
import 'package:meras/screen/authenticate/NotApproaved.dart';
import 'package:meras/screen/authenticate/background.dart';
import 'package:meras/screen/authenticate/sign_in.dart';
import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:meras/services/auth.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'package:provider/provider.dart';

import '../Verify.dart';

//this home page will be edited to fit our app, this one is just for testing ^_^

// CollectionReference firevar = FirebaseFirestore.instance.collection('users');

class home extends StatefulWidget {
  home();

  AuthService aut= AuthService();
  //final String? userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}


class _HomePageState extends State<home> {
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context,) {
    // FirebaseAuth auth = FirebaseAuth.instance;
    // User? user = auth.currentUser;
    // dynamic userid = user!.uid;

    //print(userid+" hello there");//first user only

    //print(widget.userId);//updated
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        //title: Text('Side menu'),
        backgroundColor: Colors.deepPurple[100],
      ),

      body: Center( child: Text('I AM ADMIN'),),

    );

  }

}





// class home extends StatefulWidget {
//   home();

//   AuthService aut = AuthService();
//   //final String? userId;

//   @override
//   State<StatefulWidget> createState() => new _HomePageState();
// }

// class _HomePageState extends State<home> {
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context ) {
//     // FirebaseAuth auth = FirebaseAuth.instance;
//     // User? user = auth.currentUser;
//     // dynamic userid = user!.uid;

//     //print(userid+" hello there");//first user only

//     //print(widget.userId);//updated
//      FirebaseAuth auth = FirebaseAuth.instance;
//     User? getid = auth.currentUser;
//     dynamic userid = getid?.uid;
//     bool yesno = false;
  
//     //if (getid!.emailVerified == false) {
//     return  Container(
//       child: Scaffold(
//         body: Background(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.only(top: 7.0),
//             child: Container(
//               padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 50.0),
//               child: Form(
//                   //key: _formKey,
//                   child: Column(
//                     children: <Widget>[
//                       Text(
//                         '',
//                         style: TextStyle(color: Colors.red, fontSize: 14.0),
//                       ),
//                       SizedBox(height: 40.0),
//                       AlertDialog(
//                         title: const Text(
//                           'عزيزي مستخدم مراس',
//                           textAlign: TextAlign.center,
//                         ),
//                         content: SingleChildScrollView(
//                           child: ListBody(
//                             children: const <Widget>[
//                               //Text('عزيزي المدرب',textAlign: TextAlign.center,),
//                               //Text(''),
//                               // Text('\!',textAlign: TextAlign.center,),
//                               Text(
//                                 'يمكنك تسجيل الدخول بعد توثيق حسابكlllllll الإلكتروني',
//                                 textAlign: TextAlign.center,
//                               ),
//                               // Text('ملاحظة: يتم التوثيق حسب صلاحية رخصة قيادتك',textAlign: TextAlign.center,
//                               // style:TextStyle(color: Colors.red, fontSize: 14.0)),
//                               Text(''),
//                               Text(
//                                 'فريق مِرَاس',
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                         ),
//                         //backgroundColor: Colors.deepPurple[50],
//                         actions: <Widget>[
//                           TextButton(
//                             child: const Text(
//                               'إغلاق',
//                               style: TextStyle(
//                                   color: Colors.deepPurple, fontSize: 16.0),
//                             ),
//                             onPressed: () async {
//                               final FirebaseAuth _auth = FirebaseAuth.instance;
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => SignIn()),
//                               );
//                               // return await _auth.signOut();
//                               //SystemNavigator.pop();
//                               // glovar=1;
//                             },
//                           ),
//                         ],
//                       )
//                     ],
//                   )),
//             ),
//           ),
//         ),
//       ),
//     );

//      }//if 

  


    
  
// }


// class home extends StatelessWidget {
//   const home({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//    // final user =
//     //    Provider.of<MyUser?>(context); // i added ? even tho there was no error
//     //print(user);//////////////////////////////////////////////////
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? getid = auth.currentUser;
//     dynamic userid = getid?.uid;
//     bool yesno = false;

//     if (getid!.emailVerified == false) 
//         return Verify();//1
// else{
//     FirebaseFirestore.instance
//         .collection('Coach')
//         .where(FieldPath.documentId, isEqualTo: userid)
//         .get()
//         .then((querySnapshot) {
//       querySnapshot.docs.forEach((value) {
//         if (value.data()['Status'].toString() == 'P') 
//           yesno = true;
//       });

//       if (yesno) 
//         return notApproaved();//2
//     });
// }
    

//     return home();//3
//   }
// }

