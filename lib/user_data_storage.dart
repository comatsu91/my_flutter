import 'package:get_storage/get_storage.dart';

class UserDataStorage {
  final box = GetStorage();

  Future<void> saveUserData({
    required String username,
    required String password,
    required String nama,
    required String jabatan,
    required String jurusan,
    required String email,
  }) async {
    await box.write('username', username);
    await box.write('password', password);
    await box.write('nama', nama);
    await box.write('jabatan', jabatan);
    await box.write('jurusan', jurusan);
    await box.write('email', email);
  }

  String? getUsername() => box.read('username');
  String? getPassword() => box.read('password');
  String? getNama() => box.read('nama');
  String? getJabatan() => box.read('jabatan');
  String? getJurusan() => box.read('jurusan');
  String? getEmail() => box.read('email');

  Future<void> clearUserData() async {
    await box.erase();
  }
}
