import 'package:flutter/material.dart';

class MainScreenModel extends ChangeNotifier {
  bool isFilterMenuOpen = false;

  void toggleFilterMenu() {
    isFilterMenuOpen = !isFilterMenuOpen;
    notifyListeners();
  }
}
