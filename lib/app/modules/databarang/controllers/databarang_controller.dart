import 'package:daoajikom/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Pastikan path ini sesuai


class DatabarangController extends GetxController {
  final namaBarangController = TextEditingController();
  final jenisBarangController = TextEditingController();
  final merekController = TextEditingController();

  final _getConnect = GetConnect();
  final token = "YOUR_API_TOKEN"; // Ganti dengan token yang valid

  void addBarang() async {
    final response = await _getConnect.post(
      BaseUrl.databarang, // Pastikan BaseUrl.databarang ada
      {
        'nama_barang': namaBarangController.text,
        'jenis_barang': jenisBarangController.text,
        'merek': merekController.text,
      },
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );

    if (response.statusCode == 201) {
      Get.snackbar(
        'Berhasil',
        'Barang berhasil ditambahkan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      namaBarangController.clear();
      jenisBarangController.clear();
      merekController.clear();
      getYourEvent();
      Get.close(1);
    } else {
      Get.snackbar(
        'Gagal',
        'Gagal menambahkan barang',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void getYourEvent() {
    print('getYourEvent() dipanggil');
    // Tambahkan logic fetch data jika perlu
  }

  @override
  void onClose() {
    namaBarangController.dispose();
    jenisBarangController.dispose();
    merekController.dispose();
    super.onClose();
  }
}
