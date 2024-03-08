import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/EpolisRespon.dart';
import 'BaseService.dart';

class EpolisService extends BaseService{
  static EpolisService instance = EpolisService();
  Future<EpolisRespon?> getEpolis(String agreementNo,String userID) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postString(Endpoint.TAG_GETEPOLIS, body: {
        "AgreementNo": agreementNo,
        "Userid":userID}
      );
    }catch(e){
      return EpolisError();
    }
  }
}
