
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/service/BaseService.dart';
import '../helper/Endpoint.dart';

class KonfirmasikedatanganService extends BaseService {
  static KonfirmasikedatanganService instance = KonfirmasikedatanganService();
  Future<BaseRespon?> konfirmasiKedatangan(String id_antrian) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postString(Endpoint.TAG_ANTRIAN_KONFIRMASI_KEDATANGAN, body: {
        "id": id_antrian
      });
    }catch(e){
      return BaseError();
    }
  }
}