import 'package:flutter/material.dart';
import 'package:foodapp/utils/styles.dart';

class OfferPannel extends StatelessWidget {
  const OfferPannel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 2),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12),
                  Text('Free Delivery', style: Styles.offerPannelText),
                  SizedBox(height: 6),
                  Text(
                    'Enjoy exclusive discounts on\ntasty food today!',
                    style: Styles.offerPannelText.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 48,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Order Now',
                        style: TextStyle(color: Styles.textWhiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Column(
              children: [
                SizedBox(
                  width: 166.0,
                  height: 160,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Image.asset(
                      'lib/assets/burger_mascot.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
