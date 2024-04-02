import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/service/BaseService.dart';
import '../helper/Endpoint.dart';

class AddantrianService extends BaseService {
  static AddantrianService instance = AddantrianService();
  Future<BaseRespon?> addAntrian(
      String ID_USER,
      String AGRMNT_NO,
      String NAMA_DEBITUR,
      String NAMA_PENGUNJUNG,
      String NO_PLAT,
      String TGL_KEDATANGAN,
      String JAM_KEDATANGAN,
      String PIC_TUJUAN,
      String TIPE_PENGUNJUNG,
      String ID_KATEGORI,
      String KANTOR_TUJUAN
      ) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postString(Endpoint.TAG_ANTRIAN_INSERT_ANTRIAN_CS, body: {
        "ID_USER":ID_USER,
        "AGRMNT_NO":AGRMNT_NO,
        "NAMA_DEBITUR":NAMA_DEBITUR,
        "NAMA_PENGUNJUNG":NAMA_PENGUNJUNG,
        "NO_PLAT":NO_PLAT,
        "TGL_KEDATANGAN":TGL_KEDATANGAN,
        "JAM_KEDATANGAN":JAM_KEDATANGAN,
        "PIC_TUJUAN":PIC_TUJUAN,
        "TIPE_PENGUNJUNG":TIPE_PENGUNJUNG,
        "ID_KATEGORI":ID_KATEGORI,
        "KANTOR_TUJUAN":KANTOR_TUJUAN
      });
    }catch(e){
      return BaseError();
    }
  }
}