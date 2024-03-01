import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/model/api/PaginationuserRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/searchuser/state.dart';
import 'package:jmcare/service/SearchuserService.dart';
import 'package:jmcare/service/Service.dart';

class SearchuserLogic extends BaseLogic{
  final SearchuserState state = SearchuserState();
  var paginationuserRespon = PaginationuserRespon().obs;

  @override
  void onInit() {
    super.onInit();

  }

  void searchUser(String nama) async {
    is_loading.value = true;
    final paginationuser = await getService<SearchuserService>()?.getUser(nama);
    if (paginationuser is PaginationuserError || paginationuser == null){
      Fungsi.errorToast("Gagal memperoleh data user!");
    }else{
      paginationuserRespon.value.data = paginationuser.data;
    }
    is_loading.value = false;
  }
}
