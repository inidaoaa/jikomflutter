import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/databarang_controller.dart';

class DatabarangView extends GetView<DatabarangController> {
  const DatabarangView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DatabarangView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DatabarangView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
