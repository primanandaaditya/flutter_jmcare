import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/session/ShowWelcome.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/welcome/state.dart';

class WelcomeLogic extends BaseLogic {

  final WelcomeState state = WelcomeState();

  @override
  void onInit() {
    super.onInit();
    setWelcomeAlreadyShow();
  }

  void setWelcomeAlreadyShow(){
    ShowWelcome welcome = ShowWelcome(showWelcome: true);
    baseSaveStorage(welcome);
  }

  void gotoHome(){
    Get.offAllNamed(Konstan.rute_home);
  }
  void gotoLogin(){
    Get.offAllNamed(Konstan.rute_login);
  }
}