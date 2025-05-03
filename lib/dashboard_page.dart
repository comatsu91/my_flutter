import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'data_barang_baru_page.dart';
import 'data_barang_lama_page.dart';
import 'total_barang_page.dart';

// Halaman Dashboard utama
class DashboardPage extends StatelessWidget {
  final String username; // Menerima username dari halaman login
  final String password; // Menerima password dari halaman login

  const DashboardPage({
    required this.username,
    required this.password,
    super.key,
  });

  final Color neonGreen = const Color(0xFF39FF14); // Warna hijau neon
  final Color darkBackground = Colors.black; // Warna latar hitam

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Mengisi lebar penuh
        height: double.infinity, // Mengisi tinggi penuh
        decoration: BoxDecoration(
          // Latar belakang gradasi hitam ke hijau neon
          gradient: LinearGradient(
            colors: [darkBackground, neonGreen],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          // Menghindari area yang tertutup notch/status bar
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Teks sambutan di atas dashboard
              Text(
                'Selamat datang di Dashboard!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: neonGreen,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // Menu menuju halaman profil
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
                              nama: 'Izuddin Arga Eko Sartono',
                              jabatan: 'Tenaga Pendidik',
                              jurusan:
                                  'Teknik Jaringan Komputer dan Telekomunikasi ',
                              email: 'izuddinarga33@gmail.com',
                              username: username,
                              password: password,
                            ),
                      ),
                    ),
              ),

              // Menu menuju halaman Data Barang Baru
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

              // Menu menuju halaman Data Barang Lama
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

              // Menu menuju halaman Total Barang
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

      // AppBar bagian atas halaman dashboard
      appBar: AppBar(
        backgroundColor: darkBackground, // Warna latar AppBar
        title: Text('Dashboard', style: TextStyle(color: neonGreen)),
        iconTheme: IconThemeData(color: neonGreen), // Warna ikon
        actions: [
          // Tombol logout (kembali ke halaman sebelumnya)
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // Widget helper untuk membuat kartu menu dashboard
  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 8, // Efek bayangan
      color: Colors.black.withAlpha(204), // Warna kartu semi transparan
      margin: const EdgeInsets.symmetric(vertical: 10), // Jarak antar kartu
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: neonGreen.withAlpha(25), // Warna latar ikon
          child: Icon(icon, color: neonGreen), // Ikon menu
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
        onTap: onTap, // Aksi saat kartu ditekan
      ),
    );
  }
}
