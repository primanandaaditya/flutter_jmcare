
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jmcare/model/api/OtpModel.dart';
import 'package:jmcare/screens/resetpassword/verifikasiotp/state.dart';
import '../../../helper/Fungsi.dart';
import '../../../helper/Konstan.dart';
import '../../../storage/storage.dart';
import '../../base/base_otp_logic.dart';

class VerifikasiotpLogic extends BaseotpLogic{

  final VerifikasiotpState state = VerifikasiotpState();
  var counter = 60.obs;

  @override
  void onInit() {
    super.onInit();
    mulaiTimer();
  }

  @override
  void onClose() {
    super.onClose();
    if (state.countdownTimer != null){
      state.countdownTimer!.cancel();
    }
  }
  
  void mulaiTimer(){
    debugPrint("mulai timer");
    counter.value = 60;
    const detik = Duration(seconds: 1);
    state.countdownTimer = Timer.periodic(detik, (Timer timer) {
      if (counter.value == 0){
        if (state.countdownTimer!.isActive){
          state.countdownTimer!.cancel();
        }
        sendOtp();
      }else{
        counter.value --;
      }
    });
  }

  void bandingkanOTP(BuildContext context) async {
    final storage = (await getStorage<OtpModel>());
    var otp = storage.data!.otp;
    debugPrint(otp! + " " + state.tecOTP!.text.toString());
    if (otp == state.tecOTP!.text.toString()){
      if (state.countdownTimer!.isActive){
        state.countdownTimer!.cancel();
      }
      Get.toNamed(Konstan.rute_password_baru);
    }else{
      Fungsi.errorToast("OTP tidak cocok!");
    }
  }

  void gunakanMetodeLain(){
    Get.back();
  }

  void sendOtp() async {
    base_send_otp(
        state.email,
        logic_enamdua_hp.value,
        () {
          Get.snackbar(Konstan.tag_sukses, "Kode OTP berhasil dikirim");
          mulaiTimer();
        },
        () => Get.snackbar(Konstan.tag_error, "Gagal mengirimkan OTP!")
    );
  }


}
