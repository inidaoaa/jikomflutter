import 'package:daoajikom/app/modules/dashboard/views/index_view.dart';
import 'package:daoajikom/app/modules/dashboard/views/profile_view.dart';
import 'package:daoajikom/app/modules/dashboard/views/your_event_view.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    IndexView(),
    YourEventView(),
    ProfileView(),
  ];
  //TODO: Implement DashboardController

  
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  
}
