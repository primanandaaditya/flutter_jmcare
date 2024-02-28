class SmsRespon {
  String? sendSMSResult;

  SmsRespon({this.sendSMSResult});

  SmsRespon.fromJson(Map<String, dynamic> json) {
    sendSMSResult = json['sendSMSResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sendSMSResult'] = this.sendSMSResult;
    return data;
  }
}
class SmsError extends SmsRespon{}