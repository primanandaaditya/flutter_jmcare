import 'package:get/get.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/storage/storage.dart';

import '../../helper/Fungsi.dart';

class BaseRegisterLogic extends BaseLogic{

  var show_password_1 = true.obs;
  var show_password_2 = true.obs;
  var password_strength = false.obs;

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

  void checkPasswordStrength(String password){
    password_strength.value = Fungsi.passwordCalculator(password);
  }


}