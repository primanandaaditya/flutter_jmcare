
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/AgreementcardRespon.dart';
import 'BaseService.dart';

class AgreementcardService extends BaseService{

  static AgreementcardService instance = AgreementcardService();

  Future<AgreementcardRespon?> getAgreementCard(String AgreementID) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getJsonArray(Endpoint.TAG_AGREEMENT_CARD, body: {
        "AgrmntId": AgreementID
      });
    }catch(e){
      return AgreementcardError();
    }
  }
}
