import 'package:flutter/material.dart';

class OurFontSize with ChangeNotifier {
  int _ourFontSize = 18;

  int get ourFontSize => _ourFontSize;

  void increment() {
    _ourFontSize++;
    notifyListeners();
  }

  void decrement() {
    _ourFontSize--;

    notifyListeners();
  }
}
