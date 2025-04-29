// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart'; // Halaman Login
import 'providers/barang_provider.dart'; // Provider untuk total barang

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BarangProvider(),
      child: MyApp(),
    ),
  );
}

// Root aplikasi
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Login',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(), // Tetap arahkan ke halaman login
    );
  }
}
