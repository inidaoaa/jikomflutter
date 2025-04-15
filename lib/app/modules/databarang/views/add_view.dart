import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daoajikom/app/modules/databarang/controllers/databarang_controller.dart';

class AddView extends StatelessWidget {
  const AddView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DatabarangController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: controller.namaBarangController,
                decoration: const InputDecoration(
                  labelText: 'Nama Barang',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.jenisBarangController,
                decoration: const InputDecoration(
                  labelText: 'Jenis Barang',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.merekController,
                decoration: const InputDecoration(
                  labelText: 'Merek',
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  controller.addBarang();
                },
                icon: const Icon(Icons.save),
                label: const Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
