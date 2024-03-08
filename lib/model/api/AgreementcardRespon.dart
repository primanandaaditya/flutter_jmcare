class AgreementcardRespon {
  List<Data>? data;

  AgreementcardRespon({this.data});

  AgreementcardRespon.fromJson(Map<String, dynamic> json) {
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
  String? bUSSDATE;
  String? cUSTNAME;
  String? aGRMNTNO;
  String? cURRNAME;
  String? cONTRACTSTAT;
  double? pREPAIDAMT;
  double? vISITFEE;
  double? rEPOFEE;
  double? pICKUPFEE;
  double? oSLCINST;
  double? lCINSTPAIDAMTAAM;
  String? dUEDT;
  int? iNSTSEQNO;
  double? iNSTAMT;
  String? iNSTPAIDDATE;
  double? iNSTPAIDAMT;
  double? oUTSTANDING;
  double? lCINSTPAIDAMT;
  int? lCDAY;
  String? oFFICENAME;
  String? aSSETTYPE;

  Data(
      {this.bUSSDATE,
        this.cUSTNAME,
        this.aGRMNTNO,
        this.cURRNAME,
        this.cONTRACTSTAT,
        this.pREPAIDAMT,
        this.vISITFEE,
        this.rEPOFEE,
        this.pICKUPFEE,
        this.oSLCINST,
        this.lCINSTPAIDAMTAAM,
        this.dUEDT,
        this.iNSTSEQNO,
        this.iNSTAMT,
        this.iNSTPAIDDATE,
        this.iNSTPAIDAMT,
        this.oUTSTANDING,
        this.lCINSTPAIDAMT,
        this.lCDAY,
        this.oFFICENAME,
        this.aSSETTYPE});

  Data.fromJson(Map<String, dynamic> json) {
    bUSSDATE = json['BUSSDATE'];
    cUSTNAME = json['CUST_NAME'];
    aGRMNTNO = json['AGRMNT_NO'];
    cURRNAME = json['CURRNAME'];
    cONTRACTSTAT = json['CONTRACT_STAT'];
    pREPAIDAMT = json['PREPAID_AMT'];
    vISITFEE = json['VISIT_FEE'];
    rEPOFEE = json['REPO_FEE'];
    pICKUPFEE = json['PICKUP_FEE'];
    oSLCINST = json['OS_LC_INST'];
    lCINSTPAIDAMTAAM = json['LC_INST_PAID_AMT_AAM'];
    dUEDT = json['DUE_DT'];
    iNSTSEQNO = json['INST_SEQ_NO'];
    iNSTAMT = json['INST_AMT'];
    iNSTPAIDDATE = json['INST_PAID_DATE'];
    iNSTPAIDAMT = json['INST_PAID_AMT'];
    oUTSTANDING = json['OUTSTANDING'];
    lCINSTPAIDAMT = json['LC_INST_PAID_AMT'];
    lCDAY = json['LC_DAY'];
    oFFICENAME = json['OFFICE_NAME'];
    aSSETTYPE = json['ASSET_TYPE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BUSSDATE'] = this.bUSSDATE;
    data['CUST_NAME'] = this.cUSTNAME;
    data['AGRMNT_NO'] = this.aGRMNTNO;
    data['CURRNAME'] = this.cURRNAME;
    data['CONTRACT_STAT'] = this.cONTRACTSTAT;
    data['PREPAID_AMT'] = this.pREPAIDAMT;
    data['VISIT_FEE'] = this.vISITFEE;
    data['REPO_FEE'] = this.rEPOFEE;
    data['PICKUP_FEE'] = this.pICKUPFEE;
    data['OS_LC_INST'] = this.oSLCINST;
    data['LC_INST_PAID_AMT_AAM'] = this.lCINSTPAIDAMTAAM;
    data['DUE_DT'] = this.dUEDT;
    data['INST_SEQ_NO'] = this.iNSTSEQNO;
    data['INST_AMT'] = this.iNSTAMT;
    data['INST_PAID_DATE'] = this.iNSTPAIDDATE;
    data['INST_PAID_AMT'] = this.iNSTPAIDAMT;
    data['OUTSTANDING'] = this.oUTSTANDING;
    data['LC_INST_PAID_AMT'] = this.lCINSTPAIDAMT;
    data['LC_DAY'] = this.lCDAY;
    data['OFFICE_NAME'] = this.oFFICENAME;
    data['ASSET_TYPE'] = this.aSSETTYPE;
    return data;
  }
}
class AgreementcardError extends AgreementcardRespon{}