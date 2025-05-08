import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();

  var currentTheme = 'neon'.obs;

  final neonGreen = const Color(0xFF39FF14);
  final neonPink = const Color(0xFFFF10F0);
  final neonBlue = const Color(0xFF00E5FF);

  Color primaryColor = const Color(0xFF39FF14);
  Color backgroundColor = Colors.black;
  Color textColor = Colors.white;
  Color cardColor = Colors.black54;

  @override
  void onInit() {
    super.onInit();
    final savedTheme = _box.read('selectedTheme') ?? 'neon';
    applyTheme(savedTheme);
  }

  void setTheme(String theme) {
    _box.write('selectedTheme', theme);
    applyTheme(theme);
  }

  void applyTheme(String theme) {
    currentTheme.value = theme;

    switch (theme) {
      case 'neon':
        primaryColor = neonGreen;
        backgroundColor = Colors.black;
        textColor = Colors.white;
        cardColor = Colors.black.withAlpha(204);
        break;
      case 'dark':
        primaryColor = Colors.blueGrey;
        backgroundColor = Colors.grey[900]!;
        textColor = Colors.white;
        cardColor = Colors.grey[800]!.withAlpha(204);
        break;
      case 'light':
        primaryColor = Colors.blue;
        backgroundColor = Colors.white;
        textColor = Colors.black;
        cardColor = Colors.grey[100]!.withAlpha(204);
        break;
      default:
        primaryColor = neonGreen;
        backgroundColor = Colors.black;
        textColor = Colors.white;
        cardColor = Colors.black.withAlpha(204);
    }

    update(); // Memperbarui tampilan bila menggunakan GetBuilder (opsional)
  }
}
