import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Foto profil dummy
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Admin',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'admin@email.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Contoh logika logout sederhana
          final shouldLogout = await Get.defaultDialog<bool>(
            title: 'Konfirmasi',
            middleText: 'Apakah kamu yakin ingin logout?',
            textConfirm: 'Ya',
            textCancel: 'Tidak',
            confirmTextColor: Colors.white,
            onConfirm: () => Get.back(result: true),
            onCancel: () => Get.back(result: false),
          );

          if (shouldLogout == true) {
            // Tambahkan logika hapus token/sesi di sini jika perlu
            Get.offAllNamed('/login'); // Arahkan ke halaman login
          }
        },
        tooltip: 'Logout',
        child: const Icon(Icons.logout),
      ),
    );
  }
}
