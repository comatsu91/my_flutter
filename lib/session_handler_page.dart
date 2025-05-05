import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dashboard_page.dart';
import 'login_page.dart';
import 'splash_page.dart';

// Halaman ini bertanggung jawab untuk mengecek sesi login dan mengarahkan user ke halaman yang sesuai
class SessionHandlerPage extends StatelessWidget {
  const SessionHandlerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi penyimpanan lokal menggunakan GetStorage
    final box = GetStorage();

    // Membaca data yang disimpan pada saat login/register
    final username = box.read('username');
    final password = box.read('password');
    final nama = box.read('nama') ?? '';
    final jabatan = box.read('jabatan') ?? '';
    final jurusan = box.read('jurusan') ?? '';
    final email = box.read('email') ?? '';

    // Menunggu selama 2 detik sebelum mengambil keputusan navigasi
    Future.delayed(const Duration(seconds: 2), () {
      // Jika data username dan password ditemukan, arahkan ke DashboardPage
      if (username != null && password != null) {
        Get.offAll(
          () => DashboardPage(
            username: username,
            password: password,
            nama: nama,
            jabatan: jabatan,
            jurusan: jurusan,
            email: email,
          ),
        );
      } else {
        // Jika tidak ada data login, arahkan ke halaman LoginPage
        Get.offAll(() => const LoginPage());
      }
    });

    // Sambil menunggu 2 detik, tampilkan halaman splash screen
    return const SplashScreen();
  }
}
