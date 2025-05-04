import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_first_app/login_page.dart';
import 'profile_page.dart'; // Halaman profil
import 'data_barang_baru_page.dart'; // Halaman Data Barang Baru
import 'data_barang_lama_page.dart'; // Halaman Data Barang Lama
import 'total_barang_page.dart'; // Halaman Total Barang

// Halaman Dashboard utama
class DashboardPage extends StatelessWidget {
  final String username; // Menerima username dari login
  final String password; // Menerima password dari login
  final String nama; // Nama dari hasil register/login
  final String jabatan; // Jabatan pengguna
  final String jurusan; // Jurusan pengguna
  final String email; // Email pengguna

  const DashboardPage({
    super.key,
    required this.username,
    required this.password,
    required this.nama,
    required this.jabatan,
    required this.jurusan,
    required this.email,
  });

  final Color neonGreen = const Color(0xFF39FF14); // Warna hijau neon
  final Color darkBackground = Colors.black; // Warna latar hitam

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBackground,
        title: Text('Dashboard', style: TextStyle(color: neonGreen)),
        iconTheme: IconThemeData(color: neonGreen),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Navigator.pop(context); // Logout ke halaman sebelumnya
              final box = GetStorage();
              box.remove('username');
              box.remove('password');
              box.remove('email');
              box.remove('jurusan');
              box.remove('jabatan');
              box.remove('nama');

              Get.offAll(LoginPage());
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [darkBackground, neonGreen],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Daftar Inventaris',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: neonGreen,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Menu ke halaman profil
              _buildMenuCard(
                context,
                icon: Icons.person_outline,
                title: 'Profile',
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => ProfilePage(
                              nama: nama,
                              jabatan: jabatan,
                              jurusan: jurusan,
                              email: email,
                              username: username,
                              password: password,
                            ),
                      ),
                    ),
              ),

              // Menu ke halaman Data Barang Baru
              _buildMenuCard(
                context,
                icon: Icons.add_circle_outline,
                title: 'Data Barang Baru',
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DataBarangBaruPage()),
                    ),
              ),

              // Menu ke halaman Data Barang Lama
              _buildMenuCard(
                context,
                icon: Icons.archive_outlined,
                title: 'Data Barang Lama',
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DataBarangLamaPage()),
                    ),
              ),

              // Menu ke halaman Total Barang
              _buildMenuCard(
                context,
                icon: Icons.view_list_outlined,
                title: 'Total Barang yang Ada',
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TotalBarangPage()),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pembentuk menu di dashboard
  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 8,
      color: Colors.black.withAlpha(204),
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        leading: CircleAvatar(
          backgroundColor: neonGreen.withAlpha(25),
          child: Icon(icon, color: neonGreen),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: neonGreen,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: neonGreen, size: 16),
        onTap: onTap,
      ),
    );
  }
}
