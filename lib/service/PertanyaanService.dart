
import 'package:jmcare/model/api/PertanyaanRespon.dart';
import '../helper/Endpoint.dart';
import 'BaseService.dart';

class PertanyaanService extends BaseService {

  static PertanyaanService instance = PertanyaanService();
  Future<PertanyaanRespon?> getPertanyaan() async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getJsonArray(Endpoint.TAG_ANTRIAN_GET_PERTANYAAN);
    }catch(e){
      return PertanyaanError();
    }
  }
}