
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jmcare/model/BaseRespon.dart';
import 'package:jmcare/screens/register/debitur/state.dart';
import 'package:jmcare/service/RegisterDebiturService.dart';
import '../../../service/Service.dart';

class RegisterDebiturLogic extends GetxController{

  var is_loading = false.obs;
  var show_password_1 = true.obs;
  var show_password_2 = true.obs;
  var password_strength = false.obs;

  final RegisterDebiturState state = RegisterDebiturState();

  @override
  void onInit() {
    super.onInit();
  }

  void showHidePassword_1(){
    if (show_password_1.value){
      show_password_1.value = false;
    }else{
      show_password_1.value = true;
    }
  }

  void showHidePassword_2(){
    if (show_password_2.value){
      show_password_2.value = false;
    }else{
      show_password_2.value = true;
    }
  }

  void checkPasswordStrength(){
    password_strength.value = Fungsi.passwordCalculator(state.passwordController!.text.toString());
  }

  void doRegisterDebitur(BuildContext context) async {

    if (state.formKey!.currentState!.validate()){

      //cek apakah password dan confirm-nya sama
      if (state.passwordController!.text.toString() != state.ulangipasswordController!.text.toString()){
        Get.snackbar(Konstan.tag_error, "Password harus sama dengan pengulangannya");
        return;
      }

      if (state.emailController!.text.toString().isNotEmpty && !state.emailController!.text.toString().isEmail){
        Get.snackbar(Konstan.tag_error, "Email tidak valid");
        return;
      }

      var isStrongPassword = Fungsi.passwordCalculator(state.passwordController!.text.toString());
      if (!isStrongPassword){
        Get.snackbar(Konstan.tag_error, "Password masih belum kuat!");
        return;
      }

      is_loading.value = true;
      BaseRespon? baseRespon = await getService<RegisterDebiturService>()!.doRegister(
          state.ktpController!.text.toString(),
          state.hpController!.text.toString(),
          state.emailController!.text.toString(),
          state.passwordController!.text.toString(),
      );
      is_loading.value = false;

      if (baseRespon is BaseError || baseRespon?.code == Konstan.tag_100){
        Fungsi.showSnack(context, Konstan.tag_error, baseRespon!.message!, 2);
        debugPrint('Login gagal!');
      }else if (baseRespon?.code == Konstan.tag_200){
        Fungsi.showSnack(context, Konstan.tag_sukses, "Register berhasil, silakan login", 2);
        Get.offAllNamed(Konstan.rute_login);
      }
    }
  }

}
