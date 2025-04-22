class DataBarangSingleResponse {
  String? status;
  String? message;
  Data? data;

  DataBarangSingleResponse({this.status, this.message, this.data});

  DataBarangSingleResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? namaBarang;
  String? jenisBarang;
  String? merek;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.namaBarang,
      this.jenisBarang,
      this.merek,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    namaBarang = json['nama_barang'];
    jenisBarang = json['jenis_barang'];
    merek = json['merek'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_barang'] = this.namaBarang;
    data['jenis_barang'] = this.jenisBarang;
    data['merek'] = this.merek;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}