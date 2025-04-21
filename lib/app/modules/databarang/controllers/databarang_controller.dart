import 'package:daoajikom/app/data/data_barang_response.dart';
import 'package:daoajikom/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DatabarangController extends GetxController {
  // Controllers untuk text field
  final namaBarangController = TextEditingController();
  final jenisBarangController = TextEditingController();
  final merekController = TextEditingController();

  // State management
  final selectedIndex = 0.obs;
  final isLoading = false.obs;
  final isAdding = false.obs;
  
  // API client
  final _getConnect = GetConnect();
  final token = GetStorage().read('token') ?? '';

  // Form key untuk validasi
  final formKey = GlobalKey<FormState>();

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  Future<DataBarangResponse> getDataBarang() async {
    try {
      isLoading(true);
      final response = await _getConnect.get(
        BaseUrl.databarang,
        headers: {'Authorization': "Bearer $token"},
      );
      
      if (response.statusCode == 200) {
        return DataBarangResponse.fromJson(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> addBarang() async {
    try {
      if (!formKey.currentState!.validate()) return false;
      
      isAdding(true);
      final response = await _getConnect.post(
        BaseUrl.databarang,
        {
          'nama_barang': namaBarangController.text.trim(),
          'jenis_barang': jenisBarangController.text.trim(),
          'merek': merekController.text.trim(),
        },
        headers: {'Authorization': "Bearer $token"},
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Berhasil',
          'Barang berhasil ditambahkan',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        clearForm();
        await getDataBarang(); // Refresh data
        return true;
      } else {
        throw Exception('Failed to add: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Gagal menambahkan barang: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isAdding(false);
    }
  }

  void clearForm() {
    namaBarangController.clear();
    jenisBarangController.clear();
    merekController.clear();
  }

  @override
  void onClose() {
    namaBarangController.dispose();
    jenisBarangController.dispose();
    merekController.dispose();
    super.onClose();
  }
}