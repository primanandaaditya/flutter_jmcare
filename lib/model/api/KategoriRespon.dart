class KategoriRespon {
  List<Data>? data;

  KategoriRespon({this.data});

  KategoriRespon.fromJson(Map<String, dynamic> json) {
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
  String? iDKATEGORI;
  String? iSBRANCH;
  String? kATEGORI;
  String? pIC;
  String? tIPE;

  Data({this.iDKATEGORI, this.iSBRANCH, this.kATEGORI, this.pIC, this.tIPE});

  Data.fromJson(Map<String, dynamic> json) {
    iDKATEGORI = json['ID_KATEGORI'];
    iSBRANCH = json['IS_BRANCH'];
    kATEGORI = json['KATEGORI'];
    pIC = json['PIC'];
    tIPE = json['TIPE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_KATEGORI'] = this.iDKATEGORI;
    data['IS_BRANCH'] = this.iSBRANCH;
    data['KATEGORI'] = this.kATEGORI;
    data['PIC'] = this.pIC;
    data['TIPE'] = this.tIPE;
    return data;
  }
}
class KategoriError extends KategoriRespon{}