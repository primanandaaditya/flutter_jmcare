class SingleNotifikasiRespon {
  String? aGRMNTNO;
  String? dTMADD;
  String? iD;
  String? iDUSER;
  String? iSFINISHED;
  String? jAMKEDATANGAN;
  String? kANTORTUJUAN;
  String? kONFIRMASIKEDATANGAN;
  String? kUISIONERDITOLAK;
  String? kUISIONERSELESAI;
  String? nAMADEBITUR;
  String? nAMAPENGUNJUNG;
  String? nOANTRIAN;
  String? nOPLAT;
  String? pICTUJUAN;
  String? sUBKATEGORI;
  String? tGLKEDATANGAN;
  String? tIPEPENGUNJUNG;

  SingleNotifikasiRespon(
      {this.aGRMNTNO,
        this.dTMADD,
        this.iD,
        this.iDUSER,
        this.iSFINISHED,
        this.jAMKEDATANGAN,
        this.kANTORTUJUAN,
        this.kONFIRMASIKEDATANGAN,
        this.kUISIONERDITOLAK,
        this.kUISIONERSELESAI,
        this.nAMADEBITUR,
        this.nAMAPENGUNJUNG,
        this.nOANTRIAN,
        this.nOPLAT,
        this.pICTUJUAN,
        this.sUBKATEGORI,
        this.tGLKEDATANGAN,
        this.tIPEPENGUNJUNG});

  SingleNotifikasiRespon.fromJson(Map<String, dynamic> json) {
    aGRMNTNO = json['AGRMNT_NO'];
    dTMADD = json['DTMADD'];
    iD = json['ID'];
    iDUSER = json['ID_USER'];
    iSFINISHED = json['IS_FINISHED'];
    jAMKEDATANGAN = json['JAM_KEDATANGAN'];
    kANTORTUJUAN = json['KANTOR_TUJUAN'];
    kONFIRMASIKEDATANGAN = json['KONFIRMASI_KEDATANGAN'];
    kUISIONERDITOLAK = json['KUISIONER_DITOLAK'];
    kUISIONERSELESAI = json['KUISIONER_SELESAI'];
    nAMADEBITUR = json['NAMA_DEBITUR'];
    nAMAPENGUNJUNG = json['NAMA_PENGUNJUNG'];
    nOANTRIAN = json['NO_ANTRIAN'];
    nOPLAT = json['NO_PLAT'];
    pICTUJUAN = json['PIC_TUJUAN'];
    sUBKATEGORI = json['SUB_KATEGORI'];
    tGLKEDATANGAN = json['TGL_KEDATANGAN'];
    tIPEPENGUNJUNG = json['TIPE_PENGUNJUNG'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AGRMNT_NO'] = this.aGRMNTNO;
    data['DTMADD'] = this.dTMADD;
    data['ID'] = this.iD;
    data['ID_USER'] = this.iDUSER;
    data['IS_FINISHED'] = this.iSFINISHED;
    data['JAM_KEDATANGAN'] = this.jAMKEDATANGAN;
    data['KANTOR_TUJUAN'] = this.kANTORTUJUAN;
    data['KONFIRMASI_KEDATANGAN'] = this.kONFIRMASIKEDATANGAN;
    data['KUISIONER_DITOLAK'] = this.kUISIONERDITOLAK;
    data['KUISIONER_SELESAI'] = this.kUISIONERSELESAI;
    data['NAMA_DEBITUR'] = this.nAMADEBITUR;
    data['NAMA_PENGUNJUNG'] = this.nAMAPENGUNJUNG;
    data['NO_ANTRIAN'] = this.nOANTRIAN;
    data['NO_PLAT'] = this.nOPLAT;
    data['PIC_TUJUAN'] = this.pICTUJUAN;
    data['SUB_KATEGORI'] = this.sUBKATEGORI;
    data['TGL_KEDATANGAN'] = this.tGLKEDATANGAN;
    data['TIPE_PENGUNJUNG'] = this.tIPEPENGUNJUNG;
    return data;
  }
}
