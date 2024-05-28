
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/session/ResetPassModel.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/resetpassword/ceknomorhp/state.dart';
import 'package:jmcare/service/CeknomorhpService.dart';

import '../../../helper/Fungsi.dart';
import '../../../helper/Konstan.dart';
import '../../../service/Service.dart';
import '../../../storage/storage.dart';

class CeknomorhpLogic extends BaseLogic{

  final CeknomorhpState state = CeknomorhpState();

  void cekNomorHP(BuildContext context) async {
    if (state.formKey!.currentState!.validate()){
      is_loading.value = true;
      BaseRespon? baseRespon = await getService<CeknomorhpService>()!.cekNomorHP(
          state.tecNomorHP!.text.toString()
      );
      is_loading.value = false;

      if (baseRespon is BaseError || baseRespon?.code == "0"){
        Fungsi.errorToast(baseRespon!.message!);
        debugPrint('cek nomor HP gagal!');
      }else if (baseRespon?.code == "1"){
        //buat model untuk simpan no hp dan email
        ResetPassModel resetPassModel = ResetPassModel(email: baseRespon!.status, hp: state.tecNomorHP!.text.toString());
        //simpan no hp dan email di session
        baseSaveStorage<ResetPassModel>(resetPassModel);
        Get.toNamed(Konstan.rute_pilih_metode_reset_password);
      }
    }
  }

}
