
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_green_screen.dart';
import 'package:jmcare/screens/resetpassword/ceknomorhp/logic.dart';
import '../../../helper/Konstan.dart';

class CeknomorhpScreen extends StatelessWidget {
  const CeknomorhpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(CeknomorhpLogic());
    final state = Get.find<CeknomorhpLogic>().state;

    return GetBuilder<CeknomorhpLogic>(
      assignId: true,
        builder: (logic){
          return JmcareGreenScreen(
            title: "Masukkan Nomor HP Anda",
            body: Form(
              key: state.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: state.tecNomorHP,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.phone_android),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Konstan.tagrequired;
                      }
                      return null;
                    },
                  ),

                  const Padding(padding: EdgeInsets.only(top: 10)),

                  Obx(() => logic.is_loading.value ? Komponen.getLoadingWidget() :
                    TextButton(
                        onPressed: (){
                          logic.cekNomorHP(context);
                        },
                        child: const Text("Submit")
                    )
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
