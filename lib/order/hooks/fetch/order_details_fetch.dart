import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodapp/order/hooks/result/order_result.dart';
import 'package:foodapp/order/model/order_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

OrderResult fetchOrderDetails({String status = "pending"}) {
  final orders = useState<List<OrderModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  String? accessToken = GetStorage().read('accessToken');

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse(
        "http://192.168.0.103:8000/api/orders/me/?status=$status",
      );
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

     
      if (response.statusCode == 200) {
      //  print(response.body);  
        orders.value = orderModelFromJson(response.body);
      
      } else {
        error.value = 'Error: ${response.statusCode}';
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
    fetchData();
  }

  return OrderResult(
  order: orders.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
