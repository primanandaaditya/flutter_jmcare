class ProdukRespon {
  List<Data>? data;

  ProdukRespon({this.data});

  ProdukRespon.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? timestamp;
  String? nameEn;
  String? nameId;
  String? longNameEn;
  String? longNameId;
  String? descriptionId;
  String? descriptionEn;
  String? imgUrl2;

  Data(
      {this.id,
        this.timestamp,
        this.nameEn,
        this.nameId,
        this.longNameEn,
        this.longNameId,
        this.descriptionId,
        this.descriptionEn,
        this.imgUrl2});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timestamp = json['timestamp'];
    nameEn = json['name_en'];
    nameId = json['name_id'];
    longNameEn = json['long_name_en'];
    longNameId = json['long_name_id'];
    descriptionId = json['description_id'];
    descriptionEn = json['description_en'];
    imgUrl2 = json['img_url2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['timestamp'] = this.timestamp;
    data['name_en'] = this.nameEn;
    data['name_id'] = this.nameId;
    data['long_name_en'] = this.longNameEn;
    data['long_name_id'] = this.longNameId;
    data['description_id'] = this.descriptionId;
    data['description_en'] = this.descriptionEn;
    data['img_url2'] = this.imgUrl2;
    return data;
  }
}
class ProdukError extends ProdukRespon{}