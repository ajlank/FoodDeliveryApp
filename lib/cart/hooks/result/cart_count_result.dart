import 'package:flutter/material.dart';
import 'package:foodapp/cart/model/cart_count_model.dart';

class CartCountResult {
  final CartCountModel cartCount;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;
  CartCountResult({
    required this.cartCount,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
