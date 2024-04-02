import 'package:flutter/material.dart';

class AntrianState {

  GlobalKey<FormState>? formKey;
  TextEditingController? tecNama;
  TextEditingController? tecNomorPlat;
  TextEditingController? tecTanggal;
  TextEditingController? tecTujuanKedatangan;
  TextEditingController? tecJam;
  TextEditingController? tecCabangTujuan;

  int selected_index = 0;
  String tanggalKedatangan = "";
  DateTime sekarang = DateTime.now();
  bool isSaturday = false;
  var ddPIC = List<DropdownMenuItem>.empty(growable: true);
  String idxKasir = "KASIR";
  String tujuanKedatangan = "";
  String idTujuanKedatangan = "";
  String idCabangTujuan = "";
  String isBranch = "0";
  String branch_id = "";

  AntrianState(){
    formKey = GlobalKey<FormState>();
    tecNama = TextEditingController();
    tecNomorPlat = TextEditingController();
    tecTanggal = TextEditingController();
    tecJam = TextEditingController();
    tecTujuanKedatangan = TextEditingController();
    tecCabangTujuan = TextEditingController();

    //fill dropdown pic tujuan
    ddPIC.add(const DropdownMenuItem(
      value: "KASIR",
        child: Text("KASIR"))
    );
    ddPIC.add(const DropdownMenuItem(
        value: "CUSTOMER CARE",
        child: Text("CUSTOMER CARE"))
    );
  }
}