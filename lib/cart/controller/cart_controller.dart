import 'package:flutter/material.dart';
import 'package:foodapp/homeproductList/controller/menu_item_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  Function()? refetchCount;
  void setRefetchCount(Function() r) {
    refetchCount = r;
  }

  var _qty = 0.obs;

  int get qty => _qty.value;

  void increment() {
    _qty++;
  }

  void decrement() {
    if (_qty.value > 1) {
      _qty--;
    }
  }

  final RxnInt _selectedCart = RxnInt();

  int? get selectedCart => _selectedCart.value;
  void setSelectedCounter(int id, int q) {
    _selectedCart.value = id;
    _qty.value = q;
  }

  void clearSelected() {
    _selectedCart.value = null;
    _qty.value = 0;
  }

  Future<void> deleteCart(int id, void Function() refetch) async {
    String accessToken = GetStorage().read('accessToken');
    try {
      Uri url = Uri.parse("http://192.168.0.103:8000/api/cart/delete/?id=$id");

      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 204) {
        refetch();
        clearSelected();
      }
    } catch (e) {}
  }

  Future<void> updateCart(int id, void Function() refetch) async {
    String? accessToken = GetStorage().read('accessToken');
    try {
      Uri url = Uri.parse(
        "http://192.168.0.103:8000/api/cart/update/?id=$id&count=$qty",
      );
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        refetch();
        clearSelected();
      }
    } catch (e) {}
  }

  Future<void> add(String data, BuildContext ctx, MenuItemController m) async {
    String accessToken = GetStorage().read('accessToken');
    try {
      Uri url = Uri.parse("http://192.168.0.103:8000/api/cart/add/");

      final response = await http.post(
        url,
        body: data,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 201) {
        refetchCount!();

        m.setSize('');

        Navigator.of(ctx).pop();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
