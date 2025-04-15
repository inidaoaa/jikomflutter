import 'package:daoajikom/app/modules/databarang/views/add_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daoajikom/app/modules/databarang/controllers/databarang_controller.dart';

class DataBarangView extends StatelessWidget {
  const DataBarangView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DataBarangController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Barang'),
      ),
      body: const Center(
        child: Text('Halaman Data Barang'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddView())?.then((_) {
            controller.DataBarang(); // Refresh data setelah kembali
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  
  DataBarangController() {}
}
