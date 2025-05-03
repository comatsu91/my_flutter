import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'register_page.dart';

// Halaman Login menggunakan StatefulWidget
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // Controller untuk input username dan password
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variabel untuk mengontrol visibilitas password (default: tersembunyi)
  bool _isPasswordVisible = false;

  // Variabel untuk menyimpan username dan password yang didaftarkan
  String? registeredUsername;
  String? registeredPassword;

  // Fungsi untuk melakukan proses login
  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Login berhasil jika cocok dengan admin default atau akun yang didaftarkan
    if ((username == 'admin' && password == '1234') ||
        (username == registeredUsername && password == registeredPassword)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  DashboardPage(username: username, password: password),
        ),
      );
    } else {
      // Tampilkan pesan error jika login gagal
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Username atau Password salah!')));
    }
  }

  // Fungsi untuk navigasi ke halaman registrasi
  void _register() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => RegisterPage(
              // Callback untuk menyimpan username dan password setelah registrasi
              onRegister: (username, password) {
                setState(() {
                  registeredUsername = username;
                  registeredPassword = password;
                });
                // Tampilkan notifikasi bahwa akun berhasil dibuat
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Akun berhasil dibuat!')),
                );
              },
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Latar belakang dengan gradasi dari hitam ke hijau neon
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF39FF14)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              // Tampilan kartu transparan dengan efek gelap
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
                    // Judul halaman login
                    Text(
                      'Login Inventaris',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF39FF14),
                      ),
                    ),
                    SizedBox(height: 24),
                    // Input untuk username
                    TextField(
                      controller: _usernameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Color(0xFF39FF14)),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF39FF14),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF39FF14)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF39FF14)),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Input untuk password dengan toggle visibilitas
                    TextField(
                      controller: _passwordController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Color(0xFF39FF14)),
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF39FF14)),
                        // Tombol untuk melihat/sembunyikan password
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xFF39FF14),
                          ),
                          onPressed: () {
                            // Toggle visibilitas password
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF39FF14)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF39FF14)),
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                    ),
                    SizedBox(height: 24),
                    // Tombol login
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF39FF14),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    // Tombol navigasi ke halaman registrasi
                    TextButton(
                      onPressed: _register,
                      child: Text(
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
}
