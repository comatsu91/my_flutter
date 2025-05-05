import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_first_app/login_page.dart';
import 'profile_page.dart';
import 'data_barang_baru_page.dart';
import 'data_barang_lama_page.dart';
import 'total_barang_page.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

// ==========================
// DashboardPage (Main Menu)
// ==========================
class DashboardPage extends StatefulWidget {
  final String username;
  final String password;
  final String nama;
  final String jabatan;
  final String jurusan;
  final String email;

  const DashboardPage({
    super.key,
    required this.username,
    required this.password,
    required this.nama,
    required this.jabatan,
    required this.jurusan,
    required this.email,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // === THEME COLORS ===
  final Color neonGreen = const Color(0xFF39FF14);
  final Color neonBlue = const Color(0xFF00FFFF);
  final Color darkBackground = Colors.black;

  // === PAGE & NAVIGATION ===
  late final PageController _pageController;
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    _pages = [
      ProfilePage(
        nama: widget.nama,
        jabatan: widget.jabatan,
        jurusan: widget.jurusan,
        email: widget.email,
        username: widget.username,
        password: widget.password,
      ),
      const DataBarangBaruPage(),
      const DataBarangLamaPage(),
      const TotalBarangPage(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // === ICON COLOR LOGIC ===
  Color _getIconColor(int index) {
    return _selectedIndex == index
        ? (index.isEven ? neonGreen : neonBlue)
        : Colors.white70;
  }

  // === ICON TAP ACTION ===
  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  // === MAIN UI BUILD ===
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkBackground,
        title: Text('Dashboard', style: TextStyle(color: neonGreen)),
        iconTheme: IconThemeData(color: neonGreen),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: neonBlue),
            onPressed: () {
              final box = GetStorage();
              box.erase(); // Hapus semua data tersimpan
              Get.offAll(const LoginPage());
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: _pages,
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: _pages.length,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.center,
        backgroundColor: darkBackground,
        tabBuilder: (int index, bool isActive) {
          final iconList = [
            Icons.person_outline,
            Icons.add_circle_outline,
            Icons.archive_outlined,
            Icons.view_list_outlined,
          ];
          return Icon(
            iconList[index],
            color: _getIconColor(index),
            size: isActive ? 30 : 24,
          );
        },
        onTap: _onItemTapped,
      ),
    );
  }
}
