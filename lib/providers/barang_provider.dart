import 'package:flutter/material.dart';

// Provider ini digunakan untuk mengelola data barang baru dan lama secara global menggunakan ChangeNotifier
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

  // Getter untuk mendapatkan total semua barang (baru + lama)
  int get totalSemuaBarang => totalBarangBaru + totalBarangLama;

  // 🟢 METHOD TAMBAHAN UNTUK EDIT ITEM BARANG BARU
  void updateItemBarangBaru(int index, Map<String, String> newItem) {
    if (index >= 0 && index < _dataBarangBaru.length) {
      _dataBarangBaru[index] = newItem;
      totalBarangBaru = _hitungTotal(_dataBarangBaru);
      notifyListeners();
    }
  }

  // 🔵 METHOD TAMBAHAN UNTUK EDIT ITEM BARANG LAMA
  void updateItemBarangLama(int index, Map<String, String> newItem) {
    if (index >= 0 && index < _dataBarangLama.length) {
      _dataBarangLama[index] = newItem;
      totalBarangLama = _hitungTotal(_dataBarangLama);
      notifyListeners();
    }
  }

  // 🧮 Method bantu menghitung total jumlah barang dari list
  int _hitungTotal(List<Map<String, String>> dataList) {
    int total = 0;
    for (var item in dataList) {
      final jumlah = int.tryParse(item['jumlah'] ?? '0') ?? 0;
      total += jumlah;
    }
    return total;
  }
}
