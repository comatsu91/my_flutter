import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String nama;
  final String jabatan;
  final String jurusan;
  final String email;
  final String username;
  final String password;

  const ProfilePage({
    required this.nama,
    required this.jabatan,
    required this.jurusan,
    required this.email,
    required this.username,
    required this.password,
    super.key,
  });

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  // Warna untuk tema neon
  final Color neonGreen = const Color(0xFF39FF14);
  final Color neonPink = const Color(0xFFFF10F0);
  final Color neonBlue = const Color(0xFF00E5FF);

  // Variabel untuk tema saat ini
  String currentTheme = 'neon'; // Bisa: 'neon', 'dark', atau 'light'
  Color primaryColor = const Color(
    0xFF39FF14,
  ); // Warna utama (default neon green)
  Color backgroundColor = Colors.black; // Warna latar belakang
  Color textColor = Colors.white; // Warna teks
  Color cardColor = Colors.black.withAlpha(204); // Warna kartu profil

  // Variabel untuk visibilitas password
  bool isPasswordVisible = false;

  // Fungsi untuk mengganti tema
  void changeTheme(String theme) {
    setState(() {
      currentTheme = theme;
      if (theme == 'neon') {
        primaryColor = neonGreen;
        backgroundColor = Colors.black;
        textColor = Colors.white;
        cardColor = Colors.black.withAlpha(204);
      } else if (theme == 'dark') {
        primaryColor = Colors.blueGrey;
        backgroundColor = Colors.grey[900]!;
        textColor = Colors.white;
        cardColor = Colors.grey[800]!.withAlpha(204);
      } else if (theme == 'light') {
        primaryColor = Colors.blue;
        backgroundColor = Colors.white;
        textColor = Colors.black;
        cardColor = Colors.grey[100]!.withAlpha(204);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [backgroundColor, primaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withAlpha(76),
                    blurRadius: 15,
                    spreadRadius: 2,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header judul dan ikon pemilih tema
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'Data Profile',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              shadows:
                                  currentTheme == 'neon'
                                      ? [
                                        Shadow(
                                          blurRadius: 10,
                                          color: primaryColor,
                                          offset: Offset(0, 0),
                                        ),
                                      ]
                                      : null,
                            ),
                          ),
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.palette, color: primaryColor),
                        onSelected: changeTheme,
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              value: 'neon',
                              child: Text('Neon Theme'),
                            ),
                            PopupMenuItem(
                              value: 'dark',
                              child: Text('Dark Theme'),
                            ),
                            PopupMenuItem(
                              value: 'light',
                              child: Text('Light Theme'),
                            ),
                          ];
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Menampilkan data utama profil
                  _buildProfileItem('Nama', widget.nama),
                  _buildProfileItem('Jabatan', widget.jabatan),
                  _buildProfileItem('Jurusan', widget.jurusan),
                  _buildProfileItem('Email', widget.email),

                  Divider(color: primaryColor.withAlpha(127), height: 30),

                  // Menampilkan data tambahan
                  _buildProfileItemSmall('Username', widget.username),
                  _buildProfileItemSmall('Password', widget.password),
                ],
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false, // menghilangkan tombol back
        backgroundColor: backgroundColor,
        title: Text('Profile', style: TextStyle(color: primaryColor)),
        iconTheme: IconThemeData(color: primaryColor),
      ),
    );
  }

  // Widget untuk menampilkan item profil utama (huruf besar)
  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: primaryColor.withAlpha(204),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 18, color: textColor),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan item profil kecil (username & password)
  Widget _buildProfileItemSmall(String label, String value) {
    bool isPasswordField = label.toLowerCase() == 'password';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor.withAlpha(153),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    isPasswordField && !isPasswordVisible ? '••••••••' : value,
                    style: TextStyle(
                      fontSize: 14,
                      color: textColor.withAlpha(204),
                    ),
                  ),
                ),
                if (isPasswordField)
                  IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: primaryColor.withAlpha(180),
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
