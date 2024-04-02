
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/service/BaseService.dart';

import '../model/api/RiwayatantrianRespon.dart';

class RiwayatantrianService extends BaseService {
  static RiwayatantrianService instance = RiwayatantrianService();
  Future<RiwayatantrianRespon?> getRiwayatantrian(String userID) async {
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getResource(Endpoint.TAG_ANTRIAN_GETANTRIAN_ONLINE, body: {
        "id": userID
      });
    }catch(e){
      return RiwayatantrianError();
    }
  }
}