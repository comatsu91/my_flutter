import 'package:flutter/material.dart';

class BarangProvider with ChangeNotifier {
  int totalBarangBaru = 0;
  int totalBarangLama = 0;

  List<Map<String, String>> _dataBarangBaru = [];
  List<Map<String, String>> _dataBarangLama = [];

  List<Map<String, String>> get dataBarangBaru => _dataBarangBaru;
  List<Map<String, String>> get dataBarangLama => _dataBarangLama;

  void updateBarangBaru(int total, List<Map<String, String>> data) {
    totalBarangBaru = total;
    _dataBarangBaru = data;
    notifyListeners();
  }

  void updateBarangLama(int total, List<Map<String, String>> data) {
    totalBarangLama = total;
    _dataBarangLama = data;
    notifyListeners();
  }

  int get totalSemuaBarang => totalBarangBaru + totalBarangLama;
}
