import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/model/api/JmoRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/dialog/jmo/state.dart';
import 'package:get/get.dart';
import 'package:jmcare/service/DialogjmoService.dart';
import 'package:jmcare/service/Service.dart';

class DialogjmoLogic extends BaseLogic {

  final DialogjmoState state = DialogjmoState();
  var rowCount = 0.obs;
  var obsJmoRespon = JmoRespon().obs;
  var realJmoRespon = JmoRespon();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //get parameter jenis dan id_master
    //yg dilempar dari screen pengkinian data (lihat logic.dialogJMO)
    state.jenis = Get.arguments["jenis"];

    //hit api
    getData();
  }

  void selectData(int index) {
      Get.back(result: jsonEncode(obsJmoRespon.value.data![index]));
  }

  void getData() async {
    is_loading.value = true;
    final respon = await getService<DialogjmoService>()?.getDialog(state.jenis);
    if (respon is JmoError){
      rowCount.value = 0;
      Fungsi.errorToast("Tidak dapat memproses data!");
    }else{
      obsJmoRespon.value = respon!;
      realJmoRespon.data = respon.data;
      rowCount.value = obsJmoRespon.value.data!.length;
    }
    is_loading.value = false;
  }

  void filter(){
    if (state.tecSearch!.text.isEmpty || state.tecSearch!.text.length == 0){
      debugPrint('nama kosong');
      obsJmoRespon.value.data = realJmoRespon.data;
      rowCount.value = realJmoRespon.data!.length;
    }else{
      // debugPrint("jml real " + realWilayahResponse.data!.length.toString());
      var tmp = realJmoRespon.data;
      List<Data> filtered = List<Data>.empty(growable: true);
      if (tmp!.isNotEmpty){
        final pertama = tmp.first;
        if (pertama.nama == null){
          filtered = tmp!.where(
                  (x) => x.name!.toLowerCase().contains(state.tecSearch!.text.toLowerCase())
          ).toList();
        }else{
          filtered = tmp!.where(
                  (x) => x.nama!.toLowerCase().contains(state.tecSearch!.text.toLowerCase())
          ).toList();
        }
      }

      // debugPrint('nama wilayah ada!' + filtered.length.toString());
      filtered.forEach((element) {
        debugPrint(element.nama);
      });
      obsJmoRespon.value.data = filtered;
      rowCount.value = obsJmoRespon.value.data!.length;
    }
  }

}