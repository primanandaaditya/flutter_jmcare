import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jmcare/model/session/SelectedMethod.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/storage/storage.dart';
import '../../helper/Fungsi.dart';
import '../../helper/Konstan.dart';
import '../../model/api/BaseRespon.dart';
import '../../model/api/OtpModel.dart';
import '../../model/api/SmsRespon.dart';
import '../../service/OtpemailService.dart';
import '../../service/OtpwaService.dart';
import '../../service/Service.dart';
import '../../service/SmsService.dart';

class BaseotpLogic extends BaseLogic{

  var logic_masked_email = "".obs;
  var logic_masked_hp = "".obs;
  var logic_enamdua_hp = "".obs;

  void generate_and_save_OTP() async {
    var otp = Fungsi.generateOTP(6);
    OtpModel otpModel = OtpModel(otp: otp);
    baseSaveStorage<OtpModel>(otpModel);
  }

  void base_send_otp(
      String email,
      String enamduaHP,
      Function onOtpSukses,
      Function onOtpGagal,
      ) async{

    is_loading.value = true;
    generate_and_save_OTP();

    final otpModel = await getStorage<OtpModel>();
    String otp = otpModel.data!.otp!;
    print("Generate OTP $otp");

    final storage = await getStorage<SelectedMethod>();
    int selectedMethod;
    if (storage.data!.selectedMethod == null){
      selectedMethod = 1;
    }else{
      selectedMethod = storage.data!.selectedMethod!;
    }

    switch (selectedMethod){

      case 1:
        BaseRespon? baseRespon = await getService<OtpemailService>()!.sendOTP(
            email, otp
        );
        is_loading.value = false;
        if (baseRespon is BaseError || baseRespon?.code == Konstan.tag_100 || baseRespon?.status != 'Success'){
          onOtpGagal();
        }else{
          onOtpSukses();
        }
        break;

      case 2:
        SmsRespon? smsRespon = await getService<SmsService>()!.sendOTP(
            enamduaHP,
            "Kode OTP adalah " + otp + ". Jangan beritahukan kode ini kepada orang lain".replaceAll(" ", "_")
        );
        is_loading.value = false;
        if (smsRespon is SmsError){
          onOtpGagal();
        }else{
          onOtpSukses();
        }
        break;

      case 3:
        BaseRespon? baseRespon = await getService<OtpwaService>()!.sendOTP(
            enamduaHP, otp
        );
        is_loading.value = false;
        if (baseRespon is BaseError || baseRespon?.code == Konstan.tag_100 || baseRespon?.status != 'OK'){
          onOtpGagal();
        }else{
          onOtpSukses();
        }
        break;

      case 4:
        is_loading.value = false;
        Get.toNamed(Konstan.rute_reset_password_webview);
    }
  }

}