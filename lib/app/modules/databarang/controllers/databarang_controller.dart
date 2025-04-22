import 'package:daoajikom/app/data/data_barang_response.dart';
import 'package:daoajikom/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DatabarangController extends GetxController {
  // Form controllers
  final namaBarangController = TextEditingController();
  final jenisBarangController = TextEditingController();
  final merekController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // State variables
  final selectedIndex = 0.obs;
  final isLoading = false.obs;
  final isAdding = false.obs;
  final dataBarangList = <DataBarang>[].obs;
  final errorMessage = ''.obs;

  // API client
  final _getConnect = GetConnect();
  final token = GetStorage().read('token') ?? '';

  // Navigation
  void changeIndex(int index) => selectedIndex.value = index;

  // Data operations
  Future<void> fetchDataBarang() async {
    try {
      isLoading(true);
      errorMessage('');
      
      final response = await _getConnect.get(
        BaseUrl.databarang,
        headers: _buildHeaders(),
      );

      if (response.isOk) {
        final data = DataBarangResponse.fromJson(response.body);
        dataBarangList.assignAll(data.data?.data ?? []);
        
        if (dataBarangList.isEmpty) {
          errorMessage('Tidak ada data barang');
        }
      } else {
        _handleErrorResponse(response);
      }
    } catch (e) {
      _handleException(e);
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
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar(
        'Berhasil!',
        response.body['message'] ?? 'Data berhasil ditambahkan',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      clearForm();
      await fetchDataBarang(); // Refresh data
      return true;
    } else {
      throw Exception(response.body['message'] ?? 'Gagal menambahkan data');
    }
  } catch (e) {
    Get.snackbar(
      'Gagal',
      e.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return false;
  } finally {
    isAdding(false);
  }
}

  // Helper methods
  Map<String, String> _buildHeaders() {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Map<String, dynamic> _buildPayload() {
    return {
      'nama_barang': namaBarangController.text.trim(),
      'jenis_barang': jenisBarangController.text.trim(),
      'merek': merekController.text.trim(),
    };
  }

  void _handleErrorResponse(Response response) {
    final errorMsg = response.body['message'] ?? 
                   response.statusText ?? 
                   'Gagal memproses permintaan (${response.statusCode})';
    errorMessage.value = errorMsg;
    Get.snackbar(
      'Error',
      errorMsg,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void _handleException(dynamic e) {
    errorMessage.value = 'Terjadi kesalahan: ${e.toString()}';
    Get.snackbar(
      'Exception',
      e.toString(),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void clearForm() {
    namaBarangController.clear();
    jenisBarangController.clear();
    merekController.clear();
    formKey.currentState?.reset();
  }

  @override
  void onClose() {
    namaBarangController.dispose();
    jenisBarangController.dispose();
    merekController.dispose();
    _getConnect.dispose();
    super.onClose();
  }
}