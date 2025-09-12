import 'package:flutter/material.dart';

class ReusableHeader extends StatelessWidget {
  const ReusableHeader({
    super.key,
    required this.leftText,
    required this.rightText,
  });

  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 40,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leftText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(rightText),
          ],
        ),
      ),
    );
  }
}
