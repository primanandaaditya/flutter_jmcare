import 'package:flutter/material.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_green_screen.dart';
import 'package:jmcare/screens/pin/auth/logic.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/pin/auth/state.dart';
import 'package:pinput/pinput.dart';


class AuthpinScreen extends StatelessWidget {
  const AuthpinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthpinLogic logic = Get.put(AuthpinLogic());
    final AuthpinState state = Get.find<AuthpinLogic>().state;

    return JmcareGreenScreen(
      title: "Masukkan PIN Anda",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Pinput(
            length: 6,
            controller: state.tecPIN,
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          ElevatedButton(
              onPressed: () => logic.checkPIN(),
              child: const Text(
                "Cek PIN"
              )
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          Obx(
                  () => logic.is_loading.value
                      ? Komponen.getLoadingWidget()
                      : (logic.counter.value > 0 && logic.counter.value <= 30)
                        ? Text("Menunggu (${logic.counter.value})", textAlign: TextAlign.center,)
                        : TextButton(
                            onPressed: () => logic.lupaPIN(),
                            child: const Text("Lupa PIN")
                  )
          ),

        ],
      ),
    );
  }
}
