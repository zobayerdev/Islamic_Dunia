import 'package:flutter/material.dart';

class GenericDi extends ChangeNotifier {
  String? _appVersion;
  String? _buildNo;

  String? get appVersion => _appVersion;
  String? get buildNo => _buildNo;

  set setAppVersion(String version) => _appVersion = version;
  set setBuildNo(String buildNo) => _buildNo = buildNo;
}

class CartCounter extends ChangeNotifier {
  bool showCart = true;

  set setShowCart(int value) {
    if (value == 0) {
      showCart = false;
    } else {
      showCart = true;
    }
    notifyListeners();
  }
}
