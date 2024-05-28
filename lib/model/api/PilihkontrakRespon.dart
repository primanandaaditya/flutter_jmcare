class PilihkontrakRespon {
  List<Data>? data;

  PilihkontrakRespon({this.data});

  PilihkontrakRespon.fromJson(Map<String, dynamic> json) {
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
  int? aGRMNTID;
  String? cUSTFULLNAME;
  String? iDNO;
  String? aGRMNTNO;
  String? pLATNO;
  String? kTPNO;
  String? merkType;
  String? warna;
  double? estimasiAngsuran;
  int? keterlambatanHari;
  double? denda;
  String? aPPNO;
  String? oFFICECODE;

  Data(
      {this.aGRMNTID,
        this.cUSTFULLNAME,
        this.iDNO,
        this.aGRMNTNO,
        this.pLATNO,
        this.kTPNO,
        this.merkType,
        this.warna,
        this.estimasiAngsuran,
        this.keterlambatanHari,
        this.denda,
        this.aPPNO,
        this.oFFICECODE});

  Data.fromJson(Map<String, dynamic> json) {
    aGRMNTID = json['AGRMNT_ID'];
    cUSTFULLNAME = json['CUST_FULL_NAME'];
    iDNO = json['ID_NO'];
    aGRMNTNO = json['AGRMNT_NO'];
    pLATNO = json['PLAT_NO'];
    kTPNO = json['KTPNO'];
    merkType = json['merk_type'];
    warna = json['warna'];
    estimasiAngsuran = json['estimasi_angsuran'];
    keterlambatanHari = json['keterlambatan_hari'];
    denda = json['Denda'];
    aPPNO = json['APP_NO'];
    oFFICECODE = json['OFFICE_CODE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AGRMNT_ID'] = this.aGRMNTID;
    data['CUST_FULL_NAME'] = this.cUSTFULLNAME;
    data['ID_NO'] = this.iDNO;
    data['AGRMNT_NO'] = this.aGRMNTNO;
    data['PLAT_NO'] = this.pLATNO;
    data['KTPNO'] = this.kTPNO;
    data['merk_type'] = this.merkType;
    data['warna'] = this.warna;
    data['estimasi_angsuran'] = this.estimasiAngsuran;
    data['keterlambatan_hari'] = this.keterlambatanHari;
    data['Denda'] = this.denda;
    data['APP_NO'] = this.aPPNO;
    data['OFFICE_CODE'] = this.oFFICECODE;
    return data;
  }
}
class PilihkontrakError extends PilihkontrakRespon{}