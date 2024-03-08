import 'dart:async';

import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pin/auth/state.dart';
import 'package:jmcare/service/LupapinService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';
import 'package:flutter/material.dart';


class AuthpinLogic extends BaseLogic{
  final AuthpinState state = AuthpinState();

  var counter = 31.obs;

  void mulaiTimer(){
    debugPrint("mulai timer");
    counter.value = 31;
    const detik = Duration(seconds: 1);
    state.countdownTimer = Timer.periodic(detik, (Timer timer) {
      if (counter.value == 0){
        if (state.countdownTimer!.isActive){
          state.countdownTimer!.cancel();
        }
      }else{
        counter.value --;
      }
    });
  }

  void lupaPIN() async {
    is_loading.value = true;
    final authStorage = await getStorage<LoginRespon>();
    String email = authStorage.data!.email!;
    final savedPIN = await getPIN();
    final baseRespon = await getService<LupapinService>()?.lupaPIN(email, savedPIN);
    if (baseRespon is BaseError){
      Fungsi.errorToast("Gagal mengirimkan PIN!");
    }else{
      mulaiTimer();
      Fungsi.suksesToast(baseRespon!.message!);
    }
    is_loading.value = false;
  }

  void checkPIN() async{
    if (state.tecPIN!.text.isEmpty){
      Fungsi.errorToast("PIN harus diisi!");
      return;
    }
    if (state.tecPIN!.text.length < 6){
      Fungsi.errorToast("PIN minimal 6 angka");
      return;
    }
    final String savedPIN = await getPIN();
    if (savedPIN == state.tecPIN!.text.toString()){
      Get.offAllNamed(Konstan.rute_home);
    }else{
      Fungsi.errorToast("PIN tidak cocok!");
    }
  }
}