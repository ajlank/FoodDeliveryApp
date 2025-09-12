import 'package:flutter/material.dart';
import 'package:foodapp/bottomNavViews/widgets/foodpannelwidget/model/suggestion_model.dart';

class SuggestionsTab extends StatelessWidget {
  const SuggestionsTab({super.key, required this.item});
  final SuggestionsModel item;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12),
            child: Image.network(item.imageUrl[0]),
          ),
        ),

        SizedBox(
          width: 100,
          child: Text(
            item.title,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
