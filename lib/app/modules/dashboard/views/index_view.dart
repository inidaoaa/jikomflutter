import 'package:flutter/material.dart';

import 'package:get/get.dart';

class IndexView extends GetView {
  const IndexView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Halaman Beranda'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Bismillah',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
