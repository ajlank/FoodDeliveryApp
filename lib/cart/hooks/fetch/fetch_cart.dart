import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodapp/cart/hooks/result/cart_result.dart';
import 'package:foodapp/cart/model/cart_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

CartResult fetchCart() {
  final cart = useState<List<CartModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  String? accessToken = GetStorage().read('accessToken');
  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse("http://192.168.0.103:8000/api/cart/me/");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        cart.value = cartModelFromJson(response.body);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    if (accessToken != null) {
      fetchData();
    }
    return;
  }, const []);

  void refetch() {
    isLoading.value = false;
    fetchData();
  }

  return CartResult(
    cart: cart.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
