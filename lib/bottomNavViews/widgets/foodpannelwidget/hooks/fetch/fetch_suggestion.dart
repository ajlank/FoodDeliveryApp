import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodapp/bottomNavViews/widgets/foodpannelwidget/hooks/results/suggestions_result.dart';
import 'package:foodapp/bottomNavViews/widgets/foodpannelwidget/model/suggestion_model.dart';
import 'package:http/http.dart' as http;

SuggestionsResult fetchSuggestion() {
  final suggestions = useState<List<SuggestionsModel>>([]);

  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchDate() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse(
        "http://192.168.0.103:8000/api/product/suggestionlist/",
      );

      var response = await http.get(url);

      if (response.statusCode == 200) {
        print(response.body);
        suggestions.value = suggestionsModelFromJson(response.body);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchDate();
    return null;
  }, []);

  void refetch() {
    isLoading.value = false;
    fetchDate();
  }

  return SuggestionsResult(
    suggestions: suggestions.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
