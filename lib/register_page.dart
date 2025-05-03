import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  // Callback untuk mengirim data lengkap ke halaman lain (misalnya LoginPage)
  final Function(
    String username,
    String password,
    String nama,
    String email,
    String jabatan,
    String jurusan,
  )
  onRegister;

  const RegisterPage({required this.onRegister, super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  // Controller untuk input pengguna
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jabatanController = TextEditingController();
  final TextEditingController _jurusanController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Color neonGreen = const Color(0xFF39FF14); // Warna hijau neon
  bool _isPasswordHidden = true; // Variabel untuk menyimpan status password

  // Fungsi untuk memproses pendaftaran akun
  void _register() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String nama = _nameController.text;
    String email = _emailController.text;
    String jabatan = _jabatanController.text;
    String jurusan = _jurusanController.text;

    if (nama.isNotEmpty &&
        jabatan.isNotEmpty &&
        jurusan.isNotEmpty &&
        email.isNotEmpty &&
        username.isNotEmpty &&
        password.isNotEmpty) {
      // Kirim data lengkap ke halaman lain
      widget.onRegister(username, password, nama, email, jabatan, jurusan);
      Navigator.pop(context); // Kembali ke halaman login
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Semua field harus diisi!')));
    }
  }

  // Widget untuk input teks dengan desain konsisten
  Widget buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool obscure = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: neonGreen),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: neonGreen),
        prefixIcon: Icon(icon, color: neonGreen),
        suffixIcon: suffixIcon,
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
        // Background gradasi dari hitam ke hijau neon
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, neonGreen],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            // Kartu transparan dengan border radius
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
                  const SizedBox(height: 24),
                  // Input nama lengkap
                  buildTextField(
                    label: 'Nama Lengkap',
                    icon: Icons.person,
                    controller: _nameController,
                  ),
                  const SizedBox(height: 16),
                  // Input jabatan
                  buildTextField(
                    label: 'Jabatan',
                    icon: Icons.work,
                    controller: _jabatanController,
                  ),
                  const SizedBox(height: 16),
                  // Input jurusan
                  buildTextField(
                    label: 'Jurusan',
                    icon: Icons.school,
                    controller: _jurusanController,
                  ),
                  const SizedBox(height: 16),
                  // Input email
                  buildTextField(
                    label: 'Email',
                    icon: Icons.email,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16),
                  // Input username
                  buildTextField(
                    label: 'Username',
                    icon: Icons.account_circle,
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 16),
                  // Input password dengan fitur hide/show
                  buildTextField(
                    label: 'Password',
                    icon: Icons.lock,
                    controller: _passwordController,
                    obscure: _isPasswordHidden,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: neonGreen,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordHidden =
                              !_isPasswordHidden; // Toggle hide/show
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Tombol daftar
                  ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: neonGreen,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Daftar'),
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
