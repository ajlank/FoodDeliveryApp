import 'dart:ui';

import 'package:foodapp/wishlist/model/wish_list_model.dart';

class WishlistResult {
  final List<WishListModel> foods;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  WishlistResult({
    required this.foods,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
