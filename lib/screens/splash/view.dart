import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jmcare/screens/splash/logic.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SplashLogic());
    final state = Get.find<SplashLogic>().state;
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    //  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    //   SystemUiOverlay.top
    // ]);

    return GetBuilder<SplashLogic>(
      assignId: true,
        builder: (logic){
        return Scaffold(
          body: Center(
            child: VideoPlayer(state.videoPlayerController!),
          ),
        );
        }
    );
  }
}
