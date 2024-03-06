import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/GradeRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/model/api/PaginationuserRespon.dart';
import 'package:jmcare/model/session/RegisterpinModel.dart';
import 'package:jmcare/model/session/ResetPassModel.dart';
import 'package:jmcare/model/session/SelectedMethod.dart';
import 'package:jmcare/service/DeleteakunService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/Komponen.dart';
import '../../model/api/SlideshowRespon.dart';

class BaseLogic extends GetxController{

  var is_loading = false.obs;

  Future<bool> sudahRegisterPIN() async {
    final registerPINStorage = await getStorage<RegisterpinModel>();
    if (registerPINStorage.data == null ){
      return false;
    }else{
      if (registerPINStorage.data!.sudahRegister == false){
        return false;
      }else{
        return true;
      }
    }
  }

  Future<String> getPIN() async{
    final registerPINstorage = await getStorage<RegisterpinModel>();
    if (registerPINstorage.data == null){
      return "";
    }else{
      final String pin = registerPINstorage.data!.pin!;
      return pin;
    }
  }

  Future<bool> sudahLogin() async {
    final storageAuth = await getStorage<LoginRespon>();
    if(storageAuth.data?.loginUserId != null){
      return true;
    }else{
      return false;
    }
  }

  void baseSaveStorage<T>(T? model) async {
    final storage = (await getStorage<T>());
    storage.setData(model);
    storage.save();
  }

  void doLogout(BuildContext context) async{
    await dialogLogout(context);
  }

  void clearSP() async{
    LoginRespon lr = LoginRespon();
    baseSaveStorage<LoginRespon>(lr);
    ResetPassModel rpm = ResetPassModel();
    baseSaveStorage<ResetPassModel>(rpm);
    SelectedMethod sm = SelectedMethod();
    baseSaveStorage<SelectedMethod>(sm);
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  Future<bool?> dialogLogout(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: true, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Apakah Anda yakin akan logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ya'),
              onPressed: () async {
                clearSP();
                Get.offNamedUntil(Konstan.rute_splash, (route) => false);
              },
            ),
            TextButton(
              child: const Text('Tidak'),
              onPressed: ()  {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> dialogSwitchAccount(
      BuildContext context,
      PaginationuserRespon respon,
      int index
      ) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: true, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ganti akun'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Apakah Anda yakin akan logout dan ganti akun?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak'),
              onPressed: ()  {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () async {
                //clear session
                clearSP();
                //buat class LoginRespon dari pagination class
                LoginRespon lr = LoginRespon(
                  code: "200",
                  message: "Ganti akun",
                  status: "",
                  email: respon.data?[index].email,
                  grade: respon.data?[index].grade,
                  isAdmin: "0",
                  jenisKelamin: respon.data?[index].jenisKelamin,
                  jenisdebitur: respon.data?[index].jenisDebitur,
                  loginUserId: respon.data?[index].loginUserId,
                  namaUser: respon.data?[index].namaUser,
                  noHp: "",
                  tempatLahir: respon.data?[index].tempatLahir,
                  tglLahir: respon.data?[index].tglLahir,
                  noKk: respon.data?[index].noKtp,
                  noKtp: respon.data?[index].noKtp
                );
                //simpan loginrespon tadi di session
                baseSaveStorage<LoginRespon>(lr);
                //restart aplikasi ke splash screen
                Get.offNamedUntil(Konstan.rute_splash, (route) => false);
              },
            ),
          ],
        );
      },
    );
  }


  List<Widget> konversi(SlideshowRespon slideshowRespon){
    List<Widget> hasil = List<Widget>.empty(growable: true);
    slideshowRespon.data?.forEach((e) {
      hasil.add(Komponen.slideBox(e.imgUrl!));
    });
    return hasil;
  }

  void setGradePoint(String gambar, int point) async{
    var gradeStorage = await getStorage<GradeRespon>();
    if (gradeStorage == null){
      debugPrint('tidak ada di storage');
      point = 0;
      gambar = '';
    }else{
      var first = gradeStorage.data!.data!.first;
      point = first.point!.toString().isEmpty ? 0 : first.point!;
      String jenisMember =first.grade!;

      if (jenisMember.toLowerCase() == Konstan.tag_gold) {
        gambar = "assets/images/gold.png";
      } else if (jenisMember.toLowerCase() == Konstan.tag_bronze) {
        gambar = "assets/images/bronze.png";
      } else if (jenisMember.toLowerCase() == Konstan.tag_silver) {
        gambar = "assets/images/platinum.png";
      } else if (jenisMember.toLowerCase() == Konstan.tag_platinum) {
        gambar = "assets/images/platinum.png";
      } else {
        gambar = "";
      }
    }
  }

}