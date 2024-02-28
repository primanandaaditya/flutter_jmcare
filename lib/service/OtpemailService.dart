import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'BaseService.dart';

class OtpemailService extends BaseService{
  static OtpemailService instance = OtpemailService();
  Future<BaseRespon?> sendOTP(String email,String pin) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postString(Endpoint.TAG_RESET_PASSWORD_OTP_BY_EMAIL, body: {
        "email": email,
        "pin": pin
      });
    }catch(e){
      return BaseError();
    }
  }
}
