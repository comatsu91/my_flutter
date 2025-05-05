import 'package:flutter/material.dart';
// import 'package:my_first_app/splash_page.dart';
import 'package:provider/provider.dart';
import 'providers/barang_provider.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// import 'dashboard_page.dart';
// import 'login_page.dart';
import 'session_handler_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Inisialisasi GetStorage

  runApp(
    ChangeNotifierProvider(
      create: (context) => BarangProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Aplikasi Inventaris',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
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
      home: const SessionHandlerPage(), // Ganti SplashScrean dengan handler
    );
  }
}
