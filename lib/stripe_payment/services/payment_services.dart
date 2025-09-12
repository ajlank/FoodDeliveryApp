import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:foodapp/cart/model/cart_model.dart';
import 'package:foodapp/order/model/create_order_model.dart';
import 'package:foodapp/stripe_payment/constsval/consts.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PaymentServices {
  PaymentServices._();

  static final PaymentServices instance = PaymentServices._();
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(
    double amount,
    BuildContext ctx,
    List<CartModel> cart,
    int address,
  ) async {
    try {
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent(amount.toInt(), 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret:
                  paymentIntent!['client_secret'], //Gotten from payment intent

              merchantDisplayName: 'Ikay',
            ),
          )
          .then((value) {});

      await displayPaymentSheet(ctx, amount, cart, address);
    } catch (err) {
      throw Exception(err);
    }
  }

  createPaymentIntent(int amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': _calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer 122121',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }

  Future<void> displayPaymentSheet(
    BuildContext ctx,
    double amount,
    List<CartModel> cart,
    int address,
  ) async {
    try {
      await Stripe.instance.presentPaymentSheet();

      await orderModelCreationBackend(amount, cart, address);

      paymentIntent = null;
    } on StripeException catch (e) {
      print("Payment cancelled or failed: $e");
    } catch (e) {
      print("Unexpected error: $e");
    }
  }

  Future<void> orderModelCreationBackend(
    double amount,
    List<CartModel> cart,
    int address,
  ) async {
    List<Map<String, dynamic>> orderProducts = cart
        .map(
          (c) => {
            "product": c.product.id,
            "quantity": c.quantity,
            "size": c.size,
          },
        )
        .toList();

    Map<String, dynamic> orderData = {
      "order_product": orderProducts,
      "address": address, // ID of the address
      "customer_id": 1222,
      "total_quantity": cart.fold(0, (sum, item) => sum + item.quantity),
      "subtotal": cart.fold(
        0.0,
        (sum, item) => sum + item.quantity * item.product.price,
      ),
      "total": amount,
      "delivery_status": "pending",
      "payment_status": "paid",
    };

    final accessToken = GetStorage().read('accessToken');
    try {
      Uri url = Uri.parse("http://192.168.0.103:8000/api/orders/add/");

      final response = await http.post(
        Uri.parse("http://192.168.0.103:8000/api/orders/add/"),
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(orderData),
      );

      print(response.statusCode);
      print(response.body);
    } catch (e) {
      print(e.toString());
    }
  }
}
