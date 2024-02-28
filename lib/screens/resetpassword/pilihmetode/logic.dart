
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/api/OtpModel.dart';
import 'package:jmcare/model/session/ResetPassModel.dart';
import 'package:jmcare/model/session/SelectedMethod.dart';
import 'package:jmcare/model/api/SmsRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/base/base_otp_logic.dart';
import 'package:jmcare/screens/resetpassword/pilihmetode/state.dart';
import 'package:jmcare/service/OtpemailService.dart';
import 'package:jmcare/service/OtpwaService.dart';
import 'package:jmcare/service/SmsService.dart';
import '../../../helper/Fungsi.dart';
import '../../../helper/Konstan.dart';
import '../../../service/Service.dart';
import '../../../storage/storage.dart';


//di extend dari
class PilihmetodoLogic extends BaseotpLogic{

  final PilihmetodeState state = PilihmetodeState();

  var group_value = 1.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    initSelectedMethod();
    loadStorage();
  }

  //fungsi ini untuk menentukan metode default pemilihan metode otp adalah via email
  void initSelectedMethod() async{
    SelectedMethod selectedMethod = SelectedMethod(selectedMethod: 1);
    baseSaveStorage<SelectedMethod>(selectedMethod);
  }

  //ambil data nomor hp dan email dari session
  void loadStorage() async {
    final storage = await getStorage<ResetPassModel>();
    if(storage.data?.email != null || storage.data?.hp != null){
      state.email = storage.data?.email;
      state.hp = storage.data?.hp;
      logic_enamdua_hp.value  =  Fungsi.enamDua(state.hp!);
      logic_masked_email.value = Fungsi.bintang(state.email!);
      logic_masked_hp.value = Fungsi.bintang(state.hp!);
    }else{
      state.email = "";
      state.hp = "";
      logic_enamdua_hp.value = "";
      logic_masked_email.value = "";
      logic_masked_hp.value = "";
      debugPrint('Email dan HP tidak ada' );
    }
  }

  //diexecute saat user mengklik semua radio button di screen pilih metode reset password
  //1=email,2=sms,3=wa,4=webview
  void setGroupValue(int selectedRadioValue) async {
    selectedRadioValue ??= 1;
    group_value.value = selectedRadioValue;
    print(group_value.value.toString());
    //simpan di session tiap kali user klik radio button
    SelectedMethod selectedMethod = SelectedMethod(selectedMethod: selectedRadioValue);
    baseSaveStorage<SelectedMethod>(selectedMethod);
  }

  //diexecute saat user klik tombol Submit
  void sendOtp() async {
    base_send_otp(
        state.email!,
        logic_enamdua_hp.value,
        () {
            Get.snackbar(Konstan.tag_sukses, "Kode OTP berhasil dikirim");
            Get.toNamed(Konstan.rute_verifikasi_otp);
        },
        () => Get.snackbar(Konstan.tag_error, "Gagal mengirimkan OTP")
    );
  }

}
