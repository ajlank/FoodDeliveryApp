import 'package:foodapp/homeproductList/model/food_list_model.dart';
import 'package:get/get.dart';

class MenuItemController extends GetxController {
 final Rx<FoodListModel?> _selectedFood = Rx<FoodListModel?>(null);
  FoodListModel? get selectedFood => _selectedFood.value;

  final RxString _size = ''.obs;
  String get size => _size.value;

  void setSize(String s) {
    _size.value = s;
  }

  void setFood(FoodListModel food) {
    _selectedFood.value = food;
  }

  void clearFood() {
    _selectedFood.value = null;
  }
}
