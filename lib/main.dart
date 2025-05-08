import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/barang_provider.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'session_handler_page.dart';
import 'package:my_first_app/theme_controller.dart'; // <--- Tambahkan ini

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Inisialisasi ThemeController global
  Get.put(ThemeController());

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
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      return GetMaterialApp(
        title: 'Aplikasi Inventaris',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: _getPrimarySwatch(themeController.currentTheme.value),
          scaffoldBackgroundColor: themeController.backgroundColor,
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: themeController.textColor),
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: themeController.primaryColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: themeController.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: themeController.primaryColor),
            ),
          ),
        ),
        home: const SessionHandlerPage(),
      );
    });
  }

  MaterialColor _getPrimarySwatch(String theme) {
    switch (theme) {
      case 'dark':
        return Colors.blueGrey;
      case 'light':
        return Colors.blue;
      default:
        return Colors.green; // neon
    }
  }
}
