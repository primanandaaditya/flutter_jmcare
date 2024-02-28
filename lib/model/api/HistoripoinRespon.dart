class HistoripoinRespon {
  List<Data>? data;

  HistoripoinRespon({this.data});

  HistoripoinRespon.fromJson(Map<String, dynamic> json) {
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
  String? noKtp;
  String? itemName;
  int? point;
  String? createdate;

  Data({this.noKtp, this.itemName, this.point, this.createdate});

  Data.fromJson(Map<String, dynamic> json) {
    noKtp = json['no_ktp'];
    itemName = json['item_name'];
    point = json['point'];
    createdate = json['createdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_ktp'] = this.noKtp;
    data['item_name'] = this.itemName;
    data['point'] = this.point;
    data['createdate'] = this.createdate;
    return data;
  }
}
class HistoripoinError extends HistoripoinRespon{}