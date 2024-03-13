import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/model/api/EpolisRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/model/api/PilihkontrakRespon.dart';
import 'package:jmcare/model/sqlite/entity/Epolis.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pilihkontrak/state.dart';
import 'package:jmcare/service/DownloadepolisService.dart';
import 'package:jmcare/service/EpolisService.dart';
import 'package:jmcare/service/PilihkontrakService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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

    //get argumen dari screen sebelumnya
    state.rute = Get.arguments['detail'];
    getListKontrak();
    var a = state.databaseHelper?.getEpolis();

    a?.then((value) {
      state.jmlEpolis = value.length;
      debugPrint('jml epolis ' + value.length.toString());
    });


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
    //dialog untuk permission storage
    // var status = await Permission.storage.request();
    // var statusManageExternalStorage = await Permission.manageExternalStorage.request();
    var statusStorage = await Permission.storage.request();
    // var statusAccessML = await Permission.accessMediaLocation.request();

    if (statusStorage.isDenied){
      Fungsi.errorToast("Akses storage harus diizinkan!");
    }else{
      is_download.value = true;
      final String agreementNo = pilihKontrak.value.data![index].aGRMNTNO!;
      final authStorage = await getStorage<LoginRespon>();
      final String login_id = authStorage.data!.loginUserId!;
      //cek apakah sudah pernah download epolis atau belum
      final jumlah = await state.databaseHelper!.selectEpolis(agreementNo);
      //jika belum pernah download
      if (jumlah == 0){
        //download link api
        final epolis = await getService<EpolisService>()?.getEpolis(agreementNo, login_id);
        if (epolis is EpolisError){
          Fungsi.errorToast("Gagal mendapatkan epolis!");
        }else{
          var dt = DateTime.now().millisecondsSinceEpoch;
          final String suffix = dt.toString();
          final String namaFile = "Epolis-$suffix.pdf";
          if (epolis!.fileurl == null){
            Fungsi.errorToast("File URL on JSON is null!");
          }else{
            await getService<DownloadepolisService>()!.downloadEpolis(epolis!.fileurl!, namaFile).then(
                    (value) async {

                  Fungsi.suksesToast("File berhasil diunduh di folder Download!");
                  //simpan file URL di storage
                  Directory? dir;
                  try {
                    if (Platform.isIOS) {
                      dir = await getApplicationDocumentsDirectory(); // for iOS
                    } else {
                      dir = Directory('/storage/emulated/0/Download/') ;  // for android
                      if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
                      //simpan nomor agreement di sqlite
                      saveSqlite(agreementNo,"/storage/emulated/0/Download/" + namaFile);
                      OpenFile.open("/storage/emulated/0/Download/" + namaFile, type: "application/pdf");
                    }
                  } catch (err) {
                    Fungsi.errorToast("Cannot get download folder path $err");
                  }
                }
            );
          }
        }
      }else{
        Fungsi.warningToast("File sudah ada di folder Download!");
        var filepath = await state.databaseHelper!.getFilepath(agreementNo);
        debugPrint('filepath ' + filepath);
        OpenFile.open(filepath, type: "application/pdf");
      }
      is_download.value = false;
    }
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

  void saveSqlite(String agreement_no, String filepath){
    DateTime now = DateTime.now();
    state.epolis = Epolis(
        agreement_no: agreement_no,
        filepath: filepath,
        create_date: now.millisecondsSinceEpoch.toString()
    );
    state.databaseHelper!.insertEpolis(state.epolis!);
  }
}