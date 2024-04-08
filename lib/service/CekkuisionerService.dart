import 'package:jmcare/service/BaseService.dart';

import '../helper/Endpoint.dart';
import '../model/api/BaseRespon.dart';

class CekkuisionerService extends BaseService {
  static CekkuisionerService instance = CekkuisionerService();
  Future<BaseRespon?> cekKuisioner(String userID, String idAntrian) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postQuery(Endpoint.TAG_ANTRIAN_CEK_KUISIONER, body: {
        "userID": userID,
        "idAntrian": idAntrian
      });
    }catch(e){
      return BaseError();
    }
  }
}