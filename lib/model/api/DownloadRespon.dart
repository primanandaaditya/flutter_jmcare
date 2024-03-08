class DownloadRespon {
  bool? status;
  String? filename;
  String? fileurl;

  DownloadRespon({this.status, this.filename, this.fileurl});

  DownloadRespon.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    filename = json['filename'];
    fileurl = json['fileurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['filename'] = this.filename;
    data['fileurl'] = this.fileurl;
    return data;
  }
}
