
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/CabangRespon.dart';
import 'BaseService.dart';

class CabangService extends BaseService{

  static CabangService instance = CabangService();

  Future<CabangRespon?> getCabang() async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getJsonArray(Endpoint.TAG_LIST_CABANG);
    }catch(e){
      return CabangError();
    }
  }
}
