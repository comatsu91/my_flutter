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
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      final box = GetStorage();
      String username = box.read('username') ?? '';
      String password = box.read('password') ?? '';
      String email = box.read('email') ?? '';
      String jurusan = box.read('jurusan') ?? '';
      String jabatan = box.read('jabatan') ?? '';
      String nama = box.read('nama') ?? '';

      if (username.isNotEmpty) {
        Get.off(() => DashboardPage(
              username: username,
              password: password,
              email: email,
              jurusan: jurusan,
              jabatan: jabatan,
              nama: nama,
            ));
      } else {
        Get.off(() => const LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'SMK S SAKTI Gemolong',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
