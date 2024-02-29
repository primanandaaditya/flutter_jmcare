import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/model/api/PaginationuserRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/paginationuser/state.dart';
import 'package:jmcare/service/PaginationuserService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:flutter/material.dart';

import '../../helper/Konstan.dart';

class PaginationuserLogic extends BaseLogic{
  final PaginationuserState state = PaginationuserState();
  var paginationuserRespon = PaginationuserRespon().obs;

  @override
  void onInit() {
    super.onInit();

  }

  void search(){
    Get.toNamed(Konstan.rute_search_user, arguments: {'nama': state.tecSearch!.text.toString()});
  }

  void addListen(){
    firstPagination();
    state.scrollController!.addListener(onScroll);
  }

  void onScroll(){
    state.maxScroll = state.scrollController!.position.maxScrollExtent;
    state.currentScroll = state.scrollController!.position.pixels;
    if (state.currentScroll == state.maxScroll){
      loadNextPagination();
    }
  }

  void firstPagination() async {
    state.halaman = 0;
    loadNextPagination();
  }

  void loadNextPagination() async {
    is_loading.value = true;
    state.halaman ++;
    final paginationuser = await getService<PaginationuserService>()?.getUser(state.halaman!);
    if (paginationuser is PaginationuserError || paginationuser == null){
      Fungsi.errorToast("Gagal memperoleh data user!");
      state.halaman --;
    }else{
      if (state.halaman == 1){
        paginationuserRespon.value.data = paginationuser.data;
      }else{
        paginationuserRespon.value.data!.addAll(paginationuser.data!.toList(growable: true));
        debugPrint('state halaman ' + state.halaman.toString());
      }
    }
    is_loading.value = false;
  }
}
