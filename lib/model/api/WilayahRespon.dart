class WilayahRespon {
  List<Data>? data;

  WilayahRespon({this.data});

  WilayahRespon.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? alternatifId;
  int? id;
  String? nama;
  String? tipe;

  Data({this.alternatifId, this.id, this.nama, this.tipe});

  Data.fromJson(Map<String, dynamic> json) {
    alternatifId = json['alternatif_id'];
    id = json['id'];
    nama = json['nama'];
    tipe = json['tipe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alternatif_id'] = this.alternatifId;
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['tipe'] = this.tipe;
    return data;
  }
}
class WilayahError extends WilayahRespon{}