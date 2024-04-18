class SubmitjawabanRequest {
  String? iDANTRIAN;
  int? uSERID;
  String? pERTANYAANCODE;
  String? vALUEID;
  String? jAWABAN;

  SubmitjawabanRequest(
      {this.iDANTRIAN,
        this.uSERID,
        this.pERTANYAANCODE,
        this.vALUEID,
        this.jAWABAN});

  SubmitjawabanRequest.fromJson(Map<String, dynamic> json) {
    iDANTRIAN = json['ID_ANTRIAN'];
    uSERID = json['USERID'];
    pERTANYAANCODE = json['PERTANYAAN_CODE'];
    vALUEID = json['VALUE_ID'];
    jAWABAN = json['JAWABAN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_ANTRIAN'] = this.iDANTRIAN;
    data['USERID'] = this.uSERID;
    data['PERTANYAAN_CODE'] = this.pERTANYAANCODE;
    data['VALUE_ID'] = this.vALUEID;
    data['JAWABAN'] = this.jAWABAN;
    return data;
  }
}
