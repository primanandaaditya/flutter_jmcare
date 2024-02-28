import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'BaseService.dart';

class ResetpasswordService extends BaseService{
  static ResetpasswordService instance = ResetpasswordService();
  Future<BaseRespon?> resetPass(String email,String newPassword) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postString(Endpoint.TAG_RESET_PASSWORD, body: {
        "tipe":0,
        "jenis_user":1,
        "email":email,
        "password":newPassword
      });
    }catch(e){
      return BaseError();
    }
  }
}
