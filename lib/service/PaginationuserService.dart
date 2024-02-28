
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/PaginationuserRespon.dart';
import 'package:jmcare/model/api/VersiRespon.dart';
import 'BaseService.dart';

class PaginationuserService extends BaseService{

  static PaginationuserService instance = PaginationuserService();

  Future<PaginationuserRespon?> getUser(int halaman) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getResources(Endpoint.TAG_PAGINATION_USER, body: {
        "halaman":halaman
      });
    }catch(e){
      return PaginationuserError();
    }
  }
}
