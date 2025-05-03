// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart'; // Halaman Login
import 'providers/barang_provider.dart'; // Provider untuk total barang

void main() {
  // Menjalankan aplikasi Flutter dengan provider BarangProvider
  runApp(
    ChangeNotifierProvider(
      // Inisialisasi BarangProvider sebagai state management
      create: (context) => BarangProvider(),
      child: MyApp(), // Widget root aplikasi
    ),
  );
}

// Root aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Login', // Judul aplikasi
      theme: ThemeData(primarySwatch: Colors.green), // Tema utama aplikasi
      home: LoginPage(), // Halaman pertama yang ditampilkan adalah LoginPage
    );
  }
}
