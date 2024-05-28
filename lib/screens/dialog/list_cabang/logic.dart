import 'dart:convert';
import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/dialog/list_cabang/state.dart';
import '../../../model/api/CabangRespon.dart';
import '../../../service/CabangService.dart';
import '../../../service/Service.dart';

class DialogcabangLogic extends BaseLogic {

  var cabangRespon = CabangRespon().obs;
  var realCabangRespon = CabangRespon();
  var jmlRow = 0.obs;
  final DialogcabangState state = DialogcabangState();

  @override
  void onInit() {
    super.onInit();
    getListCabang();
  }

  void tapListView(int index){
    //klik dalam listview dialog cabang tujuan, akan close dialog cabang
    //lalu balik ke screen antrian dengan membawa
    //parameter cabang pada index listview yang diklik
    var data = cabangRespon.value.data![index];
    final String jsonString = jsonEncode(data);
    Get.back(result: jsonString);
  }

  void getListCabang() async{
    is_loading.value = true;
    final cabanglist = await getService<CabangService>()?.getCabang();
    if (cabanglist is CabangError){
      Fungsi.errorToast("Gagal mendapatkan data cabang!");
      jmlRow.value = 0;
    }else{
      cabangRespon.value = cabanglist!;
      realCabangRespon.data = cabanglist.data;
      jmlRow.value = realCabangRespon.data!.length;

      //cek nilai is_branch yang dilemparkan dari screen form antrian
      //dari dropdown pilih nomor kontrak
      final String is_branch = Get.arguments[Konstan.tag_is_branch];
      final String selected_branch = Get.arguments[Konstan.tag_selected_branch];
      //kalau is_branch = 1 (tergantung dari nomor kontrak yang dipilih di screen form tambah antrian)
      //filter cabang berdasarkan selected branch dari screen form tambah antrian
      if (is_branch == "1"){
        var tmp = realCabangRespon.data;
        var filtered = tmp?.where(
                (x) => x.oFFICECODE.toString().toLowerCase() == selected_branch.toLowerCase()
        ).toList();
        cabangRespon.value.data = filtered;
        jmlRow.value = cabangRespon.value.data!.length;
      }
    }
    is_loading.value = false;
  }

  void filter(){
    if (state.tecSearch!.text.isEmpty){
      cabangRespon.value.data = realCabangRespon.data;
      jmlRow.value = realCabangRespon.data!.length;
    }else{
      var tmp = realCabangRespon.data;
      var filtered = tmp!.where(
              (x) => x.oFFICENAME!.toLowerCase().contains(state.tecSearch!.text)
      ).toList();
      cabangRespon.value.data = filtered;
      jmlRow.value = cabangRespon.value.data!.length;
    }
  }

}