class PertanyaanRespon {
  List<Data>? data;

  PertanyaanRespon({this.data});

  PertanyaanRespon.fromJson(Map<String, dynamic> json) {
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
  Pertanyaan? pertanyaan;
  List<SubPertanyaan>? subPertanyaan;

  Data({this.pertanyaan, this.subPertanyaan});

  Data.fromJson(Map<String, dynamic> json) {
    pertanyaan = json['pertanyaan'] != null
        ? new Pertanyaan.fromJson(json['pertanyaan'])
        : null;
    if (json['subPertanyaan'] != null) {
      subPertanyaan = <SubPertanyaan>[];
      json['subPertanyaan'].forEach((v) {
        subPertanyaan!.add(new SubPertanyaan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pertanyaan != null) {
      data['pertanyaan'] = this.pertanyaan!.toJson();
    }
    if (this.subPertanyaan != null) {
      data['subPertanyaan'] =
          this.subPertanyaan!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pertanyaan {
  String? iDFORMAT;
  String? nAMAFORMAT;
  String? pERTANYAAN;
  String? pERTANYAANCODE;

  Pertanyaan(
      {this.iDFORMAT, this.nAMAFORMAT, this.pERTANYAAN, this.pERTANYAANCODE});

  Pertanyaan.fromJson(Map<String, dynamic> json) {
    iDFORMAT = json['ID_FORMAT'];
    nAMAFORMAT = json['NAMA_FORMAT'];
    pERTANYAAN = json['PERTANYAAN'];
    pERTANYAANCODE = json['PERTANYAAN_CODE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_FORMAT'] = this.iDFORMAT;
    data['NAMA_FORMAT'] = this.nAMAFORMAT;
    data['PERTANYAAN'] = this.pERTANYAAN;
    data['PERTANYAAN_CODE'] = this.pERTANYAANCODE;
    return data;
  }
}

class SubPertanyaan {
  LabelPertanyaan? labelPertanyaan;
  List<TemplateJawaban>? templateJawaban;

  SubPertanyaan({this.labelPertanyaan, this.templateJawaban});

  SubPertanyaan.fromJson(Map<String, dynamic> json) {
    labelPertanyaan = json['labelPertanyaan'] != null
        ? new LabelPertanyaan.fromJson(json['labelPertanyaan'])
        : null;
    if (json['templateJawaban'] != null) {
      templateJawaban = <TemplateJawaban>[];
      json['templateJawaban'].forEach((v) {
        templateJawaban!.add(new TemplateJawaban.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.labelPertanyaan != null) {
      data['labelPertanyaan'] = this.labelPertanyaan!.toJson();
    }
    if (this.templateJawaban != null) {
      data['templateJawaban'] =
          this.templateJawaban!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LabelPertanyaan {
  String? iDVALUE;
  String? lABEL;
  String? pERTANYAANCODE;
  String? vALUE;

  LabelPertanyaan({this.iDVALUE, this.lABEL, this.pERTANYAANCODE, this.vALUE});

  LabelPertanyaan.fromJson(Map<String, dynamic> json) {
    iDVALUE = json['ID_VALUE'];
    lABEL = json['LABEL'];
    pERTANYAANCODE = json['PERTANYAAN_CODE'];
    vALUE = json['VALUE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_VALUE'] = this.iDVALUE;
    data['LABEL'] = this.lABEL;
    data['PERTANYAAN_CODE'] = this.pERTANYAANCODE;
    data['VALUE'] = this.vALUE;
    return data;
  }
}

class TemplateJawaban {
  String? iDOPSI;
  String? oPSI;
  String? pERTANYAANCODE;
  String? vALUEJAWABAN;

  TemplateJawaban(
      {this.iDOPSI, this.oPSI, this.pERTANYAANCODE, this.vALUEJAWABAN});

  TemplateJawaban.fromJson(Map<String, dynamic> json) {
    iDOPSI = json['ID_OPSI'];
    oPSI = json['OPSI'];
    pERTANYAANCODE = json['PERTANYAAN_CODE'];
    vALUEJAWABAN = json['VALUE_JAWABAN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_OPSI'] = this.iDOPSI;
    data['OPSI'] = this.oPSI;
    data['PERTANYAAN_CODE'] = this.pERTANYAANCODE;
    data['VALUE_JAWABAN'] = this.vALUEJAWABAN;
    return data;
  }
}

class PertanyaanError extends PertanyaanRespon{}