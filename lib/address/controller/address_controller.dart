import 'package:flutter/material.dart';
import 'package:foodapp/address/model/address_model.dart';
import 'package:foodapp/utils/ApiError/api_error.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class AddressController extends GetxController {
  var address = Rxn<AddressModel>(); // 👈 reactive nullable

  void setAddress(AddressModel newAddress) {
    address.value = newAddress;
  }

  Function refetchA = () {};

  void setRefetch(Function r) {
    refetchA = r;
  }

  void clearAddress() {
    address.value = null;
  }

  List<String> addressTypes = ['Home', 'School', 'Office'];
  String _addressType = '';

  void setAddressType(String type) {
    _addressType = type;
  }

  String get addressType => _addressType;

  void clearAddressTyoe() {
    _addressType = '';
  }

  bool _defaultToggle = false;

  void setDefaultToggle(bool d) {
    _defaultToggle = d;
  }

  bool get defaultToggle => _defaultToggle;

  void clearDefaultToggle() {
    _defaultToggle = false;
  }

  void setAsDefault(int id, Function refetch) async {
    String accessToken = GetStorage().read('accessToken');
    try {
      Uri url = Uri.parse(
        "http://192.168.0.103:8000/api/address/default/?id=$id",
      );

      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201) {
        refetch();
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        final data = apiErrorFromJson(response.body);
        // showErrorPopup(context, errorMessage, title, removeCancel)
        print('error $data');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void addAddress(String data, BuildContext context) async {
    String accessToken = GetStorage().read('accessToken');
    try {
      Uri url = Uri.parse("http://192.168.0.103:8000/api/address/add/");

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        refetchA();
       context.pop();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteAddress(int id, Function refetch) async {
    String accessToken = GetStorage().read('accessToken');
    try {
      Uri url = Uri.parse(
        "http://192.168.0.103:8000/api/address/delete/?id=$id",
      );

      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        refetch();
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        final data = apiErrorFromJson(response.body);
        print('error $data');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
