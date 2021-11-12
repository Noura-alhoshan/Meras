import 'dart:core';
import 'package:flutter/material.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/home/BaseAlertDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'PaypalServices.dart';


//this solution works fine but needs improvments 


class PaypalPayment extends StatefulWidget {
  final Function onFinish;

  final String COID;

  final double Cprice;

  PaypalPayment({required this.onFinish, required this.COID , required this.Cprice});

// PaypalPaymentState(double nnn){
//   this.COID=nnn;
// }
  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

//double ciid= COID;



class PaypalPaymentState extends State<PaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //double ciid=COID;
   String? checkoutUrl;//added late and ?
   String? executeUrl;//added late and ?
   String? accessToken;
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic,dynamic> defaultCurrency = {"symbol": "USD ", "decimalDigits": 2, "symbolBeforeTheNumber": true, "currency": "USD"};

  bool isEnableShipping = false;//true 
  bool isEnableAddress = false;//true


///to be changed 
  String returnURL = 'example.com';
  String cancelURL= 'cancel.example.com'; 


  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = (await services.getAccessToken())!;

        final transactions = getOrderParams();
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
        print('exception: '+e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        _scaffoldKey.currentState!.showSnackBar(snackBar);//added !
      }
    });
  }

  // item name, price and quantity
  String itemName = 'درس تعليم قيادة';
  String itemPrice = '1.99';//////change the price
  int quantity = 1;

  Map<String, dynamic> getOrderParams() {
    List items = [
      {
        "name": itemName,
        "quantity": quantity,
        "price": itemPrice,
        "currency": defaultCurrency["currency"]
      }
    ];


    // checkout invoice details
    String totalAmount = '1.99';//widget.Cprice.toString();//////////////////////////////
    String subTotalAmount = '1.99';
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String userFirstName = 'Haifa';
    String userLastName = 'Yadav';
    String addressCity = 'Delhi';
    String addressStreet = 'Mathura Road';
    String addressZipCode = '110014';
    String addressCountry = 'India';
    String addressState = 'Delhi';
    String addressPhoneNumber = '+919990119091';

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,//widget.Cprice.toStringAsFixed(2),
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount":
                  ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (isEnableShipping &&
                isEnableAddress)
              "shipping_address": {
                "recipient_name": userFirstName +
                    " " +
                    userLastName,
                "line1": addressStreet,
                "line2": "",
                "city": addressCity,
                "country_code": addressCountry,
                "postal_code": addressZipCode,
                "phone": addressPhoneNumber,
                "state": addressState
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {
        "return_url": returnURL,
        "cancel_url": cancelURL
      }
    };
    return temp;
  }

  @override
  Widget build(BuildContext context,) {
    print('sosoooo');
    print(checkoutUrl);

    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,// check if this is the gray window
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              print("IM HERE BABE0000");
              final uri = Uri.parse(request.url);///////////////////////////////////////////
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services
                    .executePayment(executeUrl, payerID, accessToken)
                    .then((id) {
                  widget.onFinish(id);
                  print("IM HERE BABE");         
                  Navigator.of(context).pop();
                         
                  });
              } else {
                Navigator.of(context).pop();
                print("IM HERE BABE2");
              }
             // Navigator.of(context).pop();
             
             
              print(widget.Cprice);////////////////////////////////////////////////////


              print("IM HERE BABE3");
                 var baseDialog = BaseAlertDialog(
                    title: "",
                    content: "تم الانتهاء من عملية الدفع",//////////////////////
                    yesOnPressed: () async {
                     // await _auth.signOut();
                      //print("hellppp");
                      Navigator.of(context).pop();
                       Navigator.of(context, rootNavigator: true).pop('dialog');
                     // Navigator.of(context, rootNavigator: true).pop('dialog');
                      // Navigator.of(context, rootNavigator: true).pop('dialog');//عكستهم
                      //Navigator.of(context).push(
                             //  MaterialPageRoute(builder: (context) => SignIn()),//CHANGE IT
                             //); 
                    },

                    noOnPressed: () {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                    yes: "نعم",
                    no: "لا");
                showDialog(context: context, builder: (BuildContext context) => baseDialog);


            }
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
              print("IM HERE BABE4");
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,//////////////////////
          elevation: 0.0,
        ),
        body: Center(child: Container(child: Loading())),
      );
    }
  }
}


//to convert the currency 
price(){


}