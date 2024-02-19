
import 'package:jmcare/helper/Konstan.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/pilihregister/state.dart';


class PilihRegisterLogic extends GetxController{

  final PilihRegisterState state = PilihRegisterState();

  @override
  void onInit() {
    super.onInit();
  }

  void gotoRegisterDebitur(){
    Get.toNamed(Konstan.rute_register_debitur);
  }

  void gotoRegisterNonDebitur(){
    Get.toNamed(Konstan.rute_register_nondebitur);
  }

}
