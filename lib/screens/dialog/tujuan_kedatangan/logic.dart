import 'dart:convert';
import 'package:get/get.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/dialog/tujuan_kedatangan/state.dart';
import '../../../helper/Fungsi.dart';
import '../../../model/api/KategoriRespon.dart';
import '../../../service/KategoriService.dart';
import '../../../service/Service.dart';

class TujuankedatanganLogic extends BaseLogic {
  final TujuankedatanganState state = TujuankedatanganState();
  var kategoris = KategoriRespon().obs;
  var realKategoris = KategoriRespon();
  var jmlRow = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getKategori();
  }

  void getKategori() async {
    is_loading.value = true;
    //untuk get param yang dilemparkan ke dalam screen dialog tujuan kedatangan
    //lihat di fungsi tapTujuanKedatangan di file logic.dart pada folder antrian
    final jenisPIC = Get.arguments[Konstan.tag_jenis_pic];
    final kategoriRespon = await getService<KategoriService>()?.getKategori(jenisPIC);
    if (kategoriRespon is KategoriError) {
      Fungsi.errorToast("Tidak dapat memproses data tujuan kedatangan");
      jmlRow.value = 0;
    } else {
      kategoris.value = kategoriRespon!;
      realKategoris.data = kategoriRespon.data;
      jmlRow.value = kategoris.value.data!.length;
      is_loading.value = false;
    }
  }

  void filter(){
    if (state.tecSearch!.text.isEmpty || state.tecSearch!.text.length == 0){
      kategoris.value.data = realKategoris.data;
      jmlRow.value = realKategoris.data!.length;
    }else{
      var tmp = realKategoris.data;
      var filtered = tmp!.where(
              (x) => x.kATEGORI!.toLowerCase().contains(state.tecSearch!.text.toLowerCase())
      ).toList();
      kategoris.value.data = filtered;
      jmlRow.value = kategoris.value.data!.length;
    }
  }

  void tapListView(int index){
    //klik dalam listview tujuan kedatangan, akan close dialog tujuan kedatangan
    //lalu balik ke screen antrian dengan membawa
    //parameter kategori pada index listview yang diklik
    var data = kategoris.value.data![index];
    final String jsonString = jsonEncode(data);
    Get.back(result: jsonString);
  }
}