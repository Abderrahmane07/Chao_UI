import 'package:flutter/material.dart';

class OurFontFamily with ChangeNotifier {
  String _ourFontFamily = 'Neuton';

  String get ourFontFamily => _ourFontFamily;

  // void change(String value) {
  //   _ourFontFamily = value;
  //   notifyListeners();
  // }

  void next() {
    if (_ourFontFamily == 'Neuton') {
      _ourFontFamily = 'Lato';
    } else if (_ourFontFamily == 'Lato') {
      _ourFontFamily = 'OpenSans';
    } else if (_ourFontFamily == 'OpenSans') {
      _ourFontFamily = 'Neuton';
    }

    notifyListeners();
  }

  void previous() {
    if (_ourFontFamily == 'Neuton') {
      _ourFontFamily = 'OpenSans';
    } else if (_ourFontFamily == 'Lato') {
      _ourFontFamily = 'Neuton';
    } else if (_ourFontFamily == 'OpenSans') {
      _ourFontFamily = 'Lato';
    }

    notifyListeners();
  }
}
