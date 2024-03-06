class CabangRespon {
  List<Data>? data;

  CabangRespon({this.data});

  CabangRespon.fromJson(Map<String, dynamic> json) {
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
  String? oFFICECODE;
  String? oFFICENAME;
  String? oFFICEADDR;
  String? rT;
  String? rW;
  String? kELURAHAN;
  String? kECAMATAN;
  String? cITY;
  String? zIPCODE;
  String? pHONE;
  String? oFFICELAT;
  String? oFFICELONG;

  Data(
      {this.oFFICECODE,
        this.oFFICENAME,
        this.oFFICEADDR,
        this.rT,
        this.rW,
        this.kELURAHAN,
        this.kECAMATAN,
        this.cITY,
        this.zIPCODE,
        this.pHONE,
        this.oFFICELAT,
        this.oFFICELONG});

  Data.fromJson(Map<String, dynamic> json) {
    oFFICECODE = json['OFFICE_CODE'];
    oFFICENAME = json['OFFICE_NAME'];
    oFFICEADDR = json['OFFICE_ADDR'];
    rT = json['RT'];
    rW = json['RW'];
    kELURAHAN = json['KELURAHAN'];
    kECAMATAN = json['KECAMATAN'];
    cITY = json['CITY'];
    zIPCODE = json['ZIPCODE'];
    pHONE = json['PHONE'];
    oFFICELAT = json['OFFICE_LAT'];
    oFFICELONG = json['OFFICE_LONG'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OFFICE_CODE'] = this.oFFICECODE;
    data['OFFICE_NAME'] = this.oFFICENAME;
    data['OFFICE_ADDR'] = this.oFFICEADDR;
    data['RT'] = this.rT;
    data['RW'] = this.rW;
    data['KELURAHAN'] = this.kELURAHAN;
    data['KECAMATAN'] = this.kECAMATAN;
    data['CITY'] = this.cITY;
    data['ZIPCODE'] = this.zIPCODE;
    data['PHONE'] = this.pHONE;
    data['OFFICE_LAT'] = this.oFFICELAT;
    data['OFFICE_LONG'] = this.oFFICELONG;
    return data;
  }
}
class CabangError extends CabangRespon{}