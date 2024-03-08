
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/PilihkontrakRespon.dart';
import 'package:jmcare/model/api/VersiRespon.dart';
import 'BaseService.dart';

class PilihkontrakService extends BaseService{

  static PilihkontrakService instance = PilihkontrakService();

  Future<PilihkontrakRespon?> getListKontrak(String noKTP) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getJsonArray(Endpoint.TAG_PILIH_KONTRAK, body: {
        "KTPNO":noKTP
      });
    }catch(e){
      return PilihkontrakError();
    }
  }
}
