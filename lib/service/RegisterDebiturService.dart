import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'BaseService.dart';

class RegisterDebiturService extends BaseService{
  static RegisterDebiturService instance = RegisterDebiturService();
  Future<BaseRespon?> doRegister(String noKTP,String noHP, String email, String password) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postString(Endpoint.TAG_REGISTER_DEBITUR, body: {
        "no_ktp": noKTP,
        "no_hp": noHP,
        "register_email": email,
        "register_password": password,
      });
    }catch(e){
      return BaseError();
    }
  }
}
