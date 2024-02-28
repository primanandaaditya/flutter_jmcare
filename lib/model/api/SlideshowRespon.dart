class SlideshowRespon {
  List<Data>? data;

  SlideshowRespon({this.data});

  SlideshowRespon.fromJson(Map<String, dynamic> json) {
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
  String? timestamp;
  int? id;
  String? nameEn;
  String? nameId;
  String? imgUrl;

  Data({this.timestamp, this.id, this.nameEn, this.nameId, this.imgUrl});

  Data.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    id = json['id'];
    nameEn = json['name_en'];
    nameId = json['name_id'];
    imgUrl = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_id'] = this.nameId;
    data['img_url'] = this.imgUrl;
    return data;
  }
}
class SlideshowError extends SlideshowRespon{}