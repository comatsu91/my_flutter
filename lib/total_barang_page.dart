import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/barang_provider.dart';

class TotalBarangPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final barangProvider = Provider.of<BarangProvider>(context);

    const neonGreen = Color(0xFF39FF14);
    const neonBlue = Color(0xFF00E5FF);
    const darkBackground = Color(0xFF121212);

    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        title: Text(
          'Total Barang',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: neonBlue),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildStatCard(
              context,
              title: 'Barang Baru',
              value: barangProvider.totalBarangBaru,
              color: neonGreen,
              icon: Icons.new_releases_outlined,
            ),
            const SizedBox(height: 20),
            _buildStatCard(
              context,
              title: 'Barang Lama',
              value: barangProvider.totalBarangLama,
              color: neonBlue,
              icon: Icons.history_outlined,
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    neonBlue.withOpacity(0.2),
                    neonGreen.withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: neonGreen.withOpacity(0.5), width: 1),
              ),
              child: Column(
                children: [
                  Text(
                    'TOTAL SEMUA BARANG',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${barangProvider.totalSemuaBarang}',
                    style: TextStyle(
                      color: neonGreen,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: neonGreen.withOpacity(0.5),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'TABEL BARANG BARU',
                      style: TextStyle(
                        color: neonGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildDataTable(barangProvider.dataBarangBaru, neonGreen),
                    const SizedBox(height: 30),
                    Text(
                      'TABEL BARANG LAMA',
                      style: TextStyle(
                        color: neonBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildDataTable(barangProvider.dataBarangLama, neonBlue),
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
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
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
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.5), width: 1),
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
                    color: Colors.white.withOpacity(0.7),
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

  Widget _buildDataTable(List<Map<String, String>> dataList, Color textColor) {
    return Table(
      border: TableBorder.all(color: textColor),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(3),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.black45),
          children: [
            _buildCell('No.', textColor),
            _buildCell('Nama Barang', textColor),
            _buildCell('Jumlah', textColor),
            _buildCell('Kondisi', textColor),
            _buildCell('Keterangan', textColor),
          ],
        ),
        ...dataList.map(
          (item) => TableRow(
            children: [
              _buildCell(item['no'] ?? '', textColor),
              _buildCell(item['nama'] ?? '', textColor),
              _buildCell(item['jumlah'] ?? '', textColor),
              _buildCell(item['kondisi'] ?? '', textColor),
              _buildCell(item['keterangan'] ?? '', textColor),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCell(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: TextStyle(color: color, fontSize: 14)),
    );
  }
}
