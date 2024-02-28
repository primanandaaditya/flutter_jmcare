import 'package:flutter/cupertino.dart';
import 'package:jmcare/model/api/GradeRespon.dart';
import 'package:jmcare/model/api/HistoripoinRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/historipoin/state.dart';
import 'package:get/get.dart';
import 'package:jmcare/service/HistoripoinService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';

class HistoripoinLogic extends BaseLogic {
  final HistoripoinState state = HistoripoinState();

  var grade = "".obs;
  var point = "0".obs;
  var loading_grade = false.obs;
  var nama_user = "".obs;
  var icon_jenis_member = "".obs;
  var historipoinRespon = HistoripoinRespon().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHistoripoin();
  }

  void getHistoripoin() async {
    final storageGrade = await getStorage<GradeRespon>();
    if (storageGrade == null ){
      historipoinRespon.value.data?.clear();
    }else{
      is_loading.value = true;
      final storageUser = await getStorage<LoginRespon>();
      String ktp = storageUser.data!.noKtp!;
      final historiPoin = await getService<HistoripoinService>()?.getHistoripoin(ktp);
      if (historiPoin is HistoripoinError || historiPoin == null){
        historipoinRespon.value.data?.clear();
      }else{
        historipoinRespon.value.data = historiPoin.data;
        debugPrint('jumlah ' + historiPoin.data!.length.toString());
      }
      is_loading.value = false;
    }
  }

}