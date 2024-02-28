
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/screens/base/base_register_logic.dart';
import 'package:jmcare/screens/register/nondebitur/state.dart';
import 'package:jmcare/service/RegisterNonDebiturService.dart';
import '../../../service/Service.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class RegisterNonDebiturLogic extends BaseRegisterLogic{

  final RegisterNonDebiturState state = RegisterNonDebiturState();

  @override
  void onInit() {
    super.onInit();
    state.jeniskelaminController!.text = "1";
  }

  void tapTanggalLahir(BuildContext context){
    DatePicker.showDatePicker(context,
      showTitleActions: true,
      onChanged: (date){
          setTanggalLahir(date);
      },
      onConfirm: (date){
          setTanggalLahir(date);
      },
      currentTime: DateTime.now(), locale: LocaleType.en
    );
  }

  void setTanggalLahir(DateTime date){
    state.tgllahirController!.text = "${date.year}-${date.month}-${date.day}";
  }

  void setValue_DDJenisKelamin(dynamic newValue){
    String nv = newValue.toString();
    print('nv ' + nv);
    state.jeniskelaminController!.text = nv;
  }

  void doRegisterNonDebitur(BuildContext context) async {

    if (state.formKey!.currentState!.validate()){

      //cek apakah password dan confirm-nya sama
      if (state.passwordController!.text.toString() != state.ulangipasswordController!.text.toString()){
        Get.snackbar(Konstan.tag_error, "Password harus sama dengan pengulangannya");
        return;
      }
      //cek apakah email diisi dan validasinya
      if (state.emailController!.text.toString().isNotEmpty && !state.emailController!.text.toString().isEmail){
        Get.snackbar(Konstan.tag_error, "Email tidak valid");
        return;
      }
      //cek kekuatan password
      var isStrongPassword = Fungsi.passwordCalculator(state.passwordController!.text.toString());
      if (!isStrongPassword){
        Get.snackbar(Konstan.tag_error, "Password masih belum kuat!");
        return;
      }

      is_loading.value = true;
      BaseRespon? baseRespon = await getService<RegisterNonDebiturService>()!.doRegister(
          state.namaController!.text.toString(),
          state.alamatController!.text.toString(),
          state.hpController!.text.toString(),
          state.emailController!.text.toString(),
          state.passwordController!.text.toString(),
          state.pekerjaanController!.text.toString(),
          state.ktpController!.text.toString(),
          state.tempatController!.text.toString(),
          state.tgllahirController!.text.toString(),
          state.jeniskelaminController!.text.toString()
      );
      is_loading.value = false;

      if (baseRespon is BaseError || baseRespon?.code == "0"){
        Fungsi.errorToast("Registrasi gagal!");
        debugPrint('Register gagal!');
      }else if (baseRespon?.code == Konstan.tag_200 || baseRespon?.message == 'Data berhasil disimpan'){
        Fungsi.errorToast("Registrasi berhasil");
        Get.offAllNamed(Konstan.rute_login);
      }
    }
  }

}
