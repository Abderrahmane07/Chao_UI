import 'package:flutter/material.dart';

class OurTheme with ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  void change(bool value) {
    _isDark = value;
    notifyListeners();
  }
}
