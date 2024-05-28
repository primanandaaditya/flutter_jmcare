import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_green_screen.dart';
import 'package:jmcare/screens/resetpassword/pilihmetode/logic.dart';

class PilihMetodeResetPasswordScreen extends StatelessWidget {
  const PilihMetodeResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(PilihmetodoLogic());
    final state = Get.find<PilihmetodoLogic>().state;

    return GetBuilder<PilihmetodoLogic>(
        assignId: true,
        builder: (logic){
          return JmcareGreenScreen(
            title: "Pilih Metode Reset Password",
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                 const Text("Kami akan mengirimkan 6 digit One Time Password (OTP). Silakan pilih salah satu metode di bawah ini.",
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   color: Colors.grey
                 ),
                 ),

                const Padding(padding: EdgeInsets.only(top: 10)),
                
                Obx(() {
                  return Komponen.getCardOption(
                    title: "Email",
                    subtitle: logic.logic_masked_email.value,
                    radioValue: 1,
                    groupValue: logic.group_value.value,
                    changeGroupValue: () => logic.setGroupValue(1),
                  );
                }),

                Obx(() {
                  return Komponen.getCardOption(
                    title: "SMS",
                    subtitle: logic.logic_masked_hp.value,
                    radioValue: 2,
                    groupValue: logic.group_value.value,
                    changeGroupValue: () => logic.setGroupValue(2),
                  );
                }),

                Obx(() {
                  return Komponen.getCardOption(
                    title: "Whats App",
                    subtitle: logic.logic_masked_hp.value,
                    radioValue: 3,
                    groupValue: logic.group_value.value,
                    changeGroupValue: () => logic.setGroupValue(3),
                  );
                }),

                Obx(() {
                  return Komponen.getCardOption(
                    title: "Link email",
                    subtitle: "Web",
                    radioValue: 4,
                    groupValue: logic.group_value.value,
                    changeGroupValue: () => logic.setGroupValue(4),
                  );
                }),

                const Padding(padding: EdgeInsets.only(top: 10)),

                Obx(() => logic.is_loading.value ? Komponen.getLoadingWidget() :
                  ElevatedButton(
                      onPressed: () => logic.sendOtp(),
                      child: const Text("Submit")
                  )
                )

              ],
            ),
          );
        }
    );

  }
}
