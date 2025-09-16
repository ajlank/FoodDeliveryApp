import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodapp/cart/hooks/fetch/fetch_cart_count.dart';
import 'package:foodapp/utils/routes.dart';
import 'package:foodapp/utils/styles.dart';
import 'package:go_router/go_router.dart';

class HomeTopPannel extends HookWidget {
  const HomeTopPannel({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchCartCount();
    final isLoading = result.isLoading;
    final error = result.error;

    if (isLoading) {
      return CircularProgressIndicator();
    }
    final count = result.cartCount.cartCount ?? '0';
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(cartRoute);
        context.push(cartRoute);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: Styles.boxDec,
        child: Badge(
          label: Text(count.toString()),
          alignment: Alignment.topRight,
          child: Icon(Icons.shopping_cart, color: Styles.textWhiteColor),
        ),
      ),
    );
  }
}
