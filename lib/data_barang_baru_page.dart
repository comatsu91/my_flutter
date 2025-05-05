import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/barang_provider.dart';

class DataBarangBaruPage extends StatefulWidget {
  const DataBarangBaruPage({super.key});

  @override
  State<DataBarangBaruPage> createState() => _DataBarangBaruPageState();
}

class _DataBarangBaruPageState extends State<DataBarangBaruPage> {
  final List<Map<String, TextEditingController>> barangControllers = [];
  int totalJumlah = 0;

  // === NEON & THEME COLORS ===
  final Color neonGreen = const Color(0xFF39FF14);
  final Color neonBlue = const Color(0xFF00E5FF);

  String currentTheme = 'neon';
  late Color primaryColor;
  late Color backgroundColor;
  late Color textColor;
  late Color cardColor;
  late Color borderColor;

  @override
  void initState() {
    super.initState();
    _addRow();
    _setTheme('neon');
  }

  // === SET TEMA BERDASARKAN PILIHAN ===
  void _setTheme(String theme) {
    setState(() {
      currentTheme = theme;
      switch (theme) {
        case 'dark':
          primaryColor = Colors.blueGrey;
          backgroundColor = Colors.grey[900]!;
          textColor = Colors.white;
          cardColor = Colors.grey[800]!.withAlpha(204);
          borderColor = Colors.white70;
          break;
        case 'light':
          primaryColor = Colors.blue;
          backgroundColor = Colors.white;
          textColor = Colors.black;
          cardColor = Colors.grey[100]!.withAlpha(204);
          borderColor = Colors.black54;
          break;
        default: // neon
          primaryColor = neonGreen;
          backgroundColor = Colors.black;
          textColor = Colors.white;
          cardColor = Colors.black.withAlpha(204);
          borderColor = neonGreen;
      }
    });
  }

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
      final data =
          barangControllers
              .map(
                (ctrl) => {
                  'no': ctrl['no']!.text,
                  'nama': ctrl['nama']!.text,
                  'jumlah': ctrl['jumlah']!.text,
                  'kondisi': ctrl['kondisi']!.text,
                  'keterangan': ctrl['keterangan']!.text,
                },
              )
              .toList();

      Provider.of<BarangProvider>(
        context,
        listen: false,
      ).updateBarangBaru(totalJumlah, data);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Data berhasil disimpan!')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  // === UI TABEL ===
  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: backgroundColor),
      children: [
        _buildHeaderCell('No.'),
        _buildHeaderCell('Nama Barang'),
        _buildHeaderCell('Jumlah'),
        _buildHeaderCell('Kondisi'),
        _buildHeaderCell('Keterangan'),
        _buildHeaderCell(''),
      ],
    );
  }

  TableRow _buildTableRow(Map<String, TextEditingController> row) {
    int index = barangControllers.indexOf(row);
    return TableRow(
      children: [
        _buildTableInput(row['no']!),
        _buildTableInput(row['nama']!),
        _buildTableInput(row['jumlah']!),
        _buildTableInput(row['kondisi']!),
        _buildTableInput(row['keterangan']!),
        _buildDeleteButton(index),
      ],
    );
  }

  Widget _buildHeaderCell(String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
        ),
      ),
    );
  }

  Widget _buildTableInput(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextField(
        controller: controller,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          filled: true,
          fillColor: cardColor,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton(int index) {
    return IconButton(
      icon: Icon(Icons.delete, color: neonGreen),
      onPressed: () {
        setState(() => barangControllers.removeAt(index));
      },
    );
  }

  Widget _buildTotalRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Total Jumlah Barang: $totalJumlah',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: primaryColor,
          ),
        ),
      ),
    );
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
        5: FlexColumnWidth(1),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        _buildTableHeader(),
        ...barangControllers.map((row) => _buildTableRow(row)),
      ],
    );
  }

  // === UI BUILD ===
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        title: Text('Data Barang Baru', style: TextStyle(color: primaryColor)),
        iconTheme: IconThemeData(color: primaryColor),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.palette, color: primaryColor),
            onSelected: _setTheme,
            itemBuilder:
                (_) => [
                  const PopupMenuItem(value: 'neon', child: Text('Neon Theme')),
                  const PopupMenuItem(value: 'dark', child: Text('Dark Theme')),
                  const PopupMenuItem(
                    value: 'light',
                    child: Text('Light Theme'),
                  ),
                ],
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: _buildTable(),
            ),
          ),
          _buildTotalRow(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: primaryColor,
                  side: BorderSide(color: primaryColor),
                ),
                onPressed: _addRow,
                child: const Text('Tambah'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: backgroundColor,
                ),
                onPressed: _saveData,
                child: const Text('Simpan'),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
