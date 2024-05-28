import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_green_screen.dart';
import 'package:jmcare/screens/resetpassword/passwordbaru/logic.dart';

import '../../../helper/Konstan.dart';

class PasswordbaruScreen extends StatelessWidget {
  const PasswordbaruScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(PasswordbaruLogic());
    final state = Get.find<PasswordbaruLogic>().state;

    return GetBuilder<PasswordbaruLogic>(
      assignId: true,
        builder: (logic){
        return JmcareGreenScreen(
          title: "UBAH PASSWORD",
          body: Form(
            key: state.formKey,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Obx(() {
                  return TextFormField(
                    onChanged: ((e) => logic.checkPasswordStrength(e)),
                    controller: state.tecPassword,
                    obscureText: logic.show_password_1.value,
                    decoration:  InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(onPressed: (){
                          logic.showHidePassword_1();
                        },
                            icon: logic.show_password_1.value ? const Icon(Icons.remove_red_eye) : const Icon(Icons.remove_red_eye_outlined))
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Konstan.tagrequired;
                      }
                      return null;
                    },
                  );
                }),

                const Padding(padding: EdgeInsets.only(top: 5)),

                const Padding(padding: EdgeInsets.only(left: 10),
                  child: Text("Password harus mengandung huruf besar, huruf kecil dan angka.", style: TextStyle(fontSize: 10),),
                ),

                const Padding(padding: EdgeInsets.only(top: 5)),

                Obx(() {
                  return Padding(padding: const EdgeInsets.only(
                      left: 10),
                      child: Text(
                          logic.password_strength.value
                              ? "Password kuat"
                              : "Password lemah",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: logic.password_strength.value ? Colors.green : Colors.red,
                              fontSize: 10)
                      )
                  );
                }),

                const Padding(padding: EdgeInsets.only(top: 10)),
                Obx(() {
                  return TextFormField(

                    controller: state.tecUlangpassword,
                    obscureText: logic.show_password_2.value,
                    decoration:  InputDecoration(
                        labelText: "Ulangi password",
                        suffixIcon: IconButton(onPressed: (){
                          logic.showHidePassword_2();
                        },
                            icon: logic.show_password_2.value ? const Icon(Icons.remove_red_eye) : const Icon(Icons.remove_red_eye_outlined))
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Konstan.tagrequired;
                      }
                      return null;
                    },
                  );
                }),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Obx(() => logic.is_loading.value ? Komponen.getLoadingWidget() :  ElevatedButton(
                    onPressed: (){
                      logic.ubahPassword(context);
                    },
                    child: const Text("UBAH"))
                )

              ],
            ),
          )
        );
        }
    );
  }
}
