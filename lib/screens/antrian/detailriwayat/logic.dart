import 'package:flutter/cupertino.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/screens/antrian/detailriwayat/state.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:get/get.dart';
import 'package:jmcare/service/KonfirmasikedatanganService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';


class DetailRiwayatLogic extends BaseLogic {
  final DetailriwayatState state = DetailriwayatState();
  var isFinished = "".obs;
  var sudahKuisioner = "".obs;
  var isToday = false.obs;
  var obxLat = 0.0.obs;
  var obxLong = 0.0.obs;
  var obxGpsSearching = false.obs;
  var obxJarak = 0.0.obs;
  var obxButtonKuisioner = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getIntent();
    inisialisasi();
  }

  void konfirmasiKedatangan() async {
    is_loading.value = true;
    final respon = await getService<KonfirmasikedatanganService>()?.konfirmasiKedatangan(state.id);
    if (respon is BaseError){
      Fungsi.errorToast("Tidak dapat mengkonfirmasi kedatangan");
    }else{
      Get.back();
      showDialogNomorAntrian(respon!.status!);
    }
    is_loading.value = false;
  }

  void tampilKuisioner(){
    //ke screen kuisioner dengan membawa id antrian
    Get.toNamed(Konstan.rute_kuisioner, arguments: {Konstan.tag_id_antrian: state.id} );
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
                        "Mohon menunggu sesuai nomor antrian",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Get.back();
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

  void buttonKuisioner_IsShow(){
    if (state.is_finished == "0"){
      obxButtonKuisioner.value = false;
    }else{
      if (state.sudah_kuisioner == "0"){
        obxButtonKuisioner.value = true;
      }else{
        obxButtonKuisioner.value = false;
      }
    }
  }

  void inisialisasi() async {

    final is_today = Fungsi.isToday(state.tgl);
    isToday.value = is_today;
    //jika ini hari yang sama, lalukan pengecekan GPS, api konfirmasi kedatangan/kuisioner dll
    if (is_today){
      //tentukan apakah button kuisioner muncul atau tidak
      buttonKuisioner_IsShow();
      //cari lat long posisi user
      obxGpsSearching.value = true;
      final lokasi = await initLocation();
      obxGpsSearching.value = false;
      obxLat.value = lokasi!.latitude!;
      obxLong.value = lokasi.longitude!;
      //kalau sudah dapat lat long posisi user, hitung jarak dengan kantor tujuan
      double lat_kantor_tujuan = double.parse(state.office_lat);
      double long_kantor_tujuan = double.parse(state.office_long);
      obxJarak.value = fungsi.calculateDistance(obxLat.value, obxLong.value, lat_kantor_tujuan, long_kantor_tujuan);
    }else{
      //jika ini bukan hari yang sama (bisa besok/kemarin/expired)
      //tentukan apakah button kuisioner muncul atau tidak
      buttonKuisioner_IsShow();
    }
  }


  Future<LocationData?> initLocation() async{
    state.serviceEnabled = await state.location!.serviceEnabled();
    if (!state.serviceEnabled) {
      state.serviceEnabled = await state.location!.requestService();
      if (!state.serviceEnabled) {
        // return;
      }
    }

    state.permissionGranted = await state.location!.hasPermission();
    if (state.permissionGranted == PermissionStatus.denied) {
      state.permissionGranted = await state.location!.requestPermission();
      if (state.permissionGranted != PermissionStatus.granted) {
        // return;
      }
    }
    state.locationData = await state.location!.getLocation();
    return state.locationData;
  }



  //get param dari screen riwayatantrian
  //lihat Komponen => fungsi getCardRiwayatantrian
  void getIntent(){
    state.agreement_no = Get.arguments[Konstan.tag_agreement_no];
    state.nomor_plat = Get.arguments[Konstan.tag_nomor_plat];
    state.tanggal = Get.arguments[Konstan.tag_tanggal];
    state.tgl = Get.arguments[Konstan.tag_tgl];
    state.jam = Get.arguments[Konstan.tag_jam];
    state.office_name = Get.arguments[Konstan.tag_office_name];
    state.nama = Get.arguments[Konstan.tag_nama];
    state.pic = Get.arguments[Konstan.tag_pic];
    state.tujuan = Get.arguments[Konstan.tag_tujuan];
    state.token = Get.arguments[Konstan.tag_token];
    state.id = Get.arguments[Konstan.tag_id];
    state.is_finished = Get.arguments[Konstan.tag_is_finished];
    state.konfirmasi_kedatangan = Get.arguments[Konstan.tag_konfirmasi_kedatangan];
    state.sudah_kuisioner = Get.arguments[Konstan.tag_sudah_kuisioner];
    state.office_lat = Get.arguments[Konstan.tag_office_lat];
    state.office_long = Get.arguments[Konstan.tag_office_long];

    isFinished.value = state.is_finished;
    sudahKuisioner.value = state.sudah_kuisioner;
  }
}