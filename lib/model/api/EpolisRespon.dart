class EpolisRespon {
  String? code;
  String? message;
  String? status;
  String? key;
  String? filepath;
  String? fileurl;

  EpolisRespon(
      {this.code,
        this.message,
        this.status,
        this.key,
        this.filepath,
        this.fileurl});

  EpolisRespon.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    status = json['status'];
    key = json['Key'];
    filepath = json['filepath'];
    fileurl = json['fileurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['status'] = this.status;
    data['Key'] = this.key;
    data['filepath'] = this.filepath;
    data['fileurl'] = this.fileurl;
    return data;
  }
}
class EpolisError extends EpolisRespon{}