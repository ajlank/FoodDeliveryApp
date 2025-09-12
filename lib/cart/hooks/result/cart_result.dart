import 'dart:ui';

import 'package:foodapp/cart/model/cart_model.dart';

class CartResult {
  final List<CartModel> cart;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  CartResult({
    required this.cart,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
