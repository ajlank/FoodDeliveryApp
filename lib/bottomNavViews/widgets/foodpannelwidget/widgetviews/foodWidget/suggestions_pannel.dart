import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodapp/bottomNavViews/widgets/foodpannelwidget/widgetviews/foodWidget/suggestions_tab.dart';
import 'package:foodapp/bottomNavViews/widgets/foodpannelwidget/hooks/fetch/fetch_suggestion.dart';

class SuggestionsPannel extends HookWidget {
  const SuggestionsPannel({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchSuggestion();
    final suggestedFood = result.suggestions;
    final isLoading = result.isLoading;
    final error = result.error;

    if (isLoading) {
      return CircularProgressIndicator();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: Container(
        height: 120,
        color: const Color.fromARGB(255, 245, 243, 242),

        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(suggestedFood.length, (i) {
              final suggestedItem = suggestedFood[i];
              return SuggestionsTab(item: suggestedItem);
            }),
          ),
        ),
      ),
    );
  }
}
