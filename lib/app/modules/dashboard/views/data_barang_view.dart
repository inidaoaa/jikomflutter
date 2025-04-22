import 'package:daoajikom/app/modules/databarang/bindings/databarang_binding.dart';
import 'package:daoajikom/app/modules/databarang/views/add_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../data/data_barang_response.dart';
import '../controllers/dashboard_controller.dart';

class DataBarangView extends StatefulWidget {
  const DataBarangView({super.key});

  @override
  State<DataBarangView> createState() => _DataBarangViewState();
}

class _DataBarangViewState extends State<DataBarangView> {
  final DashboardController controller = Get.find<DashboardController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    await controller.getDataBarang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Barang'),
        centerTitle: true,
      ),
    floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Get.to(
              () => AddView(),
              binding: DatabarangBinding(),
            );
            await _refreshData();
            setState(() {});
          },
          child: Icon(Icons.add),
          tooltip: 'Tambah Data',
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<DataBarangResponse>(
          future: controller.getDataBarang(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.network(
                  'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                  repeat: true,
                  width: MediaQuery.of(context).size.width / 1,
                ),
              );
            }

            // Jika terjadi error
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Gagal memuat data: ${snapshot.error}",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _refreshData,
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              );
            }

            // Jika tidak ada data
            if (!snapshot.hasData ||
                snapshot.data?.data?.data == null ||
                snapshot.data!.data!.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Tidak ada data barang"),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _refreshData,
                      child: const Text('Muat Ulang'),
                    ),
                  ],
                ),
              );
            }

            final dataBarang = snapshot.data!.data!.data!;

            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: dataBarang.length,
                itemBuilder: (context, index) {
                  final barang = dataBarang[index];
                  return _buildBarangItem(barang);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBarangItem(DataBarang barang) {
    return ZoomTapAnimation(
      onTap: () {
        // Aksi ketika item di-tap
        // Get.to(() => DetailBarangView(barang: barang));
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                barang.namaBarang ?? "Nama Barang",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildInfoRow(Icons.category, barang.jenisBarang ?? "-"),
              const SizedBox(height: 8),
              _buildInfoRow(Icons.branding_watermark, barang.merek ?? "-"),
              const SizedBox(height: 8),
              _buildInfoRow(
                Icons.inventory,
                "Stok: ${barang.jumlah ?? "0"}",
                textColor: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {Color? textColor}) {
    return Row(
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: textColor,
          ),
        ),
      ],
    );
  }
}