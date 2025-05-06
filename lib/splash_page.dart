import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_first_app/dashboard_page.dart';
import 'package:my_first_app/login_page.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    navigateAfterDelay();
  }

  void navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));

    final userData = {
      'username': box.read('username') ?? '',
      'password': box.read('password') ?? '',
      'email': box.read('email') ?? '',
      'jurusan': box.read('jurusan') ?? '',
      'jabatan': box.read('jabatan') ?? '',
      'nama': box.read('nama') ?? '',
    };

    if (userData['username']!.isNotEmpty) {
      Get.off(
        () => DashboardPage(
          username: userData['username']!,
          password: userData['password']!,
          email: userData['email']!,
          jurusan: userData['jurusan']!,
          jabatan: userData['jabatan']!,
          nama: userData['nama']!,
        ),
      );
    } else {
      Get.off(() => const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth * 0.8;

    return Scaffold(
      body: Column(
        children: [
          // Teks di bagian paling atas
          SizedBox(height: 50), // Mengganti Container dengan SizedBox
          Center(
            child: Text(
              'SMK S SAKTI Gemolong',
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent[400],
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.greenAccent,
                    offset: const Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ),
          // Konten utama di tengah
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // Menggunakan SizedBox untuk container gambar
                      width: imageSize,
                      height: imageSize,
                      child: Image.asset(
                        'assets/smks.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.school,
                            size: imageSize * 0.6,
                            color: Colors.blue,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
