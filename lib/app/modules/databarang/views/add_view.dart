import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daoajikom/app/modules/databarang/controllers/databarang_controller.dart';

class AddView extends StatelessWidget {
  AddView({super.key});
  final DatabarangController controller = Get.find<DatabarangController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Barang'),
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Nama Barang Field
                TextFormField(
                  controller: controller.namaBarangController,
                  decoration: InputDecoration(
                    labelText: 'Nama Barang*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama barang wajib diisi';
                    }
                    if (value.length < 3) {
                      return 'Nama barang terlalu pendek';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                // Jenis Barang Field
                TextFormField(
                  controller: controller.jenisBarangController,
                  decoration: InputDecoration(
                    labelText: 'Jenis Barang*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jenis barang wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                // Merek Field (Optional)
                TextFormField(
                  controller: controller.merekController,
                  decoration: InputDecoration(
                    labelText: 'Merek (Opsional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Submit Button
                Obx(() {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isAdding.value
                          ? null
                          : () async {
                              if (controller.formKey.currentState!.validate()) {
                                try {
                                  final success = await controller.addBarang();
                                  if (success) {
                                    Get.back();
                                  }
                                } catch (e) {
                                  Get.snackbar(
                                    'Error',
                                    'Gagal menyimpan: ${e.toString()}',
                                    snackPosition: SnackPosition.TOP,
                                  );
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 2,
                      ),
                      child: controller.isAdding.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'SIMPAN DATA',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}