import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodapp/wishlist/hooks/result/wishlist_result.dart';
import 'package:foodapp/wishlist/model/wish_list_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

WishlistResult fetchWishList() {
  final wishList = useState<List<WishListModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      // # http://192.168.0.106:8000/api/wishlist/toggle/
      // # http://192.168.0.106:8000/api/wishlist/me/
      Uri url = Uri.parse("http://192.168.0.103:8000/api/wishlist/me/");
      String? accessToken = GetStorage().read('accessToken');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        wishList.value = wishListModelFromJson(response.body);
      }
    } catch (e) {
      error.value = e.toString();
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, const []);

  void refetch() {
    isLoading.value = false;
    fetchData();
  }

  return WishlistResult(
    foods: wishList.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
