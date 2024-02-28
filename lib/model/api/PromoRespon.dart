class PromoRespon {
  List<Data>? data;

  PromoRespon({this.data});

  PromoRespon.fromJson(Map<String, dynamic> json) {
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
  String? titleEn;
  String? titleId;
  String? subtitleEn;
  String? subtitleId;
  String? descriptionEn;
  String? descriptionId;
  String? imgUrl;

  Data(
      {this.id,
        this.titleEn,
        this.titleId,
        this.subtitleEn,
        this.subtitleId,
        this.descriptionEn,
        this.descriptionId,
        this.imgUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleEn = json['title_en'];
    titleId = json['title_id'];
    subtitleEn = json['subtitle_en'];
    subtitleId = json['subtitle_id'];
    descriptionEn = json['description_en'];
    descriptionId = json['description_id'];
    imgUrl = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title_en'] = this.titleEn;
    data['title_id'] = this.titleId;
    data['subtitle_en'] = this.subtitleEn;
    data['subtitle_id'] = this.subtitleId;
    data['description_en'] = this.descriptionEn;
    data['description_id'] = this.descriptionId;
    data['img_url'] = this.imgUrl;
    return data;
  }
}
class PromoError extends PromoRespon{}