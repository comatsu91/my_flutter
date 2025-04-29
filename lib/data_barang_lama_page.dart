import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/barang_provider.dart'; // Pastikan path ini sesuai

class DataBarangLamaPage extends StatefulWidget {
  @override
  _DataBarangLamaPageState createState() => _DataBarangLamaPageState();
}

class _DataBarangLamaPageState extends State<DataBarangLamaPage> {
  List<Map<String, TextEditingController>> barangControllers = [];
  int totalJumlah = 0;

  final Color neonGreen = const Color(0xFF39FF14);
  final Color darkBackground = Colors.black;

  void _addRow() {
    setState(() {
      barangControllers.add({
        'no': TextEditingController(),
        'nama': TextEditingController(),
        'jumlah': TextEditingController(),
        'kondisi': TextEditingController(),
        'keterangan': TextEditingController(),
      });
    });
  }

  void _removeRow() {
    if (barangControllers.isNotEmpty) {
      setState(() {
        barangControllers.removeLast();
      });
      _calculateTotalJumlah(); // Update totalJumlah setelah menghapus baris
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Tidak ada baris untuk dihapus.')));
    }
  }

  void _calculateTotalJumlah() {
    int total = 0;
    for (var row in barangControllers) {
      final jumlahText = row['jumlah']!.text;
      if (jumlahText.isNotEmpty && int.tryParse(jumlahText) != null) {
        total += int.parse(jumlahText);
      }
    }
    setState(() {
      totalJumlah = total;
    });
  }

  void _saveData() {
    bool isValid = true;
    String message = '';
    for (int i = 0; i < barangControllers.length; i++) {
      var row = barangControllers[i];
      for (var entry in row.entries) {
        if (entry.value.text.isEmpty) {
          isValid = false;
          message = 'Semua kolom harus diisi (Baris ${i + 1})';
          break;
        }
      }
      if (isValid && int.tryParse(row['jumlah']!.text) == null) {
        isValid = false;
        message = 'Jumlah harus berupa angka (Baris ${i + 1})';
        break;
      }
    }

    if (isValid) {
      _calculateTotalJumlah();
      Provider.of<BarangProvider>(
        context,
        listen: false,
      ).updateBarangLama(totalJumlah);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Data berhasil disimpan!')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  void initState() {
    super.initState();
    _addRow(); // Tambahkan satu baris awal saat pertama kali dibuka
  }

  @override
  void dispose() {
    for (var row in barangControllers) {
      row.forEach((_, controller) => controller.dispose());
    }
    super.dispose();
  }

  Widget _buildTable() {
    return Table(
      border: TableBorder.all(color: neonGreen),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(3),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        _buildTableHeader(),
        ...barangControllers.map((row) => _buildTableRow(row)).toList(),
      ],
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: darkBackground),
      children: [
        _buildHeaderCell('No.'),
        _buildHeaderCell('Nama Barang'),
        _buildHeaderCell('Jumlah'),
        _buildHeaderCell('Kondisi'),
        _buildHeaderCell('Keterangan'),
      ],
    );
  }

  TableRow _buildTableRow(Map<String, TextEditingController> row) {
    return TableRow(
      children: [
        _buildTableInput(row['no']!),
        _buildTableInput(row['nama']!),
        _buildTableInput(row['jumlah']!),
        _buildTableInput(row['kondisi']!),
        _buildTableInput(row['keterangan']!),
      ],
    );
  }

  Widget _buildHeaderCell(String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, color: neonGreen),
        ),
      ),
    );
  }

  Widget _buildTableInput(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextField(
        controller: controller,
        style: TextStyle(color: neonGreen),
        cursorColor: neonGreen,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          hintStyle: TextStyle(color: neonGreen.withOpacity(0.5)),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildTotalRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Total Jumlah Barang: $totalJumlah',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: neonGreen,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        title: Text('Data Barang Lama'),
        backgroundColor: Colors.black,
        foregroundColor: neonGreen,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: _buildTable(),
            ),
          ),
          _buildTotalRow(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: neonGreen,
                  foregroundColor: Colors.black,
                ),
                onPressed: _addRow,
                child: Text('Tambah'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: neonGreen,
                  foregroundColor: Colors.black,
                ),
                onPressed: _removeRow,
                child: Text('Hapus'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: neonGreen,
                  foregroundColor: Colors.black,
                ),
                onPressed: _saveData,
                child: Text('Simpan'),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
