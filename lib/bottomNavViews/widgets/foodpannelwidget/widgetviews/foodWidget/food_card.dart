import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodapp/bottomNavViews/widgets/foodpannelwidget/widgetviews/foodWidget/food_card_list.dart';
import 'package:foodapp/homeproductList/hooks/fetch/fetch_food_product.dart';

class FoodCard extends HookWidget {
  const FoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchFoodList();
  
    final isLoading = result.isLoading;
    final error = result.error;

    if (isLoading) {
      return CircularProgressIndicator();
    }
      final food = result.foods;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(4, (i) {
          final foodItem = food[i];
          return FoodCardList(foods: foodItem);
        }),
      ),
    );
  }
}
