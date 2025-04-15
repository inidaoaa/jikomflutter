import 'package:daoajikom/app/modules/dashboard/views/index_view.dart';
import 'package:daoajikom/app/modules/dashboard/views/profile_view.dart';
import 'package:daoajikom/app/modules/dashboard/views/your_event_view.dart';
import 'package:daoajikom/app/modules/dashboard/views/data_barang_view.dart';
import 'package:daoajikom/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_connect.dart';

class DashboardController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final GetConnect _getConnect = GetConnect();
  final GetStorage _storage = GetStorage();
  
  final List<Widget> pages = [
    IndexView(),
    DataBarangView(),
    YourEventView(),
    ProfileView(),
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> logOut() async {
    try {
      // Ambil token dari local storage
      final token = _storage.read('token');
      
      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      final response = await _getConnect.post(
        BaseUrl.logout,
        {},
        headers: {'Authorization': 'Bearer $token'},
        contentType: 'application/json',
      );

      if (response.statusCode == 200) {
        // Hapus semua data user dari penyimpanan lokal
        await _storage.erase();
        
        Get.snackbar(
          'Success',
          'Logout Success',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        
        // Redirect ke halaman login
        Get.offAllNamed('/login');
      } else {
        throw Exception('Gagal logout: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        'Logout Failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _getConnect.dispose();
    super.onClose();
  }
}