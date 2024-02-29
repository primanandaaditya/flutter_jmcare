
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/PaginationuserRespon.dart';
import 'package:jmcare/model/api/VersiRespon.dart';
import 'BaseService.dart';

class SearchuserService extends BaseService{

  static SearchuserService instance = SearchuserService();

  Future<PaginationuserRespon?> getUser(String searchKey) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getResources(Endpoint.TAG_SEARCH_USER, body: {
        "nama":searchKey
      });
    }catch(e){
      return PaginationuserError();
    }
  }
}
