
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/screens/login/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../model/LoginRespon.dart';
import '../../service/LoginService.dart';
import '../../service/Service.dart';
import '../../storage/storage.dart';


class LoginLogic extends GetxController{

  var is_loading = false.obs;
  var show_password = true.obs;
  final LoginState state = LoginState();

  @override
  void onInit() {
    super.onInit();
    loadStorage();
  }

  void loadStorage() async {
    final storageAuth = await getStorage<LoginRespon>();

    if(storageAuth.data?.loginUserId != null){
      debugPrint('Email ${storageAuth.data!.email!}');
      Get.offAllNamed(Konstan.rute_home);
    }else{
      debugPrint('Email tidak ada' );
    }
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
        Fungsi.showSnack(context, Konstan.tag_error, "Login gagal", 2);
        debugPrint('Login gagal!');
      }else if (loginRespon?.code == Konstan.tag_200){
        final storage = (await getStorage<LoginRespon>());
        storage.setData(loginRespon);
        storage.save();
        Get.offAllNamed(Konstan.rute_home);
      }
    }
  }

  void pilihRegister(){
    Get.toNamed(Konstan.rute_pilih_register);
  }

  void resetPassword(){
    Get.toNamed(Konstan.rute_cek_nomor_hp);
  }

}
