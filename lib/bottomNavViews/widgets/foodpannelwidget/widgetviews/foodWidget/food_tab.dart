import 'package:flutter/material.dart';
import 'package:foodapp/homeCategory/model/category_model.dart';

class FoodCategoryTab extends StatelessWidget {
  const FoodCategoryTab({super.key, required this.item});
  final CategoryModel? item;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12),
      height: 51,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(backgroundImage: NetworkImage(item!.imageUrl)),
            SizedBox(width: 2),
            Text(
              item!.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
