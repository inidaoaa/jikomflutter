import 'package:daoajikom/app/data/data_barang_response.dart';
import 'package:daoajikom/app/modules/databarang/views/add_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daoajikom/app/modules/databarang/controllers/databarang_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class DataBarangView extends StatelessWidget {
  const DataBarangView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DataBarangController());

        return Scaffold(
      appBar: AppBar(
        // Membuat AppBar dengan judul "Event List"
        title: const Text('Informasi'),
        centerTitle: true, // Menjadikan judul di tengah AppBar
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16.0), // Memberi padding di sekitar konten
        child: FutureBuilder<DataBarangResponse>(
          // Mengambil data event melalui fungsi getEvent dari controller
          future: controller.getInformation(),
          builder: (context, snapshot) {
            // Jika data sedang dimuat, tampilkan animasi loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.network(
                  // Menggunakan animasi Lottie untuk tampilan loading
                  'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                  repeat: true, // Animasi akan berulang terus-menerus
                  width: MediaQuery.of(context).size.width /
                      1, // Menyesuaikan lebar animasi
                ),
              );
            }

            if (!snapshot.hasData ||
                snapshot.data == null ||
                snapshot.data!.data == null) {
              return const Center(child: Text("Tidak ada data"));
            }

            // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
            if (snapshot.data!.data!.isEmpty) {
              return const Center(child: Text("Tidak ada data"));
            }

            return ListView.builder(
              // Menentukan jumlah item berdasarkan panjang data data
              itemCount: snapshot.data!.data!.length,
              controller:
                  scrollController, // Menggunakan ScrollController untuk ListView
              shrinkWrap:
                  true, // Membatasi ukuran ListView agar sesuai dengan konten
              itemBuilder: (context, index) {
                final item = snapshot.data!.data![index];
                return ZoomTapAnimation(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Menyusun elemen secara horizontal di kiri
                    children: [
                      // Menampilkan gambar event
                      Image.network(
                        item.image ?? 'default_image_url',
                        fit: BoxFit
                            .cover, // Menyesuaikan gambar dengan area tampilan
                        height: 200,
                        width: 500,
                        errorBuilder: (context, error, stackTrace) {
                          // Menangani error jika gambar tidak ditemukan
                          return const SizedBox(
                            height: 200,
                            child: Center(
                              child: Text('Image not found'),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16), // Jarak antara elemen
                      // Menampilkan judul event
                      Text(
                        snapshot.data!.data![index].title.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight:
                              FontWeight.bold, // Membuat teks menjadi tebal
                        ),
                      ),
                      const SizedBox(height: 8), // Jarak antara elemen
                      // Menampilkan deskripsi event
                      Text(
                        snapshot.data!.data![index].content.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey, // Warna teks abu-abu
                        ),
                      ),
                      // Garis pembatas antara item
                      const Divider(
                        height: 10, // Tinggi divider
                      ),
                      const SizedBox(height: 16), // Jarak setelah divider
                      // Menampilkan nama kategori
                      Text(
                        'Kategori: ${item.category?.name ?? "Tidak diketahui"}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blueAccent,
                        ),
                      ),

                      // Menampilkan User ID
                      Text(
                        'Penulis: ${item.user?.name ?? "-"}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const Divider(height: 10),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  

}
