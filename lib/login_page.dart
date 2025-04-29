import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Tambahkan variabel untuk mengontrol visibilitas password
  bool _isPasswordVisible = false;

  String? registeredUsername;
  String? registeredPassword;

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Username atau Password salah!')));
    }
  }

  void _register() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => RegisterPage(
              onRegister: (username, password) {
                setState(() {
                  registeredUsername = username;
                  registeredPassword = password;
                });
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF39FF14)], // Hitam ke Hijau Neon
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              color: Colors.black.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Login Inventaris',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF39FF14),
                      ),
                    ),
                    SizedBox(height: 24),
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
                    TextField(
                      controller: _passwordController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Color(0xFF39FF14)),
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF39FF14)),
                        // Tambahkan suffix icon untuk toggle visibilitas password
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xFF39FF14),
                          ),
                          onPressed: () {
                            // Update state untuk toggle visibilitas password
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
                      // Gunakan variabel _isPasswordVisible untuk mengontrol obscureText
                      obscureText: !_isPasswordVisible,
                    ),
                    SizedBox(height: 24),
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
