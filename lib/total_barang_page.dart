import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'providers/barang_provider.dart';
import 'theme_controller.dart';

class TotalBarangPage extends StatelessWidget {
  const TotalBarangPage({super.key});

  @override
  Widget build(BuildContext context) {
    final barangProvider = Provider.of<BarangProvider>(context);
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      backgroundColor: themeController.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Total Barang',
          style: TextStyle(
            color: themeController.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: themeController.primaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dua kartu statistik
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Barang Baru',
                    value: barangProvider.totalBarangBaru,
                    color: themeController.primaryColor,
                    icon: Icons.new_releases_outlined,
                    themeController: themeController,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Barang Lama',
                    value: barangProvider.totalBarangLama,
                    color: themeController.neonBlue,
                    icon: Icons.history_outlined,
                    themeController: themeController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    themeController.neonBlue.withAlpha(51),
                    themeController.primaryColor.withAlpha(51),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: themeController.primaryColor.withAlpha(127),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'TOTAL SEMUA BARANG',
                    style: TextStyle(
                      color: themeController.textColor.withAlpha(204),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${barangProvider.totalSemuaBarang}',
                    style: TextStyle(
                      color: themeController.primaryColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: themeController.primaryColor.withAlpha(127),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'TABEL BARANG BARU',
                      style: TextStyle(
                        color: themeController.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildDataTable(
                      context,
                      barangProvider.dataBarangBaru,
                      themeController.primaryColor,
                      true,
                      themeController,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'TABEL BARANG LAMA',
                      style: TextStyle(
                        color: themeController.neonBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildDataTable(
                      context,
                      barangProvider.dataBarangLama,
                      themeController.neonBlue,
                      false,
                      themeController,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required int value,
    required Color color,
    required IconData icon,
    required ThemeController themeController,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeController.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(76), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(25),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              shape: BoxShape.circle,
              border: Border.all(color: color.withAlpha(127), width: 1),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    color: themeController.textColor.withAlpha(178),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$value',
                  style: TextStyle(
                    color: color,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable(
    BuildContext context,
    List<Map<String, String>> dataList,
    Color textColor,
    bool isBarangBaru,
    ThemeController themeController,
  ) {
    return Table(
      border: TableBorder.all(color: textColor),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(3),
        5: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: themeController.cardColor),
          children: [
            _buildCell('No.', textColor),
            _buildCell('Nama Barang', textColor),
            _buildCell('Jumlah', textColor),
            _buildCell('Kondisi', textColor),
            _buildCell('Keterangan', textColor),
            _buildCell('', textColor),
          ],
        ),
        ...dataList.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return TableRow(
            children: [
              _buildCell(item['no'] ?? '', textColor),
              _buildCell(item['nama'] ?? '', textColor),
              _buildCell(item['jumlah'] ?? '', textColor),
              _buildCell(item['kondisi'] ?? '', textColor),
              _buildCell(item['keterangan'] ?? '', textColor),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: IconButton(
                  icon: Icon(Icons.edit, size: 18, color: textColor),
                  onPressed:
                      () => _showEditDialog(
                        context,
                        item,
                        index,
                        isBarangBaru,
                        themeController,
                      ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  void _showEditDialog(
    BuildContext context,
    Map<String, String> item,
    int index,
    bool isBarangBaru,
    ThemeController themeController,
  ) {
    final barangProvider = Provider.of<BarangProvider>(context, listen: false);

    final namaController = TextEditingController(text: item['nama']);
    final jumlahController = TextEditingController(text: item['jumlah']);
    final kondisiController = TextEditingController(text: item['kondisi']);
    final keteranganController = TextEditingController(
      text: item['keterangan'],
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: themeController.cardColor,
            title: Text(
              'Edit Barang',
              style: TextStyle(color: themeController.primaryColor),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: namaController,
                    style: TextStyle(color: themeController.textColor),
                    decoration: InputDecoration(
                      labelText: 'Nama Barang',
                      labelStyle: TextStyle(
                        color: themeController.primaryColor,
                      ),
                    ),
                  ),
                  TextField(
                    controller: jumlahController,
                    style: TextStyle(color: themeController.textColor),
                    decoration: InputDecoration(
                      labelText: 'Jumlah',
                      labelStyle: TextStyle(
                        color: themeController.primaryColor,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: kondisiController,
                    style: TextStyle(color: themeController.textColor),
                    decoration: InputDecoration(
                      labelText: 'Kondisi',
                      labelStyle: TextStyle(
                        color: themeController.primaryColor,
                      ),
                    ),
                  ),
                  TextField(
                    controller: keteranganController,
                    style: TextStyle(color: themeController.textColor),
                    decoration: InputDecoration(
                      labelText: 'Keterangan',
                      labelStyle: TextStyle(
                        color: themeController.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Batal',
                  style: TextStyle(color: themeController.primaryColor),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeController.primaryColor,
                ),
                onPressed: () {
                  final updatedItem = {
                    'no': item['no'] ?? '',
                    'nama': namaController.text,
                    'jumlah': jumlahController.text,
                    'kondisi': kondisiController.text,
                    'keterangan': keteranganController.text,
                  };

                  if (isBarangBaru) {
                    barangProvider.updateItemBarangBaru(index, updatedItem);
                  } else {
                    barangProvider.updateItemBarangLama(index, updatedItem);
                  }

                  Navigator.pop(context);
                },
                child: Text(
                  'Simpan',
                  style: TextStyle(color: themeController.backgroundColor),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildCell(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: TextStyle(color: color, fontSize: 14)),
    );
  }
}
