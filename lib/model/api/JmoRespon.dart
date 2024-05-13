class JmoRespon {
  List<Data>? data;

  JmoRespon({this.data});

  JmoRespon.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? nama;
  String? name;
  String? tipe;

  Data({this.alternatifId, this.id, this.nama, this.name, this.tipe});

  Data.fromJson(Map<String, dynamic> json) {
    alternatifId = json['alternatif_id'];
    id = json['id'].toString();
    nama = json['nama'];
    name = json['name'];
    tipe = json['tipe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alternatif_id'] = this.alternatifId;
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['name'] = this.name;
    data['tipe'] = this.tipe;
    return data;
  }
}
class JmoError extends JmoRespon{}