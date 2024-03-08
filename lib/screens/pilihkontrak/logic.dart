import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/model/api/PilihkontrakRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pilihkontrak/state.dart';
import 'package:jmcare/service/PilihkontrakService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';

import '../../helper/Konstan.dart';

class PilihkontrakLogic extends BaseLogic{
  final PilihkontrakState state = PilihkontrakState();
  var pilihKontrak = PilihkontrakRespon().obs;
  var realKontrak = PilihkontrakRespon();
  var jmlRow = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getListKontrak();
  }

  void detail(int index){
    Get.toNamed(
        Konstan.rute_agreement_card,
        arguments: {'detail': pilihKontrak.value.data![index].aGRMNTID}
    );
  }

  void getListKontrak() async {
    is_loading.value = true;
    final authStorage = await getStorage<LoginRespon>();
    final String noKTP = authStorage.data!.noKtp!;
    final respon = await getService<PilihkontrakService>()?.getListKontrak(noKTP);
    if (respon is PilihkontrakError){
      Fungsi.errorToast("Tidak dapat menampilkan nomor kontrak!");
      jmlRow.value = 0;
    }else{
      pilihKontrak.value = respon!;
      realKontrak.data = respon.data;
      jmlRow.value = realKontrak.data!.length;
    }
    is_loading.value = false;
  }

  void filter(){
    if (state.tecSearch!.text.isEmpty || state.tecSearch!.text.length == 0){
      pilihKontrak.value.data = realKontrak.data;
      jmlRow.value = realKontrak.data!.length;
    }else{
      var tmp = realKontrak.data;
      var filtered = tmp!.where(
              (x) => x.aGRMNTNO!.toLowerCase().contains(state.tecSearch!.text.toLowerCase())
      ).toList();
      pilihKontrak.value.data = filtered;
      jmlRow.value = pilihKontrak.value.data!.length;
    }

  }

}