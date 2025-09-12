import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodapp/bottomNavViews/widgets/foodpannelwidget/widgetviews/foodWidget/food_tab.dart';
import 'package:foodapp/homeCategory/hooks/fetch/fetch_category.dart';

class FoodPannel extends HookWidget {
  const FoodPannel({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchCategory();
    final categories = result.categories;
    final isLoading = result.isLoading;
    final error = result.error;

    if (isLoading) {
      return CircularProgressIndicator();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (i) {
          final item = categories[i];
          return FoodCategoryTab(item: item);
        }),
      ),
    );
  }
}
