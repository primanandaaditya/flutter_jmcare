import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:io';

class PengkiniandataState {
  ImagePicker? imagePicker;
  File? imageKTP;
  File? imageProfil;
  GlobalKey<FormState>? formKey;
  GlobalKey<SfSignaturePadState>? signatureGlobalKey;
  TextEditingController? tecNama;
  TextEditingController? tecNIK;
  TextEditingController? tecTempatlahir;
  TextEditingController? tecTgllahir;
  TextEditingController? tecNPWP;
  TextEditingController? tecNamaibukandung;
  TextEditingController? tecPendidikan;
  TextEditingController? tecStatusnikah;
  TextEditingController? tecHP;
  TextEditingController? tecJumlahtanggungan;
  List<String> options_kewarganegaraan = ["WNI","WNA"];
  String current_option_kewarganegaraan = "";
  String base64_ktp = "";
  String base64_profil = "";
  String base64_tandatangan = "";
  TextEditingController? tecAlamat;
  TextEditingController? tecRT;
  TextEditingController? tecRW;
  TextEditingController? tecPropinsi;
  TextEditingController? tecKabupaten;
  TextEditingController? tecKecamatan;
  TextEditingController? tecKelurahan;
  TextEditingController? tecPekerjaan;
  TextEditingController? tecAlamatkantor;
  TextEditingController? tecTelpkantor;
  bool cekBersedia = false;
  bool cekPernyataan = false;
  bool is_check_penawaran = false;
  bool is_check_pernyataan = false;
  String title_pernyataan = "Demikian pernyataan ini saya buat dengan sebenarnya dan penuh rasa tanggung jawab. Apabila dikemudian hari ditemukan bahwa data/dokumen yang saya sampaikan tidak benar dan/atau ada pemalsuan, maka seluruh keputusan yang telah ditetapkan berdasarkan berkas tersebut batal berdasarkan hukum dan saya bersedia dikenakan sanksi sesuai ketentuan peraturan perundang-undangan yang berlaku.";

  int selected_id_propinsi = 0;
  int selected_id_kabupaten = 0;
  int selected_id_kecamatan = 0;
  int selected_id_kelurahan = 0;

  String selected_id_status_nikah = "";
  String selected_id_pendidikan = "";
  String selected_id_jenis_pekerjaan = "";

  PengkiniandataState(){
    imagePicker = ImagePicker();
    formKey = GlobalKey<FormState>();
    signatureGlobalKey = GlobalKey();
    tecNama = TextEditingController();
    tecNIK = TextEditingController();
    tecTempatlahir = TextEditingController();
    tecTgllahir = TextEditingController();
    tecNPWP = TextEditingController();
    tecNamaibukandung = TextEditingController();
    tecPendidikan = TextEditingController();
    tecStatusnikah = TextEditingController();
    tecHP = TextEditingController();
    tecJumlahtanggungan = TextEditingController();
    tecAlamat = TextEditingController();
    tecRT = TextEditingController();
    tecRW= TextEditingController();
    tecPropinsi = TextEditingController();
    tecKabupaten = TextEditingController();
    tecKecamatan = TextEditingController();
    tecKelurahan = TextEditingController();
    tecPekerjaan = TextEditingController();
    tecAlamatkantor = TextEditingController();
    tecTelpkantor = TextEditingController();
    current_option_kewarganegaraan = options_kewarganegaraan[0];
  }
}