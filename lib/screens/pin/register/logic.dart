import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/session/RegisterpinModel.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pin/register/state.dart';
import 'package:jmcare/storage/storage.dart';

class RegisterpinLogic extends BaseLogic{
  final RegisterpinState state = RegisterpinState();

  void savePIN() async {
    if (state.tecPin1!.text.isEmpty || state.tecPin2!.text.isEmpty){
      Fungsi.errorToast("PIN dan pengulangannya harus diisi!");
      return;
    }
    if (state.tecPin1!.text.toString() != state.tecPin2!.text.toString()) {
      Fungsi.errorToast("PIN dan pengulangannya harus sama!");
      return;
    }
    if (state.tecPin1!.text.length < 6 || state.tecPin2!.text.length < 6){
      Fungsi.errorToast("PIN minimal 6 angka");
      return;
    }
    //simpan pin di session
    var registerpinModel = RegisterpinModel(
        sudahRegister: true,
        pin: state.tecPin1!.text.toString()
    );
    baseSaveStorage(registerpinModel);
    Fungsi.suksesToast("PIN berhasil disimpan!");
    Get.offAllNamed(Konstan.rute_home);
  }
}