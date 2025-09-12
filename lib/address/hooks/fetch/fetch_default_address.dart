import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodapp/address/hooks/result/default_address_result.dart';
import 'package:foodapp/address/model/address_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

DefaultAddressResult fetchDefaultAddress() {
  final address = useState<AddressModel?>(null);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  String? accessToken = GetStorage().read('accessToken');

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse("http://192.168.0.103:8000/api/address/me/");
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        address.value = addressDefaultFromJson(response.body);
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
    return null;
  }, const []);
  void refetch() {
    isLoading.value = false;
    fetchData();
  }

  return DefaultAddressResult(
    address: address.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
