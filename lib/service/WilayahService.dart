
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/service/BaseService.dart';

import '../model/api/WilayahRespon.dart';

class WilayahService extends BaseService {
  static WilayahService instance = WilayahService();
  Future<WilayahRespon?> getWilayah(String jenis,int id_master) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getResources(Endpoint.TAG_WILAYAH_INDONESIA, body: {
        "jenis": jenis,
        "id_master": id_master
      });
    }catch(e){
      return WilayahError();
    }
  }
}