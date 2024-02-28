import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'BaseService.dart';

class RegisterNonDebiturService extends BaseService{
  static RegisterNonDebiturService instance = RegisterNonDebiturService();
  Future<BaseRespon?> doRegister(
      String nama,
      String alamat,
      String hp,
      String email,
      String password,
      String pekerjaan,
      String noktp,
      String tempat,
      String tgllahir,
      String jeniskelamin
      ) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postString(Endpoint.TAG_REGISTER_NONDEBITOR, body: {
        "tipe":1,
        "id":1,
        "nama":nama,
        "alamat":alamat,
        "hp":hp,
        "email":email,
        "password":password,
        "pekerjaan":pekerjaan,
        "noktp":noktp,
        "tempat":tempat,
        "tgllahir":tgllahir,
        "jeniskelamin":jeniskelamin
      });
    }catch(e){
      return BaseError();
    }
  }
}
