import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/Controllers/payment.dart';
import 'package:meras/components/SingleBaseAlert.dart';
import 'package:meras/screen/Admin/services/BaseAlertDialog.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Admin/widget/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';
//import '../payment.dart';
import 'Rate.dart';
import 'TRlessons.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ViewLessonsInfo extends StatefulWidget {
  final String id;
  ViewLessonsInfo(this.id);

  @override
  _ViewLessonsInfoState createState() => _ViewLessonsInfoState();
}

class _ViewLessonsInfoState extends State<ViewLessonsInfo> {
  final ScrollController _scrollController = ScrollController();
  late int rating = 0;

  void initState() {
    super.initState();
    StripeServices
        .init(); //////////////////////////////////////////////////////////////////////
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          ' تفاصيل الطلب',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Requests')
              .where(FieldPath.documentId, isEqualTo: widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Loading(); //it was text 7.....
            return ListView.builder(
              // controller: _scrollController,

              // physics: const NeverScrollableScrollPhysics(), //<--here
              itemCount: 1,

              itemBuilder: (context, index) =>
                  _build(context, (snapshot.data!).docs[0]),
            );
          }),
    );
  }

  Widget _build(BuildContext context, DocumentSnapshot document) {
    final String ph = document['CoachPhone'];

    return BackgroundA(
      child: Align(
        alignment: const Alignment(0, -0.4),
        child: Container(
          width: 307,
          height: 570,
          padding: EdgeInsets.only(bottom: 10, top: 0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
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
            padding: EdgeInsets.only(left: 0, right: 0, top: 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Container(
                height:
                    560, ////////////////////////////////////////////////////////////////
                //child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.deepPurple.shade50,
                      Colors.white10,
                    ],
                  )),
                  // height: 1200,
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 00),
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 6,
                    ),
                    new ListTile(
                      //leading: const Icon(Icons.today),
                      title: Text(
                        document['DateTime'].toString().substring(17, 19) ==
                                'AM'
                            ? 'يوم ' +
                                getArabicdays(document['DateTime'].toString()) +
                                ' ' +
                                document['DateTime']
                                    .toString()
                                    .substring(0, 10) +
                                '\n'
                                    ' الوقت: ' +
                                document['DateTime']
                                    .toString()
                                    .substring(11, 16) +
                                ' صباحا '
                            : 'يوم ' +
                                getArabicdays(document['DateTime'].toString()) +
                                ' ' +
                                document['DateTime']
                                    .toString()
                                    .substring(0, 10) +
                                '\n'
                                    ' الوقت: ' +
                                document['DateTime']
                                    .toString()
                                    .substring(11, 16) +
                                ' مساءً ',
                        style: TextStyle(height: 2.2, fontSize: 17.6),
                        textAlign: TextAlign.right,
                      ),
                      //subtitle: Text('February 20, 1980'),
                      trailing: IconButton(
                        icon: Icon(Icons.today_rounded),
                        iconSize: 64,
                        color: Colors.purple[900],
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(color: Colors.deepPurple[900]),

                    Text(
                      "معلومات المدرب ",
                      style: TextStyle(
                          fontSize: 22.5,
                          //fontFamily: "Poppins-Bold",
                          letterSpacing: .6,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[900]),
                      textAlign: TextAlign.left,
                    ),

                    //here is the table ################################################################3
                    Container(
                      child: Column(children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(20),
                          child: Table(
                            defaultColumnWidth: FixedColumnWidth(108.0),
                            // border: TableBorder.all(
                            // color: Colors.white,
                            // style: BorderStyle.solid,
                            // width: 0),
                            children: [
                              TableRow(children: [
                                Container(
                                    padding: EdgeInsets.all(1.0),
                                    child: Text(
                                      document['CoachName'] +
                                          ' ' +
                                          document['CoachName2'],
                                      // ' ' +
                                      // document['Lname'],
                                      style: TextStyle(
                                          fontSize: 17.5,
                                          color: Colors.grey,
                                          height: 1.3),
                                      textAlign: TextAlign.right,
                                    )),

                                Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      ':الاسم',
                                      style: TextStyle(fontSize: 18.0),
                                      textAlign: TextAlign.end,
                                    )),

                                //Column(children: [Text('')]),
                                // Column(children: [
                                // Text('')
                              ]),
                              TableRow(children: [
                                //Column(children:[Text('')]),
                                Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      document['Neighborhood'],
                                      style: TextStyle(
                                        height: 1.49,
                                        fontSize: 16.3,
                                        color: Colors.grey,
                                      ),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    )),
                                Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      ':الحي السكني',
                                      style: TextStyle(fontSize: 18.0),
                                      textAlign: TextAlign.right,
                                    )),
                              ]),
                              // TableRow(children: [
                              // Container(
                              // padding: EdgeInsets.all(2.0),
                              // child: Text(
                              // document['Gender'],
                              // style: TextStyle(
                              // height: 1.99,
                              // fontSize: 16.37,
                              // color: Colors.grey,
                              // //height: 1
                              // ),
                              // textAlign: TextAlign.right,
                              // ),
                              // ),
                              // Container(
                              // padding: EdgeInsets.all(2.0),
                              // child: Text(
                              // ':الجنس',
                              // style: TextStyle(
                              // fontSize: 18.0,
                              // ),
                              // textAlign: TextAlign.end,
                              // )),
                              // ]),
                              // TableRow(children: [
                              // Column(children: [Text('')]),
                              // Column(children: [
                              // Text('')
                              // ]), //Column(children:[Text('')]),
                              // ]),

                              TableRow(children: [
                                Container(
                                  height: 35,
                                  padding: EdgeInsets.all(2.0),
                                  child: TextButton(
                                      style: TextButton.styleFrom(
                                          padding: const EdgeInsets.all(-90),
                                          textStyle: TextStyle(
                                            fontSize: 16,
                                            // color: Colors.grey,
                                            decoration:
                                                TextDecoration.underline,
                                          )),
                                      onPressed: () {
                                        //const Text('Gradient',);
                                        launch("tel://$ph");
                                      },
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          document['CoachPhone'],
                                        ),
                                      )),
                                ),
                                Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      ':رقم الجوال',
                                      style: TextStyle(fontSize: 18.0),
                                      textAlign: TextAlign.end,
                                    )),
                              ]),
                              TableRow(children: [
                                Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      document['Price'] + ' ريال ',
                                      style: TextStyle(
                                        height: 1.49,
                                        fontSize: 16.3,
                                        color: Colors.grey,
                                      ),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    )),
                                Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      ':السعر',
                                      style: TextStyle(fontSize: 18.0),
                                      textAlign: TextAlign.end,
                                    )),
                              ]),
                              TableRow(children: [
                                Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      document['TRate'].toString(),
                                      style: TextStyle(
                                        height: 1.49,
                                        fontSize: 16.3,
                                        color: Colors.grey,
                                      ),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    )),
                                Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      ':تقييمك الحالي',
                                      style: TextStyle(fontSize: 18.0),
                                      textAlign: TextAlign.end,
                                    )),
                              ]),
                            ],
                          ),
                        ),
                        if (document['Paid'] == 'false')
                          ElevatedButton(
                            child: Text('الدفع'),
                            onPressed: () {
                              double newpD1 =
                                  ((double.parse(document['Price'])));

                              ///3.75); //*100);//.toString();//.toString();
                              double newpD = newpD1 * 100;
                              int newpI = newpD.toInt();
                              String newp = newpI.toString();
                              print(newp);
                              String desc =
                                  "اسم المتدرب: ${document['Tname']} \n رقم الجوال: ${document['TPhone Number']} \n , تحويل الى المدرب : ${document['CoachName']} ${document['CoachName2']} رقم جوال المدرب: ${document['CoachPhone']} ";
                              var baseDialog = BaseAlertDialog(
                                  title: "", //اقول خدمة؟؟؟؟
                                  content: //" سوف يتم تحويلك ل " +
                                      //"\nلدفع مبلغ " +
                                      //document['Price'] +
                                      //'ريال ' +
                                      " هل أنت متأكد من إتمام عملية دفع " +
                                          "\n" +
                                          "مبلغ ${document['Price']} ريال ؟",
                                  yesOnPressed: () async {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop('dialog');
                                    ////////////////////////////////////////////////////////////API call
                                    var response =
                                        await StripeServices.payNowHandler(
                                            amount: newp,
                                            currency: 'SAR',
                                            description: desc);
                                    print("response ${response.message}");

                                    if (response.message ==
                                        'Transaction succeful') {
                                      var baseDialog = SignleBaseAlertDialog(
                                        title: "",
                                        content:
                                            "تم دفع مبلغ ${document['Price']} ريال بنجاح",
                                        yesOnPressed: () async {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop(
                                                  'dialog'); //////////////////////////////////??????
                                        },
                                        yes: "إغلاق",
                                      );
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              baseDialog);
                                      await FirebaseFirestore.instance
                                          .collection('Requests')
                                          .doc(widget.id)
                                          .update({'Paid': 'true'});

                                      double theadded =
                                          double.parse(document['Price']);
                                      FirebaseFirestore.instance
                                          .collection("Coach")
                                          .doc(document['Cid'])
                                          .get()
                                          .then((querySnapshot) async {
                                        double ddd =
                                            querySnapshot.data()!['Earn'];
                                        ddd = ddd + theadded;
                                        FirebaseFirestore.instance
                                            .collection("Coach")
                                            .doc(document['Cid'])
                                            .update({'Earn': ddd});
                                      });
                                    } //end if

                                    else {
                                      var baseDialog = SignleBaseAlertDialog(
                                        title: "",
                                        content:
                                            ".لم تتم عملية الدفع \n يرجى المحاولة مرة أخرى",
                                        yesOnPressed: () async {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop(
                                                  'dialog'); //////////////////////////////////??????
                                          //nav1();
                                        },
                                        yes: "إغلاق",
                                        //no: "لا"
                                      );
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              baseDialog);
                                    }
                                    //Navigator.of(context, rootNavigator: true).pop('dialog');
                                  },
                                  noOnPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop('dialog');
                                  },
                                  yes: "نعم",
                                  no: "لا");
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      baseDialog);
                            },
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                primary: Color(0xFF6F35A5),
                                textStyle: TextStyle(fontSize: 16)),
                          )
                        else
                          Column(children: <Widget>[
                            if (document['IsRate'] == 'false')
                              Container(
                                child: Column(children: <Widget>[
                                   Center(
                              child: Text(
                                'تم الدفع',
                                style: TextStyle(
                                    fontSize: 18.5,
                                    color: Colors.green[600],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Center(
                              child: Text(
                                          'قيم تجربتك مع المدرب     ',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                            ),
                            SizedBox(height: 9,),
                                  Table(columnWidths: {
                                    0: FlexColumnWidth(10),
                                    1: FlexColumnWidth(25),
                                    //2: FlexColumnWidth(4),
                                  }, children: [
                                    // TableRow(children: [
                                    //   Container(),
                                    //   Container(
                                    //     //  height: 25,
                                    //     //   width: 70,
                                    //     child: 
                                    //     Text(
                                    //       'قيم تجربتك مع المدرب             .',
                                    //       style: TextStyle(
                                    //         fontSize: 18,
                                    //         color: Colors.black,
                                    //       ),
                                    //       textAlign: TextAlign.center,
                                    //     ),
                                    //   ),
                                    //   SizedBox(
                                    //     height: 35,
                                    //   ),
                                    // ]),
                                    TableRow(children: [
                                      Container(),
                                      Container(
                                        // height: 44,
                                        //width: 110,
                                        child: StarRating(
                                          rating: rating,
                                          onRatingChanged: (rating) => setState(
                                              () => this.rating = rating),
                                          color: Colors.amberAccent.shade400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ]),
                                  ]),
                                  
                                  Container(
                                    child: ElevatedButton(
                                      child: Text(
                                        'حفظ التقييم',
                                      ),
                                      //  disabledColor:
                                      onPressed: () {
                                        if (document['TRate'] == 0) {
                                          FirebaseFirestore.instance
                                              .collection('Coach')
                                              .doc(document['Cid'])
                                              .get()
                                              .then(
                                                  (DocumentSnapshot em) async {
                                            CollectionReference users =
                                                FirebaseFirestore.instance
                                                    .collection('Coach');

                                            users.doc(document['Cid']).update({
                                              'ReqCount': em['ReqCount'] + 1
                                            });
                                          });

                                          FirebaseFirestore.instance
                                              .collection('Coach')
                                              .doc(document['Cid'])
                                              .get()
                                              .then(
                                                  (DocumentSnapshot em) async {
                                            CollectionReference users =
                                                FirebaseFirestore.instance
                                                    .collection('Coach');
                                            if (em['Rate'] > 0) {
                                              print("here1");
                                              var num1 = (rating - em['Rate']);
                                              print("this rate here1 " +
                                                  num1.toString());

                                              users
                                                  .doc(document['Cid'])
                                                  .update({
                                                'Rate': (em['Rate'] +
                                                    ((num1) / em['ReqCount']))
                                              });
                                            } else {
                                              print("here2 is zero");

                                              users
                                                  .doc(document['Cid'])
                                                  .update({'Rate': rating});
                                            }
                                          });
                                        }
                                        FirebaseFirestore.instance
                                            .collection('Requests')
                                            .doc(widget.id)
                                            .update({'TRate': rating});
                                        print(rating);
                                        FirebaseFirestore.instance
                                            .collection('Requests')
                                            .doc(widget.id)
                                            .update({'IsRate': 'true'});

                                        var baseDialog = SignleBaseAlertDialog(
                                          title: "",
                                          content: "تم التقييم بنجاح",
                                          yesOnPressed: () async {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop(
                                                    'dialog'); //////////////////////////////////??????
                                          },
                                          yes: "إغلاق",
                                        );
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                baseDialog);
                                      },

                                      style: ElevatedButton.styleFrom(
                                          shape: StadiumBorder(),
                                          primary: Color(0xFF6F35A5),
                                          textStyle: TextStyle(fontSize: 16)),
                                    ),
                                  ),
                                ]),
                              ),

                            //FirebaseFirestore s=FirebaseFirestore.collection('Requests')
                            //             .where(FieldPath.documentId, isEqualTo: widget.id)
                            //            .snapshots();

                            //   Container(child: Text(update(document['Rate']))),

                            //  SizedBox(
                            //  height: 15,
                            // ),

                           
                          ]),
                      ]),
                    ),
                    ////////////////////////end of the table
                  ]),
                ),
              ),
              //),
            ]),
          ),
        ),
      ),
    );
  }

  String getArabicdays(String a) {
    switch (a.substring(19)) {
      case 'Saturday':
        return 'السبت';
      case 'Sunday':
        return 'الأحد';
      case 'Monday':
        return 'الإثنين';
      case 'Tuesday':
        return 'الثلاثاء';
      case 'Wednesday':
        return 'الأربعاء';
      case 'Thursday':
        return 'الخميس';
      case 'Friday':
        return 'الجمعة';
      default:
        return 'no day';
    }
  }

  void nav() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return TRlessons();
        //return RequestLessonPage(icd);
      }),
    );
  }
}

//هذي للدفع
//TO DO: send the price and id
//  Navigator.of(context).push(
//   MaterialPageRoute(
//     builder: (BuildContext context) => PaypalPayment(
//       onFinish: (number) async {
//         // payment done
//         print('order id: '+number);
//       },

//       COID: document['Cid'].toString(),
//       Cprice: (double.parse (document['Price']))/3.75 ,
//     ),
//   ),
// );
//print("hellppp");
