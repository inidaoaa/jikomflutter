import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pembelian_controller.dart';

class PembelianView extends GetView<PembelianController> {
  const PembelianView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PembelianView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PembelianView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
