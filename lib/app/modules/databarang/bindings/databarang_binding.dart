import 'package:get/get.dart';

import '../controllers/databarang_controller.dart';

class DatabarangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatabarangController>(
      () => DatabarangController(),
    );
  }
}
