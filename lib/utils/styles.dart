import 'package:flutter/material.dart';

class Styles {
  static final BoxDecoration boxDec = BoxDecoration(
    color: const Color.fromARGB(255, 63, 61, 61),
    borderRadius: BorderRadius.circular(20),
  );

  static const TextStyle homeTopHeaderLocation = TextStyle(
    color: Colors.white,
    fontSize: 13,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle homeTopHeaderBottomLocation = TextStyle(
    color: Colors.white,
    fontSize: 13,
  );
  static const Color textWhiteColor = Colors.white;

  static const TextStyle homeBigText = TextStyle(
    color: Colors.white,
    fontSize: 28,
  );
  static const TextStyle offerPannelText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle foodNameStyle1 = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    backgroundColor: Color.fromARGB(18, 2, 2, 2),
  );
  static const TextStyle foodNameStyle2 = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w400,
    backgroundColor: Color.fromARGB(18, 2, 2, 2),
  );
}
