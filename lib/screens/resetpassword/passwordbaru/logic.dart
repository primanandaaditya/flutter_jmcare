import 'package:flutter/material.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/session/ResetPassModel.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/base/base_register_logic.dart';
import 'package:jmcare/screens/resetpassword/passwordbaru/state.dart';
import 'package:jmcare/service/ResetpasswordService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';
import 'package:get/get.dart';

//diextend dari BaseRegisterLogic
class PasswordbaruLogic extends BaseRegisterLogic{

  final PasswordbaruState state = PasswordbaruState();

  void ubahPassword(BuildContext context) async{

    if (state.formKey!.currentState!.validate()){

      var isStrongPassword = Fungsi.passwordCalculator(state.tecPassword!.text.toString());
      if (!isStrongPassword){
        Get.snackbar(Konstan.tag_error, "Password belum kuat!");
        return;
      }

      if (state.tecPassword!.text.toString() == state.tecUlangpassword!.text.toString()){
        is_loading.value = true;
        var rp = await getStorage<ResetPassModel>();
        final email = rp.data!.email;
        BaseRespon? baseRespon = await getService<ResetpasswordService>()?.resetPass(
            email!,
            state.tecPassword!.text.toString()
        );
        is_loading.value = false;

        if (baseRespon is BaseError || baseRespon!.status != "OK"){
          Fungsi.errorToast("Gagal mengubah password");
        }else{
          Fungsi.suksesToast(baseRespon!.message!);
          Get.offAllNamed(Konstan.rute_login);
        }
      }else{
        Fungsi.errorToast("Password tidak sama");
        return;
      }
    }
  }
}