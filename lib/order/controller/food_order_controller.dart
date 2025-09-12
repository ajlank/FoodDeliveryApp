import 'package:get/get.dart';

class FoodOrderController extends GetxController{

  var orderId = 0.obs; 

  void setOrderId(int id) {
    orderId.value = id;
  }

  int get orderIdValue => orderId.value; 
   

}