import 'dart:convert';
import 'package:get/get.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/KategoriRespon.dart';
import 'package:jmcare/screens/antrian/state.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:flutter/material.dart';
import 'package:jmcare/service/KategoriService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../helper/Fungsi.dart';
import '../../model/api/LoginRespon.dart';
import '../../model/api/PilihkontrakRespon.dart';
import '../../service/PilihkontrakService.dart';
import '../../storage/storage.dart';
import 'package:intl/intl.dart';
import '../../model/api/KategoriRespon.dart' as modelKategori;
import '../../model/api/CabangRespon.dart' as modelCabang;

class AntrianLogic extends BaseLogic{
  final AntrianState state = AntrianState();
  var ddNomorKontrak = List<DropdownMenuItem>.empty(growable: true).obs;
  var idxDdNomorKontrak = "".obs;
  var jmlRow = 0.obs;
  var pilihKontrak = PilihkontrakRespon().obs;
  var realKontrak = PilihkontrakRespon();
  var ddKategori = List<DropdownMenuItem>.empty(growable: true).obs;
  var idxDDKategori = "".obs;

  @override
  void onInit() {
    super.onInit();
    //fill dropdown nomor kontrak dari API
    getListKontrak();
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

      //get array pertama, untuk get nomor kontrak pertama
      //asign pada var idxDdNomorKontrak
      if (realKontrak.data!.isNotEmpty){
        final kontrakPertama = realKontrak.data!.first;
        idxDdNomorKontrak.value = kontrakPertama.aGRMNTNO!;
        state.tecNama!.text = kontrakPertama.cUSTFULLNAME!;
        state.tecNomorPlat!.text = kontrakPertama.pLATNO!;
        state.branch_id = kontrakPertama.oFFICECODE!; //waktu pertama kali load list kontrak, langsung assign var ke office codenya
      }

      //tambahkan ke dropdown
      realKontrak.data?.forEach((e) {
        ddNomorKontrak.add(DropdownMenuItem(
          value: e.aGRMNTNO,
            child: Text(e.aGRMNTNO!))
        );
      });
    }
    is_loading.value = false;
  }

  void setDDNomorKontrak(String newValue){
    //set id dropdown
    idxDdNomorKontrak.value = newValue;
    //set nama dan nomor plat
    final cari = realKontrak.data!.where((x) => x.aGRMNTNO == newValue);
    if (cari.isNotEmpty || cari != null){
      final p = cari.first;
      state.tecNama!.text = p.cUSTFULLNAME!;
      state.tecNomorPlat!.text = p.pLATNO!;
      state.branch_id = p.oFFICECODE!;
    }else{
      state.tecNama!.text = "";
      state.tecNomorPlat!.text = "";
      state.branch_id = "";
    }
  }

  void tapTanggal(BuildContext context){
    
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(state.sekarang.year, state.sekarang.month, state.sekarang.day),
        onChanged: (date) {
          setTanggal(date);
        },
        onConfirm: (date) {
          setTanggal(date);
        },
        currentTime: DateTime.now(), locale: LocaleType.en);
  }

  void tapJam(BuildContext context){
    DatePicker.showTimePicker(
        context,
      showTitleActions: true,
      onConfirm: (a){
          setJam(a);
      }
    );
  }

  void setTanggal(DateTime date){
    //jika memilih hari Minggu
    if (date.weekday == 7){
      Fungsi.warningToast("Mohon memilih hari Senin s/d Sabtu");
      state.tanggalKedatangan = "";
      state.tecTanggal!.text = "";
      state.tecJam!.text = "";
      return;
    }

    //jika memilih hari Sabtu
    if (date.weekday == 6){
      state.isSaturday = true;
    }else{
      state.isSaturday = false;
    }

    state.tecTanggal!.text = DateFormat("dd MMM yyyy").format(date);
    state.tanggalKedatangan = DateFormat("yyyy-MM-dd").format(date);
    state.tecJam!.text = "";
    debugPrint(state.tanggalKedatangan);
  }

  void setJam(DateTime date){
    if (state.tecTanggal!.text.isEmpty || state.tanggalKedatangan.isEmpty){
      Fungsi.warningToast("Tanggal harus diisi");
      return;
    }else{
      state.tecJam!.text = DateFormat("hh:mm").format(date);
    }

    //cek apakah jam sudah lewat
    final jamSekarang = state.sekarang.hour;
    final menitSekarang = state.sekarang.minute;
    if (date.hour < jamSekarang || (date.hour == jamSekarang && date.minute < menitSekarang)){
      Fungsi.warningToast("Jam sudah lewat tidak dapat dipilih");
      state.tecJam!.text = "";
      return;
    }

    //jika hari yang dipilih Sabtu, maksimal jam 11.30
    String strMenit = "";
    String concatJamMenit = "";
    int intJamMenit = 0;
    if (state.isSaturday){
      //jadikan concat string jam dan menit
      //kalau menit 1 s/d 9, tambahkan 0 di depannya
      if (date.minute < 10){
        strMenit = "0" + date.minute.toString();
      }else{
        strMenit = date.minute.toString();
      }
      //gabungkan string jam dan menit
      concatJamMenit = date.hour.toString() + strMenit;
      //jadikan integer (misalnya jam 11.46 akan menjadi 1146, jam 9.03 menjadi 903)
      intJamMenit = int.parse(concatJamMenit);
      if ((intJamMenit) >= 1130){
        Fungsi.warningToast("Hari Sabtu maksimal jam 11.30");
        state.tecJam!.text = "11.30";
        return;
      }else{
        //jika belum jam 11.30 siang
        state.tecJam!.text = DateFormat("hh:mm").format(date);
      }
    }else{
      //jika hari Senin s/d Jumat
      if (date.hour == 15 && date.minute > 30){
        Fungsi.warningToast("Harap memilih sebelum jam 15.30");
        state.tecJam!.text = "";
        return;
      }else{

      }

      //jika memilih antara jam 8 pagi s/d jam 3
      if (date.hour >= 8 && date.hour <= 15){
        state.tecJam!.text = DateFormat("hh:mm").format(date);
      }else{
        Fungsi.warningToast("Harap memilih jam antara 8.00 s/d 15.30");
        state.tecJam!.text = "";
      }
    }

  }

  void setDDpic(String newValue){
    state.idxKasir = newValue;
    state.tecTujuanKedatangan!.text = "";
    state.idTujuanKedatangan = "";
  }

  void tapPilihCabang() async {
    if (state.tecTujuanKedatangan!.text.isEmpty){
      Fungsi.warningToast("Tujuan kedatangan harus diisi terlebih dahulu");
      return;
    }
    if (idxDdNomorKontrak.value.isEmpty){
      Fungsi.warningToast("Nomor kontrak harus dipilih terlebih dahulu");
      return;
    }
    //saat textfield pilih cabang di-tap, akan muncul dialog list cabang
    //pakai async/await untuk menunggu user klik listview di screen dialog list cabang
    //======================================================================================
    //lemparkan parameter untuk ditangkap di screen dialog list cabang
    //untuk difilter, karena kalau isBranch = 1, list-nya harus di-filter berdasarkan var kode_cabang_asal_kontrak
    //=====================================================================================
    debugPrint("is branch " + state.isBranch);
    debugPrint("selected branch " + state.branch_id);
    final result = await Get.toNamed(Konstan.rute_dialog_cabang,
        arguments: {
          Konstan.tag_is_branch       : state.isBranch,
          Konstan.tag_selected_branch : state.branch_id
        }
    );
    if ("$result" == null){
      debugPrint("cabang tujuan not selected");
    }else{
      //ubah var result menjadi model cabang
      final cabangMap = jsonDecode("$result") as Map<String,dynamic>;
      final cabang = modelCabang.Data.fromJson(cabangMap);

      state.tecCabangTujuan!.text = cabang.oFFICENAME!;
      state.idCabangTujuan = cabang.oFFICECODE!;
      debugPrint("cabang tujuan " + state.tecCabangTujuan!.text + " " + state.idCabangTujuan);
    }


  }

  void tapTujuanKedatangan() async {
    debugPrint('pic terpilih ' + state.idxKasir);
    //saat textfield tujuankedatangan di-tap, akan muncul dialog tujuan kedatangan
    //pakai async/await untuk menunggu user klik listview di screen dialog tujuan kedatangan
    //======================================================================================
    //lemparkan parameter untuk ditangkap di screen dialog TujuanKedatangan
    //sebagai parameter untuk hit api
    //lihat di fungsi getKategori di file logic.dart di folder dialog/tujuankedatangan
    //=====================================================================================
    final result = await Get.toNamed(Konstan.rute_tujuan_kedatangan,
        arguments: {
          Konstan.tag_jenis_pic       : state.idxKasir
        }
    );
    if ("$result" == null){
      debugPrint("tujuan kedatangan not selected");
    }else{
      //ubah var result menjadi model kategori
      final kategoriMap = jsonDecode("$result") as Map<String,dynamic>;
      final kategori = modelKategori.Data.fromJson(kategoriMap);
      state.tecTujuanKedatangan!.text = kategori.kATEGORI.toString();
      state.idTujuanKedatangan = kategori.iDKATEGORI.toString();
      state.isBranch = kategori.iSBRANCH.toString();
    }

  }

}



