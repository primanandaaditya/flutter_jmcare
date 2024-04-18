import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/service/BaseService.dart';
import '../helper/Endpoint.dart';

class SubmitjawabanService extends BaseService{
  static SubmitjawabanService instance = SubmitjawabanService();
  Future<BaseRespon?> doSubmit(String request) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postRawString(Endpoint.TAG_ANTRIAN_SUBMIT_JAWABAN, request);
    }catch(e){
      return BaseError();
    }
  }
}