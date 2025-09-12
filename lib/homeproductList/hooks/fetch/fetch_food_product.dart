import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodapp/homeproductList/hooks/result/food_product_result.dart';
import 'package:foodapp/homeproductList/model/food_list_model.dart';
import 'package:http/http.dart' as http;

FetchFoodProductResult fetchFoodList() {
  final foods = useState<List<FoodListModel>>([]);

  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchDate() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse("http://192.168.0.103:8000/api/product/productlist/");

      var response = await http.get(url);
     print(response.statusCode);
      if (response.statusCode == 200) {
        
        foods.value = foodModelFromJson(response.body);
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

  return FetchFoodProductResult(
    foods: foods.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
