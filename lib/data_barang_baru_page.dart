import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'providers/barang_provider.dart';
import 'theme_controller.dart'; // Import ThemeController

class DataBarangBaruPage extends StatefulWidget {
  const DataBarangBaruPage({super.key});

  @override
  State<DataBarangBaruPage> createState() => _DataBarangBaruPageState();
}

class _DataBarangBaruPageState extends State<DataBarangBaruPage> {
  final List<Map<String, TextEditingController>> barangControllers = [];
  int totalJumlah = 0;

  @override
  void initState() {
    super.initState();
    _addRow();
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

  // Header Tabel
  TableRow _buildTableHeader(ThemeController themeController) {
    return TableRow(
      decoration: BoxDecoration(color: themeController.backgroundColor),
      children: [
        _buildHeaderCell('No.', themeController),
        _buildHeaderCell('Nama Barang', themeController),
        _buildHeaderCell('Jumlah', themeController),
        _buildHeaderCell('Kondisi', themeController),
        _buildHeaderCell('Keterangan', themeController),
        _buildHeaderCell('', themeController),
      ],
    );
  }

  // Baris Tabel Input
  TableRow _buildTableRow(
    Map<String, TextEditingController> row,
    ThemeController themeController,
  ) {
    int index = barangControllers.indexOf(row);
    return TableRow(
      children: [
        _buildTableInput(row['no']!, themeController),
        _buildTableInput(row['nama']!, themeController),
        _buildTableInput(row['jumlah']!, themeController),
        _buildTableInput(row['kondisi']!, themeController),
        _buildTableInput(row['keterangan']!, themeController),
        _buildDeleteButton(index, themeController),
      ],
    );
  }

  Widget _buildHeaderCell(String label, ThemeController themeController) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: themeController.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildTableInput(
    TextEditingController controller,
    ThemeController themeController,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextField(
        controller: controller,
        style: TextStyle(color: themeController.textColor),
        decoration: InputDecoration(
          filled: true,
          fillColor: themeController.cardColor,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton(int index, ThemeController themeController) {
    return IconButton(
      icon: Icon(Icons.delete, color: themeController.primaryColor),
      onPressed: () {
        setState(() => barangControllers.removeAt(index));
      },
    );
  }

  Widget _buildTotalRow(ThemeController themeController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Total Jumlah Barang: $totalJumlah',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: themeController.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildTable(ThemeController themeController) {
    return Table(
      border: TableBorder.all(color: themeController.primaryColor),
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
        _buildTableHeader(themeController),
        ...barangControllers.map((row) => _buildTableRow(row, themeController)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan instance ThemeController menggunakan GetX
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      backgroundColor: themeController.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: themeController.backgroundColor,
        title: Text(
          'Data Barang Baru',
          style: TextStyle(color: themeController.primaryColor),
        ),
        iconTheme: IconThemeData(color: themeController.primaryColor),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: _buildTable(themeController),
            ),
          ),
          _buildTotalRow(themeController),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: themeController.primaryColor,
                  side: BorderSide(color: themeController.primaryColor),
                ),
                onPressed: _addRow,
                child: const Text('Tambah'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeController.primaryColor,
                  foregroundColor: themeController.backgroundColor,
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
