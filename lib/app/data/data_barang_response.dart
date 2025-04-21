class DataBarangResponse {
  String? status;
  String? message;
  Data? data;

  DataBarangResponse({this.status, this.message, this.data});

  DataBarangResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<DataBarang>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataBarang>[];
      json['data'].forEach((v) {
        data!.add(DataBarang.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}


class DataBarang {
  int? id;
  String? namaBarang;
  String? jenisBarang;
  String? merek;
  int? jumlah;
  String? createdAt;
  String? updatedAt;
  String? pembeliansSumJumlah;

  DataBarang({
    this.id,
    this.namaBarang,
    this.jenisBarang,
    this.merek,
    this.jumlah,
    this.createdAt,
    this.updatedAt,
    this.pembeliansSumJumlah,
  });

  DataBarang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaBarang = json['nama_barang'];
    jenisBarang = json['jenis_barang'];
    merek = json['merek'];
    jumlah = json['jumlah'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pembeliansSumJumlah = json['pembelians_sum_jumlah']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['nama_barang'] = namaBarang;
    data['jenis_barang'] = jenisBarang;
    data['merek'] = merek;
    data['jumlah'] = jumlah;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['pembelians_sum_jumlah'] = pembeliansSumJumlah;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
