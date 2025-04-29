import 'package:flutter/material.dart';

class BarangProvider with ChangeNotifier {
  int totalBarangBaru = 0;
  int totalBarangLama = 0;

  void updateBarangBaru(int total) {
    totalBarangBaru = total;
    notifyListeners();
  }

  void updateBarangLama(int total) {
    totalBarangLama = total;
    notifyListeners();
  }

  int get totalSemuaBarang => totalBarangBaru + totalBarangLama;
}


