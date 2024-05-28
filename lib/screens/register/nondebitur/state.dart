
import 'package:flutter/material.dart';
import 'package:jmcare/model/api/BaseRespon.dart';

class RegisterNonDebiturState{

  GlobalKey<FormState>? formKey;
  TextEditingController? namaController;
  TextEditingController? alamatController;
  TextEditingController? ktpController;
  TextEditingController? hpController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? ulangipasswordController;
  TextEditingController? pekerjaanController;
  TextEditingController? tempatController;
  TextEditingController? tgllahirController;
  TextEditingController? jeniskelaminController;
  List<DropdownMenuItem>? ddJenisKelamin;
  BaseRespon? baseRespon;

  RegisterNonDebiturState(){
    formKey = GlobalKey<FormState>();
    ktpController = TextEditingController();
    hpController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    ulangipasswordController = TextEditingController();
    namaController = TextEditingController();
    alamatController = TextEditingController();
    pekerjaanController = TextEditingController();
    tempatController = TextEditingController();
    tgllahirController = TextEditingController();
    jeniskelaminController = TextEditingController();
    ddJenisKelamin = List<DropdownMenuItem>.empty(growable: true);
      ddJenisKelamin?.add(const DropdownMenuItem(value: 1, child: Text("Laki-laki")));
      ddJenisKelamin?.add(const DropdownMenuItem(value: 2, child: Text("Perempuan")));
    baseRespon = BaseBegin();
  }
}
