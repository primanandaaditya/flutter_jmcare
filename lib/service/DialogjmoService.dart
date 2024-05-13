
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/JmoRespon.dart';
import '../helper/Endpoint.dart';
import 'BaseService.dart';

class DialogjmoService extends BaseService {
  static DialogjmoService instance = DialogjmoService();
  Future<JmoRespon?> getDialog(String jenis) async{
    String payload_endpoint = "";

    switch (jenis){
      case Konstan.tag_status_nikah:
        payload_endpoint = Endpoint.TAG_JMO_STATUS_NIKAH;
        break;
      case Konstan.tag_pendidikan:
        payload_endpoint = Endpoint.TAG_JMO_PENDIDIKAN;
        break;
      case Konstan.tag_jenis_pekerjaan:
        payload_endpoint = Endpoint.TAG_JMO_JENIS_PEKERJAAN;
        break;
      default:
        payload_endpoint = Endpoint.TAG_JMO_STATUS_NIKAH;
        break;
    }
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getJMO(payload_endpoint);
    }catch(e){
      return JmoError();
    }
  }
}