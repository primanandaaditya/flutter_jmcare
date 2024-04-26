
import 'package:jmcare/model/api/NotifikasiRespon.dart';
import 'package:jmcare/service/BaseService.dart';

import '../helper/Endpoint.dart';

class NotifikasiService extends BaseService {
  static NotifikasiService instance = NotifikasiService();
  Future<NotifikasiRespon?> getNotifikasi(String id_user,String waktu_notifikasi) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getJsonArray(Endpoint.TAG_ANTRIAN_NOTIFIKASI_KUISIONER, body: {
        "id_user": id_user,
        "waktu_notifikasi": waktu_notifikasi
      });
    }catch(e){
      return NotifikasiError();
    }
  }
}