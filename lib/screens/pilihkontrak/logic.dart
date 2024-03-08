import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/model/api/DownloadRespon.dart';
import 'package:jmcare/model/api/EpolisRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/model/api/PilihkontrakRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pilihkontrak/state.dart';
import 'package:jmcare/service/DownloadepolisService.dart';
import 'package:jmcare/service/EpolisService.dart';
import 'package:jmcare/service/PilihkontrakService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';
import 'package:path_provider/path_provider.dart';
import '../../helper/Konstan.dart';
import 'package:open_file/open_file.dart';


class PilihkontrakLogic extends BaseLogic{
  final PilihkontrakState state = PilihkontrakState();
  var pilihKontrak = PilihkontrakRespon().obs;
  var realKontrak = PilihkontrakRespon();
  var jmlRow = 0.obs;
  var is_download = false.obs;

  @override
  void onInit() {
    super.onInit();
    state.rute = Get.arguments['detail'];
    getListKontrak();
  }

  void detail(int index){
    if (state.rute == Konstan.rute_agreement_card){
      //ke screen agreement card
      Get.toNamed(
          Konstan.rute_agreement_card,
          arguments: {'detail': pilihKontrak.value.data![index].aGRMNTID}
      );
    }else{
      //download epolis
      getEpolis(index);
    }

  }

  void getEpolis(int index) async {
    is_download.value = true;

    final String agreementNo = pilihKontrak.value.data![index].aGRMNTNO!;
    final authStorage = await getStorage<LoginRespon>();
    final String login_id = authStorage.data!.loginUserId!;

    //cek apakah sudah pernah download epolis atau belum
    final epolisStorage = await getStorage<EpolisRespon>();
    //jika belum pernah download
    if (epolisStorage.data == null){

      final epolis = await getService<EpolisService>()?.getEpolis(agreementNo, login_id);
      if (epolis is EpolisError){
        Fungsi.errorToast("Gagal mendapatkan epolis!");
      }else{
        var dt = DateTime.now().millisecondsSinceEpoch;
        final String suffix = dt.toString();
        final String namaFile = "Epolis " + suffix + ".pdf";
        await getService<DownloadepolisService>()!.downloadEpolis(epolis!.fileurl!, namaFile).then(
                (value) async {
              Fungsi.suksesToast("File berhasil diunduh di folder Download!");
              //simpan di session
              EpolisRespon save = EpolisRespon(code: "200", message: "", status: "", key: "", filepath: namaFile, fileurl: "");
              baseSaveStorage(save);

              Directory? dir;
              try {
                if (Platform.isIOS) {
                  dir = await getApplicationDocumentsDirectory(); // for iOS
                } else {
                  dir = Directory('/storage/emulated/0/Download/') ;  // for android
                  if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
                  OpenFile.open("/storage/emulated/0/Download/" + namaFile);
                }
              } catch (err) {
                Fungsi.errorToast("Cannot get download folder path $err");
              }
            }
        );
      }
    }else{
      final String namaFile = epolisStorage.data!.filepath!;
      Fungsi.warningToast("File $namaFile sudah ada di folder Download!");
    }
    is_download.value = false;
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