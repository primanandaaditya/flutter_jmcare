
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/VersiRespon.dart';
import 'BaseService.dart';

class VersiService extends BaseService{

  static VersiService instance = VersiService();

  Future<VersiRespon?> getVersion() async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getJsonArray(Endpoint.TAG_VERSION);
    }catch(e){
      return VersiError();
    }
  }
}
