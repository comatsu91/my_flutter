import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function(String username, String password) onRegister;

  const RegisterPage({required this.onRegister, super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jabatanController = TextEditingController();
  final TextEditingController _jurusanController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Color neonGreen = const Color(0xFF39FF14); // hijau neon terang

  void _register() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (_nameController.text.isNotEmpty &&
        _jabatanController.text.isNotEmpty &&
        _jurusanController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
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

  Widget buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: neonGreen),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: neonGreen),
        prefixIcon: Icon(icon, color: neonGreen),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: neonGreen),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: neonGreen),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
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
              color: Colors.black.withAlpha(178),
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
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
                  buildTextField(
                    label: 'Nama Lengkap',
                    icon: Icons.person,
                    controller: _nameController,
                  ),
                  SizedBox(height: 16),
                  buildTextField(
                    label: 'Jabatan',
                    icon: Icons.work,
                    controller: _jabatanController,
                  ),
                  SizedBox(height: 16),
                  buildTextField(
                    label: 'Jurusan',
                    icon: Icons.school,
                    controller: _jurusanController,
                  ),
                  SizedBox(height: 16),
                  buildTextField(
                    label: 'Email',
                    icon: Icons.email,
                    controller: _emailController,
                  ),
                  SizedBox(height: 16),
                  buildTextField(
                    label: 'Username',
                    icon: Icons.account_circle,
                    controller: _usernameController,
                  ),
                  SizedBox(height: 16),
                  buildTextField(
                    label: 'Password',
                    icon: Icons.lock,
                    controller: _passwordController,
                    obscure: true,
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
      ),
    );
  }
}
