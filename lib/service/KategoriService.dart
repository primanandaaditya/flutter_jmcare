
import 'package:jmcare/model/api/KategoriRespon.dart';
import 'package:jmcare/service/BaseService.dart';
import '../helper/Endpoint.dart';

class KategoriService extends BaseService{
  static KategoriService instance = KategoriService();
  Future<KategoriRespon?> getKategori(String jenisPIC) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getJsonArray(Endpoint.TAG_ANTRIAN_KATEGORI + "/" + jenisPIC);
    }catch(e){
      return KategoriError();
    }
  }
}