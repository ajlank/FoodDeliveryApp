import 'package:flutter/material.dart';
import 'package:foodapp/order/model/order_model.dart';

class OrderResult {
  final List<OrderModel> order;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  OrderResult({
    required this.order,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
