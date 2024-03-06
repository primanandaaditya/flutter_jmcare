
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/login/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../model/api/LoginRespon.dart';
import '../../service/LoginService.dart';
import '../../service/Service.dart';


class LoginLogic extends BaseLogic{

  var show_password = true.obs;
  final LoginState state = LoginState();

  @override
  void onInit() {
    super.onInit();
  }

  void showHidePassword(){
    if (show_password.value){
      show_password.value = false;
    }else{
      show_password.value = true;
    }
  }

  void doLogin(BuildContext context) async {
    if (state.formKey!.currentState!.validate()){
      is_loading.value = true;
      LoginRespon? loginRespon = await getService<LoginService>()!.doLogin(
          state.usernameController!.text.toString(),
          state.passwordController!.text.toString()
      );
      is_loading.value = false;

      if (loginRespon is LoginError || loginRespon?.code == Konstan.tag_100){
        Fungsi.errorToast("Login gagal! Email/password salah, atau akun sudah dihapus!");
        debugPrint('Login gagal!');
      }else if (loginRespon?.code == Konstan.tag_200){
        baseSaveStorage<LoginRespon>(loginRespon);
        Get.offAllNamed(Konstan.rute_register_pin);
      }
    }
  }

  void gotoHome(){
    Get.offAllNamed(Konstan.rute_home);
  }

  void pilihRegister(){
    Get.toNamed(Konstan.rute_pilih_register);
  }

  void resetPassword(){
    Get.toNamed(Konstan.rute_cek_nomor_hp);
  }

}
