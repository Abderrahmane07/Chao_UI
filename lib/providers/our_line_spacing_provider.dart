import 'package:flutter/material.dart';

class OurLineSpacing with ChangeNotifier {
  double _ourLineSpacing = 1;
  List<bool> _ourLineList = [false, true, false];

  double get ourLineSpacing => _ourLineSpacing;
  List<bool> get ourLineList => _ourLineList;

  void change(List<bool> values) {
    if (values[0] == true) {
      _ourLineList = [true, false, false];
      _ourLineSpacing = 1;
    } else if (values[1] == true) {
      _ourLineSpacing = 1.2;
      _ourLineList = [false, true, false];
    } else if (values[2] == true) {
      _ourLineSpacing = 1.5;
      _ourLineList = [false, false, true];
    } else {
      _ourLineSpacing = 1;
      _ourLineList = [false, true, false];
    }

    notifyListeners();
  }
}
