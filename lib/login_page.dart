import 'package:flutter/material.dart';
import 'register_page.dart';
import 'dashboard_page.dart';
import 'models/user_data.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // Menyimpan data pengguna yang terdaftar
  UserData? registeredUser;

  // Callback saat selesai registrasi
  void _onRegister(
    String username,
    String password,
    String nama,
    String email,
    String jabatan,
    String jurusan,
  ) {
    setState(() {
      registeredUser = UserData(
        nama: nama,
        jabatan: jabatan,
        jurusan: jurusan,
        email: email,
        username: username,
        password: password,
      );
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Akun berhasil dibuat!')));
  }

  // Fungsi login
  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    final box = GetStorage();
    box.write('username', username);

    if (registeredUser != null &&
        username == registeredUser!.username &&
        password == registeredUser!.password) {
      Get.to(
        () => DashboardPage(
          username: registeredUser!.username,
          password: registeredUser!.password,
          nama: registeredUser!.nama,
          jabatan: registeredUser!.jabatan,
          jurusan: registeredUser!.jurusan,
          email: registeredUser!.email,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username atau Password salah!')),
      );
    }
  }

  // Navigasi ke halaman registrasi
  void _register() {
    Get.to(() => RegisterPage(onRegister: _onRegister));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2C3E50), Color(0xFF39FF14)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              color: Colors.black.withAlpha(178),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Login Inventaris',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF39FF14),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildTextField(
                      controller: _usernameController,
                      label: 'Username',
                      icon: Icons.person,
                      obscureText: false,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Password',
                      icon: Icons.lock,
                      obscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xFF39FF14),
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF39FF14),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: _register,
                      child: const Text(
                        'Buat Akun',
                        style: TextStyle(color: Color(0xFF39FF14)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk membangun textfield secara modular
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool obscureText,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF39FF14)),
        prefixIcon: Icon(icon, color: Color(0xFF39FF14)),
        suffixIcon: suffixIcon,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF39FF14)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF39FF14)),
        ),
      ),
    );
  }
}
