import 'package:flutter/widgets.dart';

class HomeViewNotifier with ChangeNotifier {
  int _currentIndex = 0;

  set setCurrentIndex(int i) {
    _currentIndex = i;
    notifyListeners();
  }

  int get getCurrentIndex => _currentIndex;
}
