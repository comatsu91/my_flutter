import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

import 'package:my_first_app/theme_controller.dart'; // pastikan path sesuai

class ProfilePage extends StatelessWidget {
  final String nama;
  final String jabatan;
  final String jurusan;
  final String email;
  final String username;
  final String password;

  ProfilePage({
    super.key,
    required this.nama,
    required this.jabatan,
    required this.jurusan,
    required this.email,
    required this.username,
    required this.password,
  });

  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final primaryColor = themeController.primaryColor;
      final backgroundColor = themeController.backgroundColor;
      final textColor = themeController.textColor;
      final cardColor = themeController.cardColor;

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: backgroundColor,
          title: Text('Profile', style: TextStyle(color: primaryColor)),
          iconTheme: IconThemeData(color: primaryColor),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [backgroundColor, primaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withAlpha(76),
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              'Data Profile',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                shadows: themeController.currentTheme.value == 'neon'
                                    ? [
                                        Shadow(
                                          blurRadius: 10,
                                          color: primaryColor,
                                          offset: Offset(0, 0),
                                        ),
                                      ]
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        PopupMenuButton<String>(
                          icon: Icon(Icons.palette, color: primaryColor),
                          onSelected: (value) {
                            themeController.setTheme(value);
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(value: 'neon', child: Text('Neon Theme')),
                            PopupMenuItem(value: 'dark', child: Text('Dark Theme')),
                            PopupMenuItem(value: 'light', child: Text('Light Theme')),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildProfileItem('Nama', nama, textColor, primaryColor),
                    _buildProfileItem('Jabatan', jabatan, textColor, primaryColor),
                    _buildProfileItem('Jurusan', jurusan, textColor, primaryColor),
                    _buildProfileItem('Email', email, textColor, primaryColor),
                    Divider(color: primaryColor.withAlpha(127), height: 30),
                    _buildProfileItem('Username', username, textColor, primaryColor),
                    _buildProfileItem('Password', '••••••••', textColor, primaryColor),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildProfileItem(String label, String value, Color textColor, Color labelColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: labelColor.withAlpha(204),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 18, color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
