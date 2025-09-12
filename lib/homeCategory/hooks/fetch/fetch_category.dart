import 'package:foodapp/homeCategory/hooks/result/category_result.dart';
import 'package:foodapp/homeCategory/model/category_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

CategoryResult fetchCategory() {
  final categories = useState<List<CategoryModel>>([]);

  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchDate() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse(
        "http://192.168.0.103:8000/api/product/categories/home/",
      );

      var response = await http.get(url);

      if (response.statusCode == 200) {
        categories.value = categoryModelFromJson(response.body);
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

  return CategoryResult(
    categories: categories.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
