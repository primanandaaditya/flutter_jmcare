import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jmcare/model/session/ShowWelcome.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/splash/state.dart';
import 'package:jmcare/storage/storage.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';
import '../../helper/Konstan.dart';
import '../../model/api/LoginRespon.dart';

class SplashLogic extends BaseLogic {

  final SplashState state = SplashState();

  @override
  void onInit() {
    super.onInit();
    SystemChrome.setEnabledSystemUIOverlays([]);
    initVideoSplash();
  }

  @override
  void onClose() {
    super.onClose();
    state.videoPlayerController!.dispose();
  }

  void initVideoSplash(){
    state.videoPlayerController=VideoPlayerController.asset(state.movie)
      ..setLooping(false)
      ..initialize().then((value) {
        state.videoPlayerController?.addListener(() {
          if(state.videoPlayerController?.value.position == state.videoPlayerController?.value.duration) {
            checkShowWelcome();
          }
        });
      });
    state.videoPlayerController!.play();
  }

  void checkShowWelcome() async {
    final storageShowWelcome = await getStorage<ShowWelcome>();
    if (storageShowWelcome.data?.showWelcome == null){
      Get.offAllNamed(Konstan.rute_welcome);
    }else{
      final sdhLogin = await sudahLogin();
      if (sdhLogin) {
        Get.offAllNamed(Konstan.rute_home);
      }else {
        Get.offAllNamed(Konstan.rute_login);
      }
    }
  }


}