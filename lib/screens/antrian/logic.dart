import 'dart:convert';
import 'package:get/get.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/api/RiwayatantrianRespon.dart';
import 'package:jmcare/screens/antrian/state.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:flutter/material.dart';
import 'package:jmcare/service/AddantrianService.dart';
import 'package:jmcare/service/AntriansekarangService.dart';
import 'package:jmcare/service/RiwayatantrianService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../helper/Fungsi.dart';
import '../../model/api/AntriansekarangRespon.dart';
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
  var loadSubmit = false.obs;
  // String userID = "";
  String isDebitur = "";
  String nama = "";
  var obsIsDebitur = false.obs;
  var riwayats = RiwayatantrianRespon().obs;
  var obsAntrianSekarang = AntriansekarangRespon().obs;
  var obsRowcountAntriansekarang = 0.obs;
  var obsNoAntrianAnda = "".obs;
  var obsSisaAntrian = 0.obs;

  @override
  void onInit() {
    super.onInit();
    //get selected index buat defaulttab controller
    state.selected_index = Get.arguments[Konstan.tag_selected_index];
    //fill dropdown nomor kontrak dari API
    getListKontrak();
    //get identitas user
    getDetailUser();
    //get riwayat antrian
    getRiwayatAntrian();
    //get antrian sekarang
    getAntrianSekarang();
  }

  void getDetailUser() async {
    final authStorage = await getStorage<LoginRespon>();
    state.userID = authStorage.data!.loginUserId!;
    isDebitur = authStorage.data!.jenisdebitur!;
    nama = authStorage.data!.namaUser!;
    if (isDebitur.replaceAll(" ", "") == "1"){
      obsIsDebitur.value = true;
    }else{
      obsIsDebitur.value = false;
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
    //tapi cek dulu apakah tanggal yang dipilih itu sama dengan hari ini
    if (DateFormat("yyyy-MM-dd").format(date) == state.tanggalKedatangan){
      final jamSekarang = state.sekarang.hour;
      final menitSekarang = state.sekarang.minute;
      if (date.hour < jamSekarang || (date.hour == jamSekarang && date.minute < menitSekarang)){
        Fungsi.warningToast("Jam sudah lewat tidak dapat dipilih");
        state.tecJam!.text = "";
        return;
      }
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

  void tapPilihCabang() async {
    if (state.tecTujuanKedatangan!.text.isEmpty){
      Fungsi.warningToast("Tujuan kedatangan harus diisi terlebih dahulu");
      return;
    }
    if (obsIsDebitur.value == true){
      if (idxDdNomorKontrak.value.isEmpty){
        Fungsi.warningToast("Nomor kontrak harus dipilih terlebih dahulu");
        return;
      }
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
      state.branch_id = cabang.oFFICECODE!;
      debugPrint("cabang tujuan " + state.tecCabangTujuan!.text + " " + state.idCabangTujuan);
    }
  }

  void submitAntrian(BuildContext context) async {

    loadSubmit.value = true;
    //jika debitur
    if (isDebitur.replaceAll(" ", "") == "1"){
      if (idxDdNomorKontrak.value.isEmpty){
        Fungsi.warningToast("Nomor kontrak harus dipilih");
        loadSubmit.value = false;
        return;
      }
      if (state.tecNama!.text.isEmpty || state.tecNomorPlat!.text.isEmpty){
        Fungsi.warningToast("Nama/nomor plat harus dipilih");
        loadSubmit.value = false;
        return;
      }
      if (state.tecTanggal!.text.isEmpty || state.tanggalKedatangan.isEmpty){
        Fungsi.warningToast("Tanggal harus dipilih");
        loadSubmit.value = false;
        return;
      }
      if (state.tecJam!.text.isEmpty){
        Fungsi.warningToast("Jam harus dipilih");
        loadSubmit.value = false;
        return;
      }
      if (state.idxKasir.isEmpty){
        Fungsi.warningToast("PIC tujuan harus dipilih");
        return;
      }
      if (state.idTujuanKedatangan.isEmpty){
        Fungsi.warningToast("Tujuan kedatangan harus dipilih");
        loadSubmit.value = false;
        return;
      }
      if (state.branch_id.isEmpty || state.tecCabangTujuan!.text.isEmpty){
        Fungsi.warningToast("Cabang tujuan harus dipilih");
        loadSubmit.value = false;
        return;
      }
      final baseRespon = await getService<AddantrianService>()?.addAntrian(
          state.userID,
          idxDdNomorKontrak.value.toString(),
          state.tecNama!.text.toString(),
          state.tecNama!.text.toString(),
          state.tecNomorPlat!.text.toString(),
          state.tanggalKedatangan,
          state.tecJam!.text.toString(),
          state.idxKasir,
          isDebitur.replaceAll(" ", "") == "1" ? "KONSUMEN" : "TAMU", //jika isdebitur = 1 =>konsumen, kalau bukan =>tamu
          state.idTujuanKedatangan,
          state.branch_id
      );
      loadSubmit.value = false;
      if (baseRespon is BaseError){
        Fungsi.errorToast("Tidak dapat menyimpan antrian!");
      }else{
        //tutup form, lalu kalau dialog di klik OK akan menampilkan
        //screen antrian di tab index ke - 1
        Get.back();
        showDialogNomorAntrian(baseRespon!.message!);
      }

    }else{
      //jika bukan debitur
      if (state.tecTanggal!.text.isEmpty || state.tanggalKedatangan.isEmpty){
        Fungsi.warningToast("Tanggal harus dipilih");
        loadSubmit.value = false;
        return;
      }
      if (state.tecJam!.text.isEmpty){
        Fungsi.warningToast("Jam harus dipilih");
        loadSubmit.value = false;
        return;
      }
      if (state.idxKasir.isEmpty){
        Fungsi.warningToast("PIC tujuan harus dipilih");
        return;
      }
      if (state.idTujuanKedatangan.isEmpty){
        Fungsi.warningToast("Tujuan kedatangan harus dipilih");
        loadSubmit.value = false;
        return;
      }
      if (state.branch_id.isEmpty || state.tecCabangTujuan!.text.isEmpty){
        Fungsi.warningToast("Cabang tujuan harus dipilih");
        loadSubmit.value = false;
        return;
      }
      final baseRespon = await getService<AddantrianService>()?.addAntrian(
          state.userID,
          "",
          nama,
          nama,
          "",
          state.tanggalKedatangan,
          state.tecJam!.text.toString(),
          state.idxKasir,
          isDebitur.replaceAll(" ", "") == "1" ? "KONSUMEN" : "TAMU", //jika isdebitur = 1 =>konsumen, kalau bukan =>tamu
          state.idTujuanKedatangan,
          state.branch_id
      );
      if (baseRespon is BaseError){
        Fungsi.errorToast("Tidak dapat menyimpan antrian!");
      }else{
        showDialogNomorAntrian(baseRespon!.message!);
      }
      loadSubmit.value = false;
    }
  }

  void showDialogNomorAntrian(String nomorAntrian){
    Get.dialog<bool?>(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "NOMOR ANTRIAN ANDA",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        nomorAntrian,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 25
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      const Text(
                        "Mohon konfirmasi kedatangan pada aplikasi JM CARE jika sudah tiba di kantor cabang",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Get.offAndToNamed(Konstan.rute_antrian, arguments: {Konstan.tag_selected_index:1});
                              },
                              child: const Text('OK'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getRiwayatAntrian() async {
    is_loading.value = true;

    final authStorage = await getStorage<LoginRespon>();
    state.userID = authStorage.data!.loginUserId!;
    isDebitur = authStorage.data!.jenisdebitur!;
    nama = authStorage.data!.namaUser!;

    final riwayat = await getService<RiwayatantrianService>()?.getRiwayatantrian(state.userID);
    if (riwayat is RiwayatantrianError){
      Fungsi.errorToast("Tidak dapat memproses riwayat antrian");
    }else{
      riwayats.value = riwayat!;
    }
    is_loading.value = false;
  }

  void getAntrianSekarang() async {
    is_loading.value = true;
    final authStorage = await getStorage<LoginRespon>();
    state.userID = authStorage.data!.loginUserId!;
    final antrian_sekarang = await getService<AntriansekarangService>()!.getAntrianSekarang(state.userID);
    if (antrian_sekarang is AntriansekarangError){
      Fungsi.errorToast("Tidak dapat memproses data antrian sekarang!");
    }else{
      obsAntrianSekarang.value = antrian_sekarang!;
      obsRowcountAntriansekarang.value = antrian_sekarang.data!.length;

      //cari nomor antrian Anda
      var filter = obsAntrianSekarang.value.data!.where((e) => e.iDUSERJMCARE == int.parse(state.userID));
      if (filter == null){

      }else{
        try{
          final p = filter.first;
          obsNoAntrianAnda.value = p.nOANTRIAN!;
          obsSisaAntrian.value = obsAntrianSekarang.value.data!.indexOf(p);
        }catch(e){

        }

      }
    }
    is_loading.value = false;
  }

}



