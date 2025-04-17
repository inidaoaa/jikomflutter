import 'package:daoajikom/app/data/data_barang_response.dart';
import 'package:daoajikom/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Pastikan path ini sesuai

class DatabarangController extends GetxController {
  final namaBarangController = TextEditingController();
  final jenisBarangController = TextEditingController();
  final merekController = TextEditingController();

  final selectedIndex = 0.obs;
  final _getConnect = GetConnect();
  final token = GetStorage().read('token');

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  Future<DataBarangResponse> getDataBarang() async {
    final response = await _getConnect.get(
      BaseUrl.databarang,
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );
    return DataBarangResponse.fromJson(response.body);
  }

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

    if (response.statusCode == 200) {
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
      getDataBarang();
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


  @override
  void onClose() {
    namaBarangController.dispose();
    jenisBarangController.dispose();
    merekController.dispose();
    super.onClose();
  }
}
