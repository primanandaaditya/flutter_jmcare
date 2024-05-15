class LoginRespon {
  String? code;
  String? message;
  String? status;
  String? alamat;
  String? alamatKantor;
  String? alamatRt;
  String? alamatRw;
  String? email;
  String? fotoKtp;
  String? fotoProfil;
  String? fotoTandaTangan;
  String? grade;
  String? isAdmin;
  String? jenisKelamin;
  String? jenisdebitur;
  String? jumlahTanggungan;
  String? kabupaten;
  String? kecamatan;
  String? kelurahan;
  String? kewarganegaraan;
  String? loginUserId;
  String? namaIbuKandung;
  String? namaUser;
  String? noHp;
  String? noKk;
  String? noKtp;
  String? npwp;
  String? password;
  String? pekerjaan;
  String? pendidikanTerakhir;
  String? provinsi;
  String? setujuPenawaran;
  String? statusPernikahan;
  String? tagPengkinianData;
  String? tanggalPengkinianData;
  String? telpKantor;
  String? tempatLahir;
  String? tglLahir;

  LoginRespon(
      {this.code,
        this.message,
        this.status,
        this.alamat,
        this.alamatKantor,
        this.alamatRt,
        this.alamatRw,
        this.email,
        this.fotoKtp,
        this.fotoProfil,
        this.fotoTandaTangan,
        this.grade,
        this.isAdmin,
        this.jenisKelamin,
        this.jenisdebitur,
        this.jumlahTanggungan,
        this.kabupaten,
        this.kecamatan,
        this.kelurahan,
        this.kewarganegaraan,
        this.loginUserId,
        this.namaIbuKandung,
        this.namaUser,
        this.noHp,
        this.noKk,
        this.noKtp,
        this.npwp,
        this.password,
        this.pekerjaan,
        this.pendidikanTerakhir,
        this.provinsi,
        this.setujuPenawaran,
        this.statusPernikahan,
        this.tagPengkinianData,
        this.tanggalPengkinianData,
        this.telpKantor,
        this.tempatLahir,
        this.tglLahir});

  LoginRespon.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    status = json['status'];
    alamat = json['alamat'];
    alamatKantor = json['alamat_kantor'];
    alamatRt = json['alamat_rt'];
    alamatRw = json['alamat_rw'];
    email = json['email'];
    fotoKtp = json['foto_ktp'];
    fotoProfil = json['foto_profil'];
    fotoTandaTangan = json['foto_tanda_tangan'];
    grade = json['grade'];
    isAdmin = json['is_admin'];
    jenisKelamin = json['jenis_kelamin'];
    jenisdebitur = json['jenisdebitur'];
    jumlahTanggungan = json['jumlah_tanggungan'];
    kabupaten = json['kabupaten'];
    kecamatan = json['kecamatan'];
    kelurahan = json['kelurahan'];
    kewarganegaraan = json['kewarganegaraan'];
    loginUserId = json['login_user_id'];
    namaIbuKandung = json['nama_ibu_kandung'];
    namaUser = json['nama_user'];
    noHp = json['no_hp'];
    noKk = json['no_kk'];
    noKtp = json['no_ktp'];
    npwp = json['npwp'];
    password = json['password'];
    pekerjaan = json['pekerjaan'];
    pendidikanTerakhir = json['pendidikan_terakhir'];
    provinsi = json['provinsi'];
    setujuPenawaran = json['setuju_penawaran'];
    statusPernikahan = json['status_pernikahan'];
    tagPengkinianData = json['tag_pengkinian_data'];
    tanggalPengkinianData = json['tanggal_pengkinian_data'];
    telpKantor = json['telp_kantor'];
    tempatLahir = json['tempat_lahir'];
    tglLahir = json['tgl_lahir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['status'] = this.status;
    data['alamat'] = this.alamat;
    data['alamat_kantor'] = this.alamatKantor;
    data['alamat_rt'] = this.alamatRt;
    data['alamat_rw'] = this.alamatRw;
    data['email'] = this.email;
    data['foto_ktp'] = this.fotoKtp;
    data['foto_profil'] = this.fotoProfil;
    data['foto_tanda_tangan'] = this.fotoTandaTangan;
    data['grade'] = this.grade;
    data['is_admin'] = this.isAdmin;
    data['jenis_kelamin'] = this.jenisKelamin;
    data['jenisdebitur'] = this.jenisdebitur;
    data['jumlah_tanggungan'] = this.jumlahTanggungan;
    data['kabupaten'] = this.kabupaten;
    data['kecamatan'] = this.kecamatan;
    data['kelurahan'] = this.kelurahan;
    data['kewarganegaraan'] = this.kewarganegaraan;
    data['login_user_id'] = this.loginUserId;
    data['nama_ibu_kandung'] = this.namaIbuKandung;
    data['nama_user'] = this.namaUser;
    data['no_hp'] = this.noHp;
    data['no_kk'] = this.noKk;
    data['no_ktp'] = this.noKtp;
    data['npwp'] = this.npwp;
    data['password'] = this.password;
    data['pekerjaan'] = this.pekerjaan;
    data['pendidikan_terakhir'] = this.pendidikanTerakhir;
    data['provinsi'] = this.provinsi;
    data['setuju_penawaran'] = this.setujuPenawaran;
    data['status_pernikahan'] = this.statusPernikahan;
    data['tag_pengkinian_data'] = this.tagPengkinianData;
    data['tanggal_pengkinian_data'] = this.tanggalPengkinianData;
    data['telp_kantor'] = this.telpKantor;
    data['tempat_lahir'] = this.tempatLahir;
    data['tgl_lahir'] = this.tglLahir;
    return data;
  }
}

class LoginBegin extends LoginRespon{}
class LoginLoading extends LoginRespon{}
class LoginError extends LoginRespon{}