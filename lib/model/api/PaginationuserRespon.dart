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
  String? alamatKantor;
  String? alamatRt;
  String? alamatRw;
  String? fotoKtp;
  String? fotoProfil;
  String? fotoTandaTangan;
  String? jumlahTanggungan;
  String? kecamatan;
  String? kelurahan;
  String? kabupaten;
  String? provinsi;
  String? kewarganegaraan;
  String? namaIbuKandung;
  String? noHp;
  String? npwp;
  String? pendidikanTerakhir;
  String? setujuPenawaran;
  String? statusPernikahan;
  int? tagPengkinianData;
  String? tanggalPengkinianData;
  String? telpKantor;

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
        this.jenisDebitur,
        this.alamatKantor,
        this.alamatRt,
        this.alamatRw,
        this.fotoKtp,
        this.fotoProfil,
        this.fotoTandaTangan,
        this.jumlahTanggungan,
        this.kecamatan,
        this.kelurahan,
        this.kabupaten,
        this.provinsi,
        this.kewarganegaraan,
        this.namaIbuKandung,
        this.noHp,
        this.npwp,
        this.pendidikanTerakhir,
        this.setujuPenawaran,
        this.statusPernikahan,
        this.tagPengkinianData,
        this.tanggalPengkinianData,
        this.telpKantor});

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
    alamatKantor = json['alamat_kantor'];
    alamatRt = json['alamat_rt'];
    alamatRw = json['alamat_rw'];
    fotoKtp = json['foto_ktp'];
    fotoProfil = json['foto_profil'];
    fotoTandaTangan = json['foto_tanda_tangan'];
    jumlahTanggungan = json['jumlah_tanggungan'];
    kecamatan = json['kecamatan'];
    kelurahan = json['kelurahan'];
    kabupaten = json['kabupaten'];
    provinsi = json['provinsi'];
    kewarganegaraan = json['kewarganegaraan'];
    namaIbuKandung = json['nama_ibu_kandung'];
    noHp = json['no_hp'];
    npwp = json['npwp'];
    pendidikanTerakhir = json['pendidikan_terakhir'];
    setujuPenawaran = json['setuju_penawaran'];
    statusPernikahan = json['status_pernikahan'];
    tagPengkinianData = json['tag_pengkinian_data'];
    tanggalPengkinianData = json['tanggal_pengkinian_data'];
    telpKantor = json['telp_kantor'];
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
    data['alamat_kantor'] = this.alamatKantor;
    data['alamat_rt'] = this.alamatRt;
    data['alamat_rw'] = this.alamatRw;
    data['foto_ktp'] = this.fotoKtp;
    data['foto_profil'] = this.fotoProfil;
    data['foto_tanda_tangan'] = this.fotoTandaTangan;
    data['jumlah_tanggungan'] = this.jumlahTanggungan;
    data['kecamatan'] = this.kecamatan;
    data['kelurahan'] = this.kelurahan;
    data['kabupaten'] = this.kabupaten;
    data['provinsi'] = this.provinsi;
    data['kewarganegaraan'] = this.kewarganegaraan;
    data['nama_ibu_kandung'] = this.namaIbuKandung;
    data['no_hp'] = this.noHp;
    data['npwp'] = this.npwp;
    data['pendidikan_terakhir'] = this.pendidikanTerakhir;
    data['setuju_penawaran'] = this.setujuPenawaran;
    data['status_pernikahan'] = this.statusPernikahan;
    data['tag_pengkinian_data'] = this.tagPengkinianData;
    data['tanggal_pengkinian_data'] = this.tanggalPengkinianData;
    data['telp_kantor'] = this.telpKantor;
    return data;
  }
}

class PaginationuserError extends PaginationuserRespon{}