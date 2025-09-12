import 'dart:ui';

import 'package:foodapp/bottomNavViews/widgets/foodpannelwidget/model/suggestion_model.dart';

class SuggestionsResult {
  final List<SuggestionsModel> suggestions;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  SuggestionsResult({
    required this.suggestions,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
