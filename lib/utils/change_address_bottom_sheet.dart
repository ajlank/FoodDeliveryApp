import 'package:flutter/material.dart';
import 'package:foodapp/utils/checkout/checkout_address_list.dart';

Future<dynamic> changeAddressBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 500,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(9),
            topRight: Radius.circular(9),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(height: 10),
            Center(
              child: Text(
                'Change Checkout Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF5b3e2b),
                ),
              ),
            ),

            SizedBox(height: 10),
            Divider(color: Color(0xFFC1C0C8), thickness: 0.5),
            SizedBox(height: 10),
            Text(
              'Click To Select Address',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF83829A),
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 10),
            Expanded(child: CheckoutAddressList()),
          ],
        ),
      );
    },
  );
}
