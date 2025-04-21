import 'package:daoajikom/app/data/data_barang_response.dart';
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
  final token = GetStorage().read('token');
  var errorMessageDataBarang = ''.obs;
  var dataBarangList = <DataBarang>[].obs;

  final List<Widget> pages = [
    IndexView(),
    DataBarangView(),
    ProfileView(),
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  // Fungsi untuk mengambil data barang
  Future<DataBarangResponse> getDataBarang() async {
    try {
      final response = await _getConnect.get(
        BaseUrl.databarang, 
        headers: {'Authorization': "Bearer $token"},
        contentType: "application/json",
      );

      if (response.isOk) {
        return DataBarangResponse.fromJson(response.body);
      } else {
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
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


