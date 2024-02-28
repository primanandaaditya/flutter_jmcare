import 'package:get/get.dart';
import 'package:jmcare/model/api/PaginationuserRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/paginationuser/state.dart';
import 'package:jmcare/service/PaginationuserService.dart';
import 'package:jmcare/service/Service.dart';

class PaginationuserLogic extends BaseLogic{
  final PaginationuserState state = PaginationuserState();
  var paginationuserRespon = PaginationuserRespon().obs;

  @override
  void onInit() {
    super.onInit();
    firstPagination();
  }

  void firstPagination() async {
    state.halaman = 1;
    loadPagination();
  }

  void loadPagination() async {
    state.halaman += 1;
    is_loading.value = true;
    final paginationuser = await getService<PaginationuserService>()?.getUser(state.halaman!);
    if (paginationuser is PaginationuserError || paginationuser == null){
      paginationuserRespon.value.data!.clear();
    }else{
      paginationuserRespon.value.data = paginationuser.data;
    }
    is_loading.value = false;
  }
}