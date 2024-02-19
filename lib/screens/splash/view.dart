import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final movie = "assets/videos/splash.mp4";
  late VideoPlayerController _videoPlayerController;

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _videoPlayerController=VideoPlayerController.asset(movie)
      ..setLooping(false)
      ..initialize().then((value) {
        _videoPlayerController.addListener(() {
          if(_videoPlayerController.value.position == _videoPlayerController.value.duration) {
            Get.offAllNamed(Konstan.rute_login);
          }
        });
        setState(() {

        });
      });
    _videoPlayerController.play();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        body: Center(
            child: InkWell(
              onTap: (){
                Get.offAllNamed(Konstan.rute_login);
              },
              child: _videoPlayerController.value.isInitialized
                  ?
              VideoPlayer(_videoPlayerController)
                  : Container(),
            )
        )
    );
  }
}
