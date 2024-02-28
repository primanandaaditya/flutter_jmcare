class VersiRespon {
  List<Data>? data;

  VersiRespon({this.data});

  VersiRespon.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? appName;
  String? oS;
  String? versionName;
  String? versionCode;
  String? downloadLink;
  String? developer;
  int? isActive;
  String? dtmCrt;
  String? crtBy;

  Data(
      {this.id,
        this.appName,
        this.oS,
        this.versionName,
        this.versionCode,
        this.downloadLink,
        this.developer,
        this.isActive,
        this.dtmCrt,
        this.crtBy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    appName = json['AppName'];
    oS = json['OS'];
    versionName = json['VersionName'];
    versionCode = json['VersionCode'];
    downloadLink = json['DownloadLink'];
    developer = json['Developer'];
    isActive = json['IsActive'];
    dtmCrt = json['DtmCrt'];
    crtBy = json['CrtBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['AppName'] = this.appName;
    data['OS'] = this.oS;
    data['VersionName'] = this.versionName;
    data['VersionCode'] = this.versionCode;
    data['DownloadLink'] = this.downloadLink;
    data['Developer'] = this.developer;
    data['IsActive'] = this.isActive;
    data['DtmCrt'] = this.dtmCrt;
    data['CrtBy'] = this.crtBy;
    return data;
  }
}
class VersiError extends VersiRespon{}