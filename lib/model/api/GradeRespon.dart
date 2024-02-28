class GradeRespon {
  List<Data>? data;

  GradeRespon({this.data});

  GradeRespon.fromJson(Map<String, dynamic> json) {
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
  String? noKtp;
  String? grade;
  int? point;

  Data({this.noKtp, this.grade, this.point});

  Data.fromJson(Map<String, dynamic> json) {
    noKtp = json['no_ktp'];
    grade = json['grade'];
    point = json['point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_ktp'] = this.noKtp;
    data['grade'] = this.grade;
    data['point'] = this.point;
    return data;
  }
}

class GradeError extends GradeRespon{}