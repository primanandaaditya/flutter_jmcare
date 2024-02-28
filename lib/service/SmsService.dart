import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/api/SmsRespon.dart';
import 'BaseService.dart';

class SmsService extends BaseService{
  static SmsService instance = SmsService();

  Future<SmsRespon?> sendOTP(String nomorHP, String pesan) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postSMS(Endpoint.TAG_SEND_OTP + nomorHP + "/" + pesan);
    }catch(e){
      return SmsError();
    }
  }
}
