import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import '../../helper/Konstan.dart';
import 'logic.dart';
import '../../helper/Tema.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(LoginLogic());
    final state = Get.find<LoginLogic>().state;

    return GetBuilder<LoginLogic>(
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
                                const Text(
                                  "MASUK DALAM AKUN ANDA",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.only(top: 40)),
                                TextFormField(
                                  controller: state.usernameController,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.account_circle),
                                      labelText: "Username"
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return Konstan.tagrequired;
                                    }
                                    return null;
                                  },

                                ),

                                Obx(() {
                                  return TextFormField(
                                    controller: state.passwordController,
                                    obscureText: logic.show_password.value,
                                    decoration:  InputDecoration(
                                        labelText: "Password",
                                        suffixIcon: IconButton(onPressed: (){
                                          logic.showHidePassword();
                                        },
                                            icon: logic.show_password.value ? const Icon(Icons.remove_red_eye) : const Icon(Icons.remove_red_eye_outlined))
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
                                      logic.doLogin(context);
                                    }, child: const Text("Login")),),

                                TextButton(
                                    onPressed: (){
                                      logic.pilihRegister();
                                    },
                                    child: const Text(
                                      "Belum punya akun? Register di sini",
                                      style: TextStyle(
                                          fontSize: 12
                                      ),
                                    )
                                ),

                                TextButton(
                                    onPressed: (){
                                      Navigator.popAndPushNamed(context, "/home");
                                    },
                                    child: const Text(
                                      "Jelajahi JMCare sekarang",
                                      style: TextStyle(
                                          fontSize: 12
                                      ),
                                    )
                                ),

                                TextButton(
                                    onPressed: (){
                                      Navigator.pushNamed(context, "/lupapassword");
                                    },
                                    child: const Text(
                                      "Lupa password",
                                      style: TextStyle(
                                          fontSize: 12
                                      ),
                                    )
                                )
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
