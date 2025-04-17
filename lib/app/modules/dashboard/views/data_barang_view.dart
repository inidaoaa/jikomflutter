import 'package:daoajikom/app/modules/databarang/views/add_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../data/data_barang_response.dart';
import '../controllers/dashboard_controller.dart';
import 'add_view.dart';

class DataBarangView extends StatelessWidget {
  DataBarangView({super.key});
  
  final DashboardController controller = Get.put(DashboardController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Barang'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.refreshDataBarang(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddView()),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<DataBarangResponse>(
          future: controller.getDataBarang(),
          builder: (context, snapshot) {
            // Jika data sedang dimuat
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
                    const Text("Gagal memuat data barang"),
                    ElevatedButton(
                      onPressed: () => controller.refreshDataBarang(),
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
              return const Center(child: Text("Tidak ada data barang"));
            }

            // Tampilkan data barang
            return RefreshIndicator(
              onRefresh: () => controller.refreshDataBarang(),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.data!.data!.data!.length,
                itemBuilder: (context, index) {
                  final barang = snapshot.data!.data!.data![index];
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
                            Row(
                              children: [
                                const Icon(Icons.category, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  barang.jenisBarang ?? "-",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.branding_watermark, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  barang.data!.[index]. ?? "-",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.inventory, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  "Stok: ${barang.jumlah ?? "0"}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return "-";
    try {
      final date = DateTime.parse(dateString);
      return "${date.day}/${date.month}/${date.year}";
    } catch (e) {
      return "-";
    }
  }
}