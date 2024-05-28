
import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/model/api/CabangRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/listcabang/state.dart';
import 'package:jmcare/service/CabangService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:maps_launcher/maps_launcher.dart';

class CabangLogic extends BaseLogic{
  final CabangState state = CabangState();
  var cabangRespon = CabangRespon().obs;
  var realCabangRespon = CabangRespon();
  var jmlRow = 0.obs;

  @override
  void onInit() {
    super.onInit();
    is_loading.value = true;
    getListCabang();
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

  void openMap(int index){
    final cR = cabangRespon.value.data![index];
    if (cR.oFFICELONG != null && cR.oFFICELAT != null){
      var office_lat = double.parse(cR.oFFICELAT!.replaceAll("\r\n", ""));
      var office_long = double.parse(cR.oFFICELONG!.replaceAll("\r\n", ""));
      MapsLauncher.launchCoordinates(office_lat, office_long);
    }else{
      Fungsi.errorToast("Tidak dapat membuka map!");
    }
  }
}