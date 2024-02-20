
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/register/nondebitur/logic.dart';
import '../../../helper/Komponen.dart';
import '../../../helper/Konstan.dart';
import '../../../helper/Tema.dart';

class RegisterNonDebiturScreen extends StatelessWidget {
  const RegisterNonDebiturScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(RegisterNonDebiturLogic());
    final state = Get.find<RegisterNonDebiturLogic>().state;

    return GetBuilder<RegisterNonDebiturLogic>(
      assignId: true,
      builder: (logic) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
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
                                  "REGISTER NON DEBITUR",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),

                                const Padding(padding: EdgeInsets.only(top: 40)),

                                TextFormField(
                                  controller: state.namaController,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.man),
                                      labelText: "Nama"
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return Konstan.tagrequired;
                                    }
                                    return null;
                                  },
                                ),

                                TextFormField(
                                  controller: state.alamatController,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.home),
                                      labelText: "Alamat"
                                  ),
                                ),

                                TextFormField(
                                  buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
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
                                  buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
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

                                TextFormField(
                                  controller: state.pekerjaanController,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.sensor_occupied),
                                      labelText: "Pekerjaan"
                                  ),
                                ),

                                TextFormField(
                                  controller: state.tempatController,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.home),
                                      labelText: "Tempat lahir"
                                  ),
                                ),

                                TextFormField(
                                  controller: state.tgllahirController,
                                  readOnly: true,
                                  onTap: (() => logic.tapTanggalLahir(context)),
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.calendar_month),
                                      labelText: "Tanggal lahir"
                                  ),
                                ),

                                DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                        labelText: "Jenis kelamin"
                                    ),
                                    items: state.ddJenisKelamin,
                                    onChanged: (newValue){
                                      logic.setValue_DDJenisKelamin(newValue);
                                    }
                                ),
                                
                                Obx(() {
                                  return TextFormField(
                                    onChanged: ((e) => logic.checkPasswordStrength()),
                                    controller: state.passwordController,
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

                                Obx(() {
                                  return TextFormField(
                                    controller: state.ulangipasswordController,
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

                                const Padding(padding: EdgeInsets.only(top: 20)),

                                Obx(() =>  logic.is_loading.value == true ? Komponen.getLoadingWidget():
                                ElevatedButton(onPressed: (){
                                  logic.doRegisterNonDebitur(context);
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
