import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/barang_provider.dart';

class DataBarangBaruPage extends StatefulWidget {
  @override
  _DataBarangBaruPageState createState() => _DataBarangBaruPageState();
}

class _DataBarangBaruPageState extends State<DataBarangBaruPage> {
  List<Map<String, TextEditingController>> barangControllers = [];
  int totalJumlah = 0;

  final Color backgroundColor = Colors.black;
  final Color neonGreen = Color(0xFF39FF14);
  final Color borderColor = Color(0xFF00FF7F);

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
      ).updateBarangBaru(totalJumlah);
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
    _addRow();
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
      border: TableBorder.all(color: borderColor),
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
      decoration: BoxDecoration(color: Colors.black),
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
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black87,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Data Barang Baru'),
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
                  backgroundColor: Colors.black,
                  foregroundColor: neonGreen,
                  side: BorderSide(color: neonGreen),
                ),
                onPressed: _addRow,
                child: Text('Tambah'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: neonGreen,
                  side: BorderSide(color: neonGreen),
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
