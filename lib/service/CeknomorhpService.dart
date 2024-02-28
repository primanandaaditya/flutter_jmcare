import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import '../model/api/LoginRespon.dart';
import 'BaseService.dart';

class CeknomorhpService extends BaseService{

  static CeknomorhpService instance = CeknomorhpService();

  Future<BaseRespon?> cekNomorHP(String nomorHP) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postString(Endpoint.TAG_RESET_PASSWORD_CEK_NOMOR_HP, body: {
        "jenisdebitur": "1",
        "hp": nomorHP
      });
    }catch(e){
      return BaseError();
    }
  }
}
