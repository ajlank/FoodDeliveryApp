import 'package:get/get.dart';

class HomeViewController extends GetxController {
  final _currentIndex = 0.obs;

  set setCurrentIndex(int i) {
    _currentIndex.value = i;
  }

  int get getCurrentIndex => _currentIndex.value;
}
