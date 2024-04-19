import 'package:jmcare/service/BaseService.dart';
import '../helper/Endpoint.dart';
import '../model/api/AntriansekarangRespon.dart';

class AntriansekarangService extends BaseService {
  static AntriansekarangService instance = AntriansekarangService();
  Future<AntriansekarangRespon?> getAntrianSekarang(String user_id) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getJsonArray(Endpoint.TAG_ANTRIAN_GETANTRIAN_SEKARANG, body: {
        "id_user": user_id
      });
    }catch(e){
      return AntriansekarangError();
    }
  }
}