
import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'dart:convert';
import 'dart:ui';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pengkiniandata/state.dart';
import 'package:jmcare/service/PengkiniandataService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:jmcare/model/api/WilayahRespon.dart' as wr;
import 'package:jmcare/model/api/JmoRespon.dart' as jr;
import '../../storage/storage.dart';

class PengkiniandataLogic extends BaseLogic {

  final PengkiniandataState state = PengkiniandataState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    askPermission();
    getDetail();
  }

  void getDetail() async {
    final auth = await getStorage<LoginRespon>();
    state.tecNama!.text = auth.data!.namaUser!;
    state.tecNIK!.text = auth.data!.noKtp!;
    state.tecTempatlahir!.text = auth.data!.tempatLahir!;
    state.tecTgllahir!.text = auth.data!.tglLahir!;
    state.tecNPWP!.text = auth.data!.npwp!;
    state.tecNamaibukandung!.text = auth.data!.namaIbuKandung!;
    state.tecPendidikan!.text = auth.data!.pendidikanTerakhir!;
    state.tecStatusnikah!.text = auth.data!.statusPernikahan!;
    state.tecHP!.text = auth.data!.noHp!;
    state.tecJumlahtanggungan!.text = auth.data!.jumlahTanggungan!;
    state.tecAlamat!.text = auth.data!.alamat!;
    state.tecRT!.text = auth.data!.alamatRt!;
    state.tecRW!.text = auth.data!.alamatRw!;
    state.tecPropinsi!.text = auth.data!.provinsi!;
    state.tecKabupaten!.text = auth.data!.kabupaten!;
    state.tecKecamatan!.text = auth.data!.kecamatan!;
    state.tecKelurahan!.text = auth.data!.kelurahan!;
    state.tecPekerjaan!.text = auth.data!.pekerjaan!;
    state.tecAlamatkantor!.text = auth.data!.alamatKantor!;
    state.tecTelpkantor!.text = auth.data!.telpKantor!;
    state.current_option_kewarganegaraan = (auth.data!.kewarganegaraan! == "WNI") ?
      state.options_kewarganegaraan[0] : state.options_kewarganegaraan[1];

  }

  void askPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage
    ].request();
  }

  void showPicker(BuildContext context, String jenis) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child:  Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Galeri'),
                    onTap: () {
                      pickImage(jenis, ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Kamera'),
                  onTap: () {
                    pickImage(jenis, ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
    );
  }


  Future pickImage(String jenis, ImageSource sumber) async {
    var image = await state.imagePicker!.pickImage(source: sumber);
    if (jenis == "KTP"){
      state.imageKTP = File(image!.path);
      final kompres = await FlutterImageCompress.compressWithFile(
          state.imageKTP!.absolute.path,
          quality: 50,
          rotate: 0
      );
      final a = kompres!.toList();
      state.base64_ktp = base64Encode(a);
    }else{
      state.imageProfil = File(image!.path);
      final kompres = await FlutterImageCompress.compressWithFile(
          state.imageKTP!.absolute.path,
          quality: 50,
          rotate: 0
      );
      final a = kompres!.toList();
      state.base64_profil = base64Encode(a);
    }
    update();
  }

  void dialogJMO(String jenis) async {
    final result = await Get.toNamed(
        Konstan.rute_dialog_jmo,
        arguments: {"jenis":jenis}
    );

    if ("$result" == null || "$result".isEmpty){

    }else{
      try{
        debugPrint("$result");
        //variabel selected dihasilkan dari screen dialog jmo yang diklik dari listview
        final selected = jr.Data.fromJson(jsonDecode("$result"));
        switch (jenis){
          case Konstan.tag_status_nikah:
            state.tecStatusnikah!.text = selected.nama == null ? selected.name! : selected.nama!;
            state.selected_id_status_nikah = selected.id!.toString();
            break;
          case Konstan.tag_pendidikan:
            state.tecPendidikan!.text =  selected.nama == null ? selected.name! : selected.nama!;
            state.selected_id_pendidikan = selected.id!.toString();
            break;
          case Konstan.tag_jenis_pekerjaan:
            state.tecPekerjaan!.text =  selected.nama == null ? selected.name! : selected.nama!;
            state.selected_id_jenis_pekerjaan = selected.id!.toString();
            break;
          default:
            state.tecStatusnikah!.text =  selected.nama == null ? selected.name! : selected.nama!;
            state.selected_id_status_nikah = selected.id!.toString();
            break;
        }
      }catch (e){
        debugPrint("tidak ada yang dipilih");
      }
    }
  }

  void dialogWilayah(String jenis) async {
    //variabel ini digunakan untuk mengisi param id_master
    //kalau user klik dropdown propinsi, id_payload = 0
    //kalau user klik dropdown kabupaten, id_payload = selected_id_propinsi
    //kalau user klik dropdown kecamatan, id_payload = selected_id_kabupaten
    //kalau user klik dropdown kelurahan, id_payload = selected_id_kecamatan
    int id_payload;
    switch (jenis){
      case Konstan.tag_propinsi:
        id_payload = 0;
        break;
      case Konstan.tag_kabupaten:
        if (state.tecPropinsi!.text.isEmpty){
          Fungsi.warningToast("Propinsi belum dipilih");
          return;
        }
        id_payload = state.selected_id_propinsi;
        break;
      case Konstan.tag_kecamatan:
        if (state.tecKabupaten!.text.isEmpty){
          Fungsi.warningToast("Kabupaten belum dipilih");
          return;
        }
        id_payload = state.selected_id_kabupaten;
        break;
      case Konstan.tag_kelurahan:
        if (state.tecKecamatan!.text.isEmpty){
          Fungsi.warningToast("Kecamatan belum dipilih");
          return;
        }
        id_payload = state.selected_id_kecamatan;
        break;
      default:
        id_payload = 0;
        break;
    }
    final result = await Get.toNamed(
        Konstan.rute_dialog_wilayah,
        arguments: {"jenis":jenis,"id_master":id_payload}
    );

    if ("$result" == null || "$result".isEmpty){

    }else{
      try{
        debugPrint("$result");
        //variabel selected dihasilkan dari screen dialog wilayah yang diklik dari listview
        final selected = wr.Data.fromJson(jsonDecode("$result"));
        switch (jenis){
          case Konstan.tag_propinsi:
            state.tecPropinsi!.text = selected.nama!;
            state.selected_id_propinsi = selected.id!;
            state.selected_id_kabupaten = 0;
            state.selected_id_kecamatan = 0;
            state.selected_id_kelurahan = 0;
            state.tecKabupaten!.text = "";
            state.tecKecamatan!.text = "";
            state.tecKelurahan!.text = "";
            break;
          case Konstan.tag_kabupaten:
            state.tecKabupaten!.text = selected.nama!;
            state.selected_id_kabupaten = selected.id!;
            state.selected_id_kecamatan = 0;
            state.selected_id_kelurahan = 0;
            state.tecKecamatan!.text = "";
            state.tecKelurahan!.text = "";
            break;
          case Konstan.tag_kecamatan:
            state.tecKecamatan!.text = selected.nama!;
            state.selected_id_kecamatan = selected.id!;
            state.selected_id_kelurahan = 0;
            state.tecKelurahan!.text = "";
            break;
          case Konstan.tag_kelurahan:
            state.tecKelurahan!.text = selected.nama!;
            state.selected_id_kelurahan = selected.id!;
            break;
          default:
            state.tecPropinsi!.text = selected.nama!;
            state.selected_id_propinsi = selected.id!;
            state.selected_id_kabupaten = 0;
            state.selected_id_kecamatan = 0;
            state.selected_id_kelurahan = 0;
            state.tecKabupaten!.text = "";
            state.tecKecamatan!.text = "";
            state.tecKelurahan!.text = "";
            break;
        }
      }catch (e){
        debugPrint("tidak ada yang dipilih");
      }
    }
  }

  void clearFoto(String jenis){
    if (jenis == "KTP"){
      state.imageKTP = null;
    }else{
      state.imageProfil = null;
    }
    update();
  }

  void clearSignature(){
    state.signatureGlobalKey!.currentState!.clear();
  }

  Future<String> handleSignature() async {
    final data = await state.signatureGlobalKey!.currentState!.toImage(pixelRatio: 2.0);
    final bytes = await data.toByteData(format: ImageByteFormat.png);
    final a =  bytes!.buffer.asUint8List();
    String hasil = base64Encode(a);
    return hasil;
  }

  void handleOptionKewarganegaraan(String newValue){
    state.current_option_kewarganegaraan = newValue;
    update();
  }

  void handleCekpenawaran(bool newValue){
    state.is_check_penawaran = newValue;
    update();
  }

  void handleCekpernyataan(bool newValue){
    state.is_check_pernyataan = newValue;
    update();
  }

  void submit() async {

    //get string base64 dari tandatangan
    state.base64_tandatangan = await handleSignature();

    if (state.tecNPWP!.text == ""){
      Fungsi.errorToast("NPWP belum diisi!");
      return;
    }
    if (state.tecNamaibukandung!.text.isEmpty){
      Fungsi.errorToast("Nama ibu kandung belum diisi!");
      return;
    }
    if (state.tecPendidikan!.text.isEmpty){
      Fungsi.errorToast("Pendidikan belum diisi!");
      return;
    }
    if (state.tecStatusnikah!.text.isEmpty){
      Fungsi.errorToast("Status pernikahan belum diisi!");
      return;
    }
    if (state.tecHP!.text.isEmpty){
      Fungsi.errorToast("Nomor HP belum diisi!");
      return;
    }
    if (state.tecJumlahtanggungan!.text.isEmpty){
      Fungsi.errorToast("Jumlah tanggungan belum diisi!");
      return;
    }
    if (state.tecAlamat!.text.isEmpty){
      Fungsi.errorToast("Alamat belum diisi!");
      return;
    }
    if (state.tecRT!.text.isEmpty || state.tecRW!.text.isEmpty){
      Fungsi.errorToast("RT/RW belum diisi!");
      return;
    }
    if (state.tecPropinsi!.text.isEmpty){
      Fungsi.errorToast("Propinsi belum diisi!");
      return;
    }
    if (state.tecKabupaten!.text.isEmpty){
      Fungsi.errorToast("Kabupaten belum diisi!");
      return;
    }
    if (state.tecKecamatan!.text.isEmpty){
      Fungsi.errorToast("Kecamatan belum diisi!");
      return;
    }
    if (state.tecKelurahan!.text.isEmpty){
      Fungsi.errorToast("Kelurahan belum diisi!");
      return;
    }
    if (state.tecPekerjaan!.text.isEmpty){
      Fungsi.errorToast("Pekerjaan belum diisi!");
      return;
    }
    if (state.tecAlamatkantor!.text.isEmpty){
      Fungsi.errorToast("Alamat kantor belum diisi!");
      return;
    }
    if (state.tecTelpkantor!.text.isEmpty){
      Fungsi.errorToast("No. telepon kantor belum diisi!");
      return;
    }
    if (state.base64_ktp.isEmpty){
      Fungsi.errorToast("Foto KTP belum diambil!");
      return;
    }
    if (state.base64_profil.isEmpty){
      Fungsi.errorToast("Foto profil belum diambil!");
      return;
    }
    if (state.base64_tandatangan.isEmpty){
      Fungsi.errorToast("Tanda tangan belum dilakukan!");
      return;
    }
    if (state.is_check_pernyataan == false){
      Fungsi.errorToast("Pernyataan belum dicentang!");
      return;
    }

    is_loading.value = true;
    //get detail user yang login
    final auth = await getStorage<LoginRespon>();
    final user = auth.data!;
    final baseRespon = await getService<PengkiniandataService>()?.doPengkinian(
        user.loginUserId!, state.tecNIK!.text, state.tecNama!.text, state.tecAlamat!.text,
        state.tecHP!.text, state.tecTempatlahir!.text, state.tecTgllahir!.text,
        state.tecPekerjaan!.text, state.tecRT!.text, state.tecRW!.text,
        state.tecKelurahan!.text, state.tecKecamatan!.text, state.tecKabupaten!.text, state.tecPropinsi!.text,
        state.tecNPWP!.text, state.tecNamaibukandung!.text, state.tecPendidikan!.text, state.tecStatusnikah!.text,
        state.tecJumlahtanggungan!.text, state.tecAlamatkantor!.text, state.tecTelpkantor!.text, state.cekBersedia ? "1" : "0",
        state.current_option_kewarganegaraan, state.base64_ktp, state.base64_profil, state.base64_tandatangan
    );
    if (baseRespon is BaseError){
      Fungsi.errorToast("Tidak dapat memproses pengkinian data");
    }else{
      Get.back();
      Fungsi.suksesToast("Pengkinian data berhasil diproses!");
    }
    is_loading.value = false;
  }
}