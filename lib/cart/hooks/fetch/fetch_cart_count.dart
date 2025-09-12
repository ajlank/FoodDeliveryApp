import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodapp/cart/controller/cart_controller.dart';
import 'package:foodapp/cart/hooks/result/cart_count_result.dart';
import 'package:foodapp/cart/model/cart_count_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

CartCountResult fetchCartCount() {
  final cartCount = useState<CartCountModel>(CartCountModel(cartCount: 1));
  final isLoading = useState(false);
  final error = useState<String?>(null);
  CartController ct = Get.put(CartController());
  String? accessToken = GetStorage().read("accessToken");

  Future<void> fetchCartCount() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse("http://192.168.0.103:8000/api/cart/count");

      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        cartCount.value = cartCountFromJson(response.body);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void refetch() {
    isLoading.value = false;
    fetchCartCount();
  }

  ct.setRefetchCount(refetch);
  useEffect(() {
    fetchCartCount();
    return null;
  }, []);

  return CartCountResult(
    cartCount: cartCount.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
