import 'package:jmcare/helper/Endpoint.dart';
import '../model/api/LoginRespon.dart';
import 'BaseService.dart';

class LoginService extends BaseService{
  static LoginService instance = LoginService();
  Future<LoginRespon?> doLogin(String email,String password) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postString(Endpoint.login, body: {
        "email": email,
        "password": password
      });
    }catch(e){
      return LoginError();
    }
  }
}
