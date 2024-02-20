import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/pilihregister/logic.dart';
import '../../helper/Tema.dart';

class PilihRegisterScreen extends StatelessWidget {
  const PilihRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(PilihRegisterLogic());
    final state = Get.find<PilihRegisterLogic>().state;

    return GetBuilder<PilihRegisterLogic>(
      assignId: true,
        builder: (logic){
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              decoration: Tema.getBackgroundLogin() ,
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [

                  Komponen.getLogoHijau(),

                  Container(
                    padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
                    child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        elevation: 5,
                        child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [

                                ElevatedButton(onPressed: (){
                                    logic.gotoRegisterDebitur();
                                  }, child: Text(state.teksRegisterDebitur)),
                                const Padding(padding: EdgeInsets.only(top: 20)),
                                ElevatedButton(onPressed: (){
                                    logic.gotoRegisterNonDebitur();
                                  }, child: Text(state.teksRegisterNonDebitur)),
                              ],
                            )
                        )
                    ),
                  ),

                ],
              ),
            ),
          );
        }
    );
  }
}
