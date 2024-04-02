class RiwayatantrianRespon {
  List<Data>? data;

  RiwayatantrianRespon({this.data});

  RiwayatantrianRespon.fromJson(Map<String, dynamic> json) {
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
  String? aGRMNTNO;
  String? dTMADD;
  int? iD;
  int? iDKATEGORI;
  String? iDUSER;
  String? iSFINISHED;
  String? jAMKEDATANGAN;
  String? kANTORTUJUAN;
  String? kONFIRMASIKEDATANGAN;
  String? nAMADEBITUR;
  String? nAMAPENGUNJUNG;
  String? nOANTRIAN;
  String? nOPLAT;
  String? oFFICELAT;
  String? oFFICELONG;
  String? oFFICENAME;
  String? pICTUJUAN;
  int? sUDAHKADALUWARSA;
  int? sUDAHKUISIONER;
  String? tANGGAL;
  String? tGLKEDATANGAN;
  String? tIPEPENGUNJUNG;
  String? tUJUANKEDATANGAN;

  Data(
      {this.aGRMNTNO,
        this.dTMADD,
        this.iD,
        this.iDKATEGORI,
        this.iDUSER,
        this.iSFINISHED,
        this.jAMKEDATANGAN,
        this.kANTORTUJUAN,
        this.kONFIRMASIKEDATANGAN,
        this.nAMADEBITUR,
        this.nAMAPENGUNJUNG,
        this.nOANTRIAN,
        this.nOPLAT,
        this.oFFICELAT,
        this.oFFICELONG,
        this.oFFICENAME,
        this.pICTUJUAN,
        this.sUDAHKADALUWARSA,
        this.sUDAHKUISIONER,
        this.tANGGAL,
        this.tGLKEDATANGAN,
        this.tIPEPENGUNJUNG,
        this.tUJUANKEDATANGAN});

  Data.fromJson(Map<String, dynamic> json) {
    aGRMNTNO = json['AGRMNT_NO'];
    dTMADD = json['DTM_ADD'];
    iD = json['ID'];
    iDKATEGORI = json['ID_KATEGORI'];
    iDUSER = json['ID_USER'];
    iSFINISHED = json['IS_FINISHED'];
    jAMKEDATANGAN = json['JAM_KEDATANGAN'];
    kANTORTUJUAN = json['KANTOR_TUJUAN'];
    kONFIRMASIKEDATANGAN = json['KONFIRMASI_KEDATANGAN'];
    nAMADEBITUR = json['NAMA_DEBITUR'];
    nAMAPENGUNJUNG = json['NAMA_PENGUNJUNG'];
    nOANTRIAN = json['NO_ANTRIAN'];
    nOPLAT = json['NO_PLAT'];
    oFFICELAT = json['OFFICE_LAT'];
    oFFICELONG = json['OFFICE_LONG'];
    oFFICENAME = json['OFFICE_NAME'];
    pICTUJUAN = json['PIC_TUJUAN'];
    sUDAHKADALUWARSA = json['SUDAH_KADALUWARSA'];
    sUDAHKUISIONER = json['SUDAH_KUISIONER'];
    tANGGAL = json['TANGGAL'];
    tGLKEDATANGAN = json['TGL_KEDATANGAN'];
    tIPEPENGUNJUNG = json['TIPE_PENGUNJUNG'];
    tUJUANKEDATANGAN = json['TUJUAN_KEDATANGAN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AGRMNT_NO'] = this.aGRMNTNO;
    data['DTM_ADD'] = this.dTMADD;
    data['ID'] = this.iD;
    data['ID_KATEGORI'] = this.iDKATEGORI;
    data['ID_USER'] = this.iDUSER;
    data['IS_FINISHED'] = this.iSFINISHED;
    data['JAM_KEDATANGAN'] = this.jAMKEDATANGAN;
    data['KANTOR_TUJUAN'] = this.kANTORTUJUAN;
    data['KONFIRMASI_KEDATANGAN'] = this.kONFIRMASIKEDATANGAN;
    data['NAMA_DEBITUR'] = this.nAMADEBITUR;
    data['NAMA_PENGUNJUNG'] = this.nAMAPENGUNJUNG;
    data['NO_ANTRIAN'] = this.nOANTRIAN;
    data['NO_PLAT'] = this.nOPLAT;
    data['OFFICE_LAT'] = this.oFFICELAT;
    data['OFFICE_LONG'] = this.oFFICELONG;
    data['OFFICE_NAME'] = this.oFFICENAME;
    data['PIC_TUJUAN'] = this.pICTUJUAN;
    data['SUDAH_KADALUWARSA'] = this.sUDAHKADALUWARSA;
    data['SUDAH_KUISIONER'] = this.sUDAHKUISIONER;
    data['TANGGAL'] = this.tANGGAL;
    data['TGL_KEDATANGAN'] = this.tGLKEDATANGAN;
    data['TIPE_PENGUNJUNG'] = this.tIPEPENGUNJUNG;
    data['TUJUAN_KEDATANGAN'] = this.tUJUANKEDATANGAN;
    return data;
  }
}
class RiwayatantrianError extends RiwayatantrianRespon{}