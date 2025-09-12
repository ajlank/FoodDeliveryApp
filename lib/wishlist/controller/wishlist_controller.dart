import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class WishlistController extends GetxController {
  var wishList = <int>[].obs;
  var error = RxnString();

  Future<void> removeOrAddWishList(int id, Function refetch) async {
    try {
      Uri url = Uri.parse(
        "http://192.168.0.103:8000/api/wishlist/toggle/?id=$id",
      );
      final accessToken = GetStorage().read('accessToken');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201 || response.statusCode == 204) {
        toggleLocal(id);
        refetch();
      }
    } catch (e) {
      error.value = e.toString();
    }
  }

  void toggleLocal(int id) {
    final storage = GetStorage();
    final accessToken = storage.read('accessToken');
    final key = '${accessToken}wishlist';

    List<int> w = (storage.read(key) != null)
        ? List<int>.from(jsonDecode(storage.read(key)))
        : [];

    if (w.contains(id)) {
      w.remove(id);
    } else {
      w.add(id);
    }

    wishList.assignAll(w);
    storage.write(key, jsonEncode(w));
  }
}
