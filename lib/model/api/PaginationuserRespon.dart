class PaginationuserRespon {
  List<Data>? data;

  PaginationuserRespon({this.data});

  PaginationuserRespon.fromJson(Map<String, dynamic> json) {
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
  String? loginUserId;
  String? email;
  String? grade;
  String? point;
  String? jenisKelamin;
  String? namaUser;
  String? noKtp;
  String? tempatLahir;
  String? tglLahir;
  String? isAdmin;
  String? jenisDebitur;

  Data(
      {this.loginUserId,
        this.email,
        this.grade,
        this.point,
        this.jenisKelamin,
        this.namaUser,
        this.noKtp,
        this.tempatLahir,
        this.tglLahir,
        this.isAdmin,
        this.jenisDebitur});

  Data.fromJson(Map<String, dynamic> json) {
    loginUserId = json['login_user_id'];
    email = json['email'];
    grade = json['grade'];
    point = json['point'];
    jenisKelamin = json['jenis_kelamin'];
    namaUser = json['nama_user'];
    noKtp = json['no_ktp'];
    tempatLahir = json['tempat_lahir'];
    tglLahir = json['tgl_lahir'];
    isAdmin = json['is_admin'];
    jenisDebitur = json['jenis_debitur'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login_user_id'] = this.loginUserId;
    data['email'] = this.email;
    data['grade'] = this.grade;
    data['point'] = this.point;
    data['jenis_kelamin'] = this.jenisKelamin;
    data['nama_user'] = this.namaUser;
    data['no_ktp'] = this.noKtp;
    data['tempat_lahir'] = this.tempatLahir;
    data['tgl_lahir'] = this.tglLahir;
    data['is_admin'] = this.isAdmin;
    data['jenis_debitur'] = this.jenisDebitur;
    return data;
  }
}
class PaginationuserError extends PaginationuserRespon{}