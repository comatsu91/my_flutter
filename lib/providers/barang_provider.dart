import 'package:flutter/material.dart';

// Provider ini digunakan untuk mengelola data barang baru dan lama secara global menggunakan ChangeNotifier
class BarangProvider with ChangeNotifier {
  // Menyimpan total jumlah barang baru
  int totalBarangBaru = 0;

  // Menyimpan total jumlah barang lama
  int totalBarangLama = 0;

  // Menyimpan daftar data barang baru dalam bentuk List Map
  List<Map<String, String>> _dataBarangBaru = [];

  // Menyimpan daftar data barang lama dalam bentuk List Map
  List<Map<String, String>> _dataBarangLama = [];

  // Getter untuk mengakses data barang baru
  List<Map<String, String>> get dataBarangBaru => _dataBarangBaru;

  // Getter untuk mengakses data barang lama
  List<Map<String, String>> get dataBarangLama => _dataBarangLama;

  // Method untuk memperbarui data barang baru dan jumlah totalnya
  void updateBarangBaru(int total, List<Map<String, String>> data) {
    totalBarangBaru = total;
    _dataBarangBaru = data;
    notifyListeners(); // Memberitahu widget yang mendengarkan untuk rebuild
  }

  // Method untuk memperbarui data barang lama dan jumlah totalnya
  void updateBarangLama(int total, List<Map<String, String>> data) {
    totalBarangLama = total;
    _dataBarangLama = data;
    notifyListeners(); // Memberitahu widget yang mendengarkan untuk rebuild
  }

  // Getter untuk mendapatkan total semua barang (baru + lama)
  int get totalSemuaBarang => totalBarangBaru + totalBarangLama;
}
