import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/base/jmcare_green_screen.dart';
import 'package:jmcare/screens/pin/register/logic.dart';
import 'package:jmcare/screens/pin/register/state.dart';
import 'package:pinput/pinput.dart';

class RegisterpinScreen extends StatelessWidget {
  const RegisterpinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterpinLogic logic = Get.put(RegisterpinLogic());
    final RegisterpinState state = Get.find<RegisterpinLogic>().state;

    return GetBuilder<RegisterpinLogic>(
      assignId: true,
        builder: (logic){
          return JmcareGreenScreen(
            title: "Register PIN",
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text("Masukkan kode keamanan"),
                Padding(padding: EdgeInsets.only(top: 10)),
                Pinput(
                  length: 6,
                  controller: state.tecPin1,
                ),

                Padding(padding: EdgeInsets.only(top: 30)),
                Text("Masukkan sekali lagi"),
                Padding(padding: EdgeInsets.only(top: 10)),
                Pinput(
                  length: 6,
                  controller: state.tecPin2,
                ),

                Padding(padding: EdgeInsets.only(top: 10)),
                ElevatedButton(
                    onPressed: () => logic.savePIN(),
                    child: Text(
                      "Lanjut"
                    )
                )

              ],
            ),
          );
        }
    );
  }
}
