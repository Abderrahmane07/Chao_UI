import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tentative_chao_1/prefs/preference.dart';

class ThemeProvider with ChangeNotifier {
  bool _darkTheme = false;
  ThemePreference preference = ThemePreference();

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    preference.setTheme(value);
    notifyListeners();
  }
}
