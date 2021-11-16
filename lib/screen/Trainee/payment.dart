import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';
//?????????????????????

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({
    required this.message,
    required this.success,
  });
}

class StripeServices {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeServices.apiBase}/payment_intents';
  static Uri paymentApiUri = Uri.parse(paymentApiUrl);
  static String secret =
      'sk_test_51JudnjFOmG51lcyIi8PRSDv4H7ELNLCciSLC2XVADPiNNhJcPYxp3zkxiumTijVJ1g3didRSyNXcat0s16E3GP2F0000YbPUUn';///////////////////////////////////////////////////////////////////////////

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeServices.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            'pk_test_51JudnjFOmG51lcyIyCHnlvbVXCi2JY24ccqbxxeSE0kTK1nqfMYdDcQ1mFe60eFtGJOPtjMYIDSWtdy8UNc5Qaaf00nkkgeKCq',////////////////////////////////////////////////////////////////////////
        androidPayMode: 'test',
        merchantId: 'test'));
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency,String description) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'description': description,//DESCRIPTION
      };

      var response =
          await http.post(paymentApiUri, headers: headers, body: body);
      return jsonDecode(response.body);
    } catch (error) {
      print('error Happened');
      throw error;
    }
  }

  static Future<StripeTransactionResponse> payNowHandler(
      {required String amount, required String currency,required String description }) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
          await StripeServices.createPaymentIntent(amount, currency,description);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],/////////////////////////////////////////security 
          paymentMethodId: paymentMethod.id));

      if (response.status == 'succeeded') {
        return StripeTransactionResponse(
            message: 'Transaction succeful', success: true);
      } else {
        return StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } catch (error) {
      return StripeTransactionResponse(
          message: 'Transaction failed in the catch block', success: false);
    } on PlatformException catch (error) {
      return StripeServices.getErrorAndAnalyze(error);
    }
  }

  static getErrorAndAnalyze(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction canceled';
    }
    return StripeTransactionResponse(message: message, success: false);
  }
}
