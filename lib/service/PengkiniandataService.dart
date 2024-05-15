import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class PengkiniandataService extends BaseService {
  static PengkiniandataService instance = PengkiniandataService();
  Future<BaseRespon?> doPengkinian(
      String login_user_id,
      String no_ktp,
      String nama,
      String alamat,
      String no_hp,
      String tempat,
      String tgl_lahir,
      String pekerjaan,
      String alamat_rt,
      String alamat_rw,
      String kelurahan,
      String kecamatan,
      String kabupaten,
      String provinsi,
      String npwp,
      String nama_ibu_kandung,
      String pendidikan_terakhir,
      String status_pernikahan,
      String jumlah_tanggungan,
      String alamat_kantor,
      String telp_kantor,
      String setuju_penawaran,
      String kewarganegaraan,
      String foto_ktp,
      String foto_profil,
      String foto_tanda_tangan
      ) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postJSON(Endpoint.TAG_PENGKINIAN_DATA, body: {
        "login_user_id": login_user_id,
        "no_ktp": no_ktp,
        "nama": nama,
        "alamat": alamat,
        "no_hp": no_hp,
        "tempat": tempat,
        "tgl_lahir": tgl_lahir,
        "pekerjaan": pekerjaan,
        "alamat_rt": alamat_rt,
        "alamat_rw": alamat_rw,
        "kelurahan": kelurahan,
        "kecamatan": kecamatan,
        "kabupaten": kabupaten,
        "provinsi": provinsi,
        "npwp": npwp,
        "nama_ibu_kandung": nama_ibu_kandung,
        "pendidikan_terakhir": pendidikan_terakhir,
        "status_pernikahan": status_pernikahan,
        "jumlah_tanggungan": jumlah_tanggungan,
        "alamat_kantor": alamat_kantor,
        "telp_kantor": telp_kantor,
        "setuju_penawaran": setuju_penawaran,
        "kewarganegaraan": kewarganegaraan,
        "foto_ktp": foto_ktp,
        "foto_profil": foto_profil,
        "foto_tanda_tangan": foto_tanda_tangan
      });
    }catch(e){
      return BaseError();
    }
  }
}