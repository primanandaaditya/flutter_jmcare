
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/GradeRespon.dart';
import 'BaseService.dart';

class GradeService extends BaseService{

  static GradeService instance = GradeService();

  Future<GradeRespon?> getGrade(String noKTP) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getJsonArray(Endpoint.TAG_GRADE,body: {
        "noktp": noKTP
      });
    }catch(e){
      return GradeError();
    }
  }
}
