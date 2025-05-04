import 'package:flutter/material.dart';
import 'package:my_first_app/splash_screan.dart';
import 'package:provider/provider.dart';

// import 'login_page.dart'; // Halaman Login
import 'providers/barang_provider.dart'; // Provider untuk state total barang

import 'package:get/get.dart'; // Penambahan Get
import 'package:get_storage/get_storage.dart'; // penambahan storage

void main() async {
  await GetStorage.init(); // menjalankan get_storage
  // Menjalankan aplikasi Flutter dengan state management menggunakan Provider
  runApp(
    ChangeNotifierProvider(
      create: (context) => BarangProvider(), // Inisialisasi state provider
      child: const MyApp(), // Widget utama aplikasi
    ),
  );
}

// Widget utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Aplikasi Inventaris',
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      theme: ThemeData(
        primarySwatch: Colors.green, // Tema utama aplikasi: hijau
        scaffoldBackgroundColor: Colors.black, // Warna latar belakang umum
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // Default warna teks
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Color(0xFF39FF14)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF39FF14)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF39FF14)),
          ),
        ),
      ),
      home: const SplashScrean(), // Halaman awal: LoginPage
    );
  }
}
