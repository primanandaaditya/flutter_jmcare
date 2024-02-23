class LoginRespon {
  String? code;
  String? message;
  String? status;
  String? email;
  String? grade;
  String? isAdmin;
  String? jenisKelamin;
  String? jenisdebitur;
  String? loginUserId;
  String? namaUser;
  String? noHp;
  String? noKk;
  String? noKtp;
  String? password;
  String? tempatLahir;
  String? tglLahir;

  LoginRespon(
      {this.code,
        this.message,
        this.status,
        this.email,
        this.grade,
        this.isAdmin,
        this.jenisKelamin,
        this.jenisdebitur,
        this.loginUserId,
        this.namaUser,
        this.noHp,
        this.noKk,
        this.noKtp,
        this.password,
        this.tempatLahir,
        this.tglLahir});

  LoginRespon.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    status = json['status'];
    email = json['email'];
    grade = json['grade'];
    isAdmin = json['is_admin'];
    jenisKelamin = json['jenis_kelamin'];
    jenisdebitur = json['jenisdebitur'];
    loginUserId = json['login_user_id'];
    namaUser = json['nama_user'];
    noHp = json['no_hp'];
    noKk = json['no_kk'];
    noKtp = json['no_ktp'];
    password = json['password'];
    tempatLahir = json['tempat_lahir'];
    tglLahir = json['tgl_lahir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['status'] = this.status;
    data['email'] = this.email;
    data['grade'] = this.grade;
    data['is_admin'] = this.isAdmin;
    data['jenis_kelamin'] = this.jenisKelamin;
    data['jenisdebitur'] = this.jenisdebitur;
    data['login_user_id'] = this.loginUserId;
    data['nama_user'] = this.namaUser;
    data['no_hp'] = this.noHp;
    data['no_kk'] = this.noKk;
    data['no_ktp'] = this.noKtp;
    data['password'] = this.password;
    data['tempat_lahir'] = this.tempatLahir;
    data['tgl_lahir'] = this.tglLahir;
    return data;
  }
}
class LoginBegin extends LoginRespon{}
class LoginLoading extends LoginRespon{}
class LoginError extends LoginRespon{}