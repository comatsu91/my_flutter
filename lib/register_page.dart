import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function(String username, String password) onRegister;

  RegisterPage({required this.onRegister});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Color neonGreen = const Color(0xFF39FF14); // hijau neon terang

  void _register() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (_nameController.text.isNotEmpty &&
        username.isNotEmpty &&
        password.isNotEmpty) {
      widget.onRegister(username, password);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Semua field harus diisi!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, neonGreen],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(24),
            margin: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Buat Akun',
                  style: TextStyle(
                    color: neonGreen,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                TextField(
                  controller: _nameController,
                  style: TextStyle(color: neonGreen),
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    labelStyle: TextStyle(color: neonGreen),
                    prefixIcon: Icon(Icons.person, color: neonGreen),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: neonGreen),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: neonGreen),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _usernameController,
                  style: TextStyle(color: neonGreen),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: neonGreen),
                    prefixIcon: Icon(Icons.account_circle, color: neonGreen),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: neonGreen),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: neonGreen),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: TextStyle(color: neonGreen),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: neonGreen),
                    prefixIcon: Icon(Icons.lock, color: neonGreen),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: neonGreen),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: neonGreen),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: neonGreen,
                    foregroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('Daftar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
