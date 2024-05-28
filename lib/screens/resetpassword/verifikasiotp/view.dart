import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_green_screen.dart';
import 'package:jmcare/screens/resetpassword/verifikasiotp/logic.dart';
import 'package:pinput/pinput.dart';

class VerifikasiotpScreen extends StatelessWidget {
  const VerifikasiotpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(VerifikasiotpLogic());
    final state = Get.find<VerifikasiotpLogic>().state;

    return GetBuilder<VerifikasiotpLogic>(
      assignId: true,
        builder: (logic){

        return JmcareGreenScreen(
          title: "VERIFIKASI OTP",
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Pinput(
                length: 6,
                controller: logic.state.tecOTP,
              ),

              const Padding(padding: EdgeInsets.only(top: 20)),

              TextButton(
                  onPressed: (){
                    logic.bandingkanOTP(context);
                  },
                  child: const Text("VERIFIKASI")
              ),

              TextButton(
                  onPressed: (){
                    logic.gunakanMetodeLain();
                  },
                  child: const Text("Gunakan metode lain")
              ),

              const Text("OTP akan dikirimkan kembali dalam :"
              ,style: TextStyle(
                  color: Colors.grey
                ),
                textAlign: TextAlign.center,
              ),

              const Padding(padding: EdgeInsets.only(top: 5)),

              Obx(() => logic.is_loading.value ? Komponen.getLoadingWidget() :
                Text(
                  logic.counter.value.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20
                  ),
                )
              )

            ],
          ),
        );
      }
    );
  }
}
