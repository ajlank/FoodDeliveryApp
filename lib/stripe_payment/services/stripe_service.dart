// import 'dart:convert';

// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:foodapp/order/model/create_order_model.dart';
// import 'package:foodapp/stripe_payment/constsval/consts.dart';
// import 'package:http/http.dart' as http;

// class StripeService {
//   StripeService._();

//   static final StripeService instance = StripeService._();
  
//    bool successPayment=false;
//   Future<void> makePayment(double amount) async {
//     try {
//       String? paymentIntentClientSecret = await _createPaymentIntent(amount.toInt(), "usd");
//       if(paymentIntentClientSecret==null) return;
//       await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
//         paymentIntentClientSecret: paymentIntentClientSecret,
//         merchantDisplayName: "Asif Khan"
//       ),
//       );
//       await _processPaymetn();
       
//        CreateOrderModel orderModel=CreateOrderModel(
//           customerId: 12122, 
//           addressId: 34343,
//           orderProducts: [], 
//           totalQuantity: 12, 
//           subtotal: 12, 
//           total: 12,
//           );
         
//              print(orderModel);
          
//         }catch(e){
//            print(e.toString());
//         }
//     }
//   }

//   Future<String?> _createPaymentIntent(int amount, String currency) async {
//     try {
//       Map<String, dynamic> data = {
//         "amount": _calculateAmount(amount),
//         "currency": currency,
//       };

//       Uri url = Uri.parse("https://api.stripe.com/v1/payment_intents");
//       var response = await http.post(
//         url,
//         body: data,
//         headers: {
//           "Authorization": "Bearer $stripeSecrectKey",
//           "Content-Type": "application/x-www-form-urlencoded",
//         },
//       );
//       final dt = jsonDecode(response.body);
//       return dt['client_secret'];
    
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }

//   Future<void>_processPaymetn()async{
//     try {
//       await Stripe.instance.presentPaymentSheet();
//       await Stripe.instance.confirmPaymentSheetPayment();
//     } catch (e) {
//       print(e);
     
//     }
//   }

//   String _calculateAmount(int amount) {
//     final calculatedAmount = amount * 100;
//     return calculatedAmount.toString();
//   }
