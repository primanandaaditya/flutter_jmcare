import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:ui';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pengkiniandata/state.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:jmcare/model/api/WilayahRespon.dart' as wr;
import 'package:jmcare/model/api/JmoRespon.dart' as jr;

class PengkiniandataLogic extends BaseLogic {

  final PengkiniandataState state = PengkiniandataState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    askPermission();
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
    }else{
      state.imageProfil = File(image!.path);
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
        id_payload = state.selected_id_propinsi;
        break;
      case Konstan.tag_kecamatan:
        id_payload = state.selected_id_kabupaten;
        break;
      case Konstan.tag_kelurahan:
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
  void handleSignature() async {
    final data = await state.signatureGlobalKey!.currentState!.toImage(pixelRatio: 2.0);
    final bytes = await data.toByteData(format: ImageByteFormat.png);
    final a = bytes!.buffer.asUint8List();
    state.base64_tandatangan = base64Encode(a);
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
  void submit(){
    handleSignature();
  }
}