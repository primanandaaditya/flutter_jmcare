
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/HistoripoinRespon.dart';
import 'BaseService.dart';

class HistoripoinService extends BaseService{

  static HistoripoinService instance = HistoripoinService();

  Future<HistoripoinRespon?> getHistoripoin(String noKTP) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getJsonArray(Endpoint.TAG_RIWAYAT_POIN, body: {
        "noktp":noKTP
      });
    }catch(e){
      return HistoripoinError();
    }
  }
}
