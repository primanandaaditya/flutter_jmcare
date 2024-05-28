import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/model/api/WilayahRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/dialog/wilayah/state.dart';
import 'package:get/get.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/service/WilayahService.dart';

class DialogWilayahLogic extends BaseLogic {

  final DialogWilayahState state = DialogWilayahState();
  var rowCount = 0.obs;
  var ObsWilayahResponse = WilayahRespon().obs;
  var realWilayahResponse = WilayahRespon();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //get parameter jenis dan id_master
    //yg dilempar dari screen pengkinian data (lihat logic.dialogPropinsi)
    state.jenis = Get.arguments["jenis"];
    state.id_master = Get.arguments["id_master"];
    debugPrint(state.jenis + " " + state.id_master.toString());

    //hit api
    getData();
  }

  void selectWilayah(int index) {
      Get.back(result: jsonEncode(ObsWilayahResponse.value.data![index]));
  }

  void getData() async {
    is_loading.value = true;
    final wilayahResponse = await getService<WilayahService>()?.getWilayah(state.jenis, state.id_master);
    if (wilayahResponse is WilayahError){
      rowCount.value = 0;
      Fungsi.errorToast("Tidak dapat memproses data wilayah!");
    }else{
      ObsWilayahResponse.value = wilayahResponse!;
      realWilayahResponse.data = wilayahResponse.data;
      rowCount.value = ObsWilayahResponse.value.data!.length;
    }
    is_loading.value = false;
  }

  void filter(){
    if (state.tecSearch!.text.isEmpty || state.tecSearch!.text.length == 0){
      debugPrint('nama wilayah kosong');
      ObsWilayahResponse.value.data = realWilayahResponse.data;
      rowCount.value = realWilayahResponse.data!.length;
    }else{
      debugPrint("jml real " + realWilayahResponse.data!.length.toString());
      var tmp = realWilayahResponse!.data;
      var filtered = tmp!.where(
              (x) => x.nama!.toLowerCase().contains(state.tecSearch!.text.toLowerCase())
      ).toList();
      debugPrint('nama wilayah ada!' + filtered.length.toString());
      filtered.forEach((element) {
        debugPrint(element.nama);
      });
      ObsWilayahResponse.value.data = filtered;
      rowCount.value = ObsWilayahResponse.value.data!.length;
    }
  }

}