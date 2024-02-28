import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'logic.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final logic = Get.put(WelcomeLogic());
    final state = Get.find<WelcomeLogic>().state;

    return GetBuilder<WelcomeLogic>(
      assignId: true,
        builder: (logic){
          return Scaffold(
            body: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              child: Text(
                                state.lewati,
                                style: const TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              onPressed: (){
                                logic.gotoHome();
                              },
                            )
                        )
                    ),

                    Expanded(
                        flex: 1,
                        child: Image.asset("assets/images/selamatdatang.png")
                    ),
                    Expanded(
                        flex: 5,
                        child: CarouselSlider(
                            items: state.getCarousel(),
                            options: state.getCarouselOption()
                        )
                    ),

                    Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            child: const Text(
                              "Sudah punya akun? Login disini",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 13
                              ),
                            ),
                            onPressed: (){
                              logic.gotoLogin();
                            },
                          ),
                        )
                    ),
                  ],
                )
            ),
          );
        }
    );
  }
}
