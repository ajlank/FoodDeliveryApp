import 'package:flutter/material.dart';
import 'package:foodapp/homeCategory/model/category_model.dart';

class CategoryResult {
  final List<CategoryModel> categories;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  CategoryResult({
    required this.categories,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
