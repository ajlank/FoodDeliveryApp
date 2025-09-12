import 'package:flutter/material.dart';
import 'package:foodapp/homeproductList/model/food_list_model.dart';

class FetchFoodProductResult {
  final List<FoodListModel> foods;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchFoodProductResult({
    required this.foods,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
