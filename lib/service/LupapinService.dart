import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'BaseService.dart';

class LupapinService extends BaseService{
  static LupapinService instance = LupapinService();
  Future<BaseRespon?> lupaPIN(String email,String PIN) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postString(Endpoint.TAG_FORGET_PIN, body: {
        "email": email,
        "pin": PIN
      });
    }catch(e){
      return BaseError();
    }
  }
}
