import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/register/debitur/logic.dart';
import '../../../helper/Komponen.dart';
import '../../../helper/Konstan.dart';
import '../../../helper/Tema.dart';

class RegisterDebiturScreen extends StatelessWidget {
  const RegisterDebiturScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(RegisterDebiturLogic());
    final state = Get.find<RegisterDebiturLogic>().state;

    return GetBuilder<RegisterDebiturLogic>(
      assignId: true,
      builder: (logic) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: Tema.getBackgroundLogin() ,
            padding: const EdgeInsets.all(20),
            child: Form(
              key: state.formKey,
              child: ListView(
                children: [

                  Container(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: ConstrainedBox(
                          constraints: const BoxConstraints.expand(
                              height: 150
                          ),
                          child: Image.asset("assets/images/jmcare_hijau.png")
                      )
                  ),

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
                              children: [
                                const Text(
                                  "REGISTER DEBITUR",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.only(top: 40)),
                                TextFormField(
                                  controller: state.ktpController,
                                  maxLength: 16,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.credit_card),
                                      labelText: "Nomor KTP"
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return Konstan.tagrequired;
                                    }
                                    return null;
                                  },
                                ),

                                TextFormField(
                                  controller: state.hpController,
                                  maxLength: 16,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.phone_android),
                                      labelText: "Nomor HP"
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return Konstan.tagrequired;
                                    }
                                    return null;
                                  },
                                ),

                                TextFormField(
                                  controller: state.emailController,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.mail),
                                      labelText: "Email"
                                  ),
                                ),

                                Obx(() {
                                  return TextFormField(
                                    controller: state.passwordController,
                                    obscureText: logic.show_password_1.value,
                                    decoration:  InputDecoration(
                                        labelText: "Password",
                                        suffixIcon: IconButton(onPressed: (){
                                          logic.showHidePassword_1();
                                        },
                                            icon: logic.show_password_1.value ? Icon(Icons.remove_red_eye) : Icon(Icons.remove_red_eye_outlined))
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return Konstan.tagrequired;
                                      }
                                      return null;
                                    },
                                  );
                                }),

                                Obx(() {
                                  return TextFormField(
                                    controller: state.ulangipasswordController,
                                    obscureText: logic.show_password_2.value,
                                    decoration:  InputDecoration(
                                        labelText: "Ulangi password",
                                        suffixIcon: IconButton(onPressed: (){
                                          logic.showHidePassword_2();
                                        },
                                            icon: logic.show_password_2.value ? Icon(Icons.remove_red_eye) : Icon(Icons.remove_red_eye_outlined))
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return Konstan.tagrequired;
                                      }
                                      return null;
                                    },
                                  );
                                }),

                                const Padding(padding: EdgeInsets.only(top: 20)),

                                Obx(() =>  logic.is_loading.value == true ? Komponen.getLoadingWidget():
                                  ElevatedButton(onPressed: (){
                                      logic.doRegisterDebitur(context);
                                    }, child: const Text("REGISTER")),),

                              ],
                            )
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
