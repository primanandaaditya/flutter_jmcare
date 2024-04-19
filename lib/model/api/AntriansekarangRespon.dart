class AntriansekarangRespon {
  List<Data>? data;

  AntriansekarangRespon({this.data});

  AntriansekarangRespon.fromJson(Map<String, dynamic> json) {
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
  String? nOANTRIAN;
  int? iDUSERJMCARE;
  String? nAMAPENGUNJUNG;
  String? pIC;
  String? sTATUSPROGRESS;

  Data(
      {this.nOANTRIAN,
        this.iDUSERJMCARE,
        this.nAMAPENGUNJUNG,
        this.pIC,
        this.sTATUSPROGRESS});

  Data.fromJson(Map<String, dynamic> json) {
    nOANTRIAN = json['NO_ANTRIAN'];
    iDUSERJMCARE = json['ID_USER_JMCARE'];
    nAMAPENGUNJUNG = json['NAMA_PENGUNJUNG'];
    pIC = json['PIC'];
    sTATUSPROGRESS = json['STATUS_PROGRESS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NO_ANTRIAN'] = this.nOANTRIAN;
    data['ID_USER_JMCARE'] = this.iDUSERJMCARE;
    data['NAMA_PENGUNJUNG'] = this.nAMAPENGUNJUNG;
    data['PIC'] = this.pIC;
    data['STATUS_PROGRESS'] = this.sTATUSPROGRESS;
    return data;
  }
}
class AntriansekarangError extends AntriansekarangRespon{}