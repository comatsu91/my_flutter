import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'data_barang_baru_page.dart';
import 'data_barang_lama_page.dart';
import 'total_barang_page.dart';

class DashboardPage extends StatelessWidget {
  final String username;
  final String password;

  DashboardPage({required this.username, required this.password});

  final Color neonGreen = const Color(0xFF39FF14); // Hijau neon
  final Color darkBackground = Colors.black; // Hitam

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Selamat datang di Dashboard!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: neonGreen,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
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
                              jurusan: 'Teknik Jaringan Komputer dan Telekomunikasi ',
                              email: 'izuddinarga33@gmail.com',
                              username: username,
                              password: password,
                            ),
                      ),
                    ),
              ),
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
      appBar: AppBar(
        backgroundColor: darkBackground,
        title: Text('Dashboard', style: TextStyle(color: neonGreen)),
        iconTheme: IconThemeData(color: neonGreen),
        actions: [
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

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 8,
      color: Colors.black.withOpacity(0.8),
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: neonGreen.withOpacity(0.1),
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
