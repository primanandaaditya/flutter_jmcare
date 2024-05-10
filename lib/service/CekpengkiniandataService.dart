
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/service/BaseService.dart';


class CekpengkiniandataService extends BaseService {
  static CekpengkiniandataService instance = CekpengkiniandataService();
  Future<BaseRespon?> cekPengkinian(String login_user_id) async {
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postJSON(Endpoint.TAG_CEK_PENGKINIAN_DATA, body: {
        "login_user_id": login_user_id
      });
    }catch(e){
      return BaseError();
    }
  }
}