import 'dart:isolate';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:ui';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pengkiniandata/state.dart';
import 'package:permission_handler/permission_handler.dart';

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